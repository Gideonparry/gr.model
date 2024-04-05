
# Use distribution fits to find reliability targeted loads.
#=============================================================================

library(tidyverse)

### DO NOT RUN (included for reproducibility purposes) ###
# Original script has several variable selection elements. We skip all that
# and simply look at location that "passed the cut" on the first iteration.

# load("data/dist_fits.RData")
# final_st <- read_csv("data/final_table_trial.csv")
#
# dist_fits_final <- dist_fits |>
#   filter(CLUST %in% final_st$CLUST)
#
# rt_ready <- dist_fits %>%
#   tidyr::replace_na(list(SHAPE = -10))
#
# saveRDS(dist_fits_final, file = "data/dist_fits_final.RDS")

### END DO NOT RUN ###

dist_fits_final <- readRDS("data-raw/dist_fits_final.RDS")

rt_ready <- dist_fits_final %>%
  tidyr::replace_na(list(SHAPE = -10))

# Set seed for reproducibility
original_seed <- 100313

# ==============================================================================
# Step 1: Calculate reliability targeted loads.
# ==============================================================================

# Make ground to roof model
gr_data <- read_csv("data-raw/final_gr_models_08042020.csv")
usa_data <- read.csv("data-raw/usa_data.csv")

### THIS IS THE THING YOU NEED TO REPLACE
gr_model <- rtsnow::model_gr(cap = gr_data$cap[8],
                             mse = gr_data$sd[8],
                             intercept = gr_data$intercept[8],
                             slope = gr_data$slope[8],
                             lam = gr_data$transform[8],
                             flat_line = gr_data$elevation[8])
### END REPLACEMENT ###

# Prep items needed for reliability target input
# CURRENTLY ONLY LOOKING AT FIRST 100 VALUES, WILL CHANGE TO ALL VALUES
# ONCE WE KNOW IT WORKS PROPERLY
# rtl_input <- vector("list", length = nrow(rt_ready))
rtl_input <- vector("list", length = 100)
for(i in 1:length(rtl_input)){
  rtl_input[[i]] <- rt_ready[i, c("LOCATION", "SCALE", "SHAPE", "PROP_ZERO")]
}


cores <- 4

rtl_fun <- function(x, seed) {
  assign(".Random.seed", seed, envir=.GlobalEnv) # For parallel reproducibility

  loads <- rtsnow::simulate_loads(
    n = 1000000,
    loc = x[["LOCATION"]],
    scl = x[["SCALE"]],
    shp = x[["SHAPE"]],
    pr_zero = x[["PROP_ZERO"]],
    years = 50,
    gr = gr_model
  )

  rtsnow::get_rtl(tL = loads,
                  index = c(2.5, 3.0, 3.25, 3.5),
                  # Dead Load statistical Parameters (Normal)
                  nDL = 15*0.04788, #psf to kPa
                  biasDL = 1.05,
                  covDL = 0.1,
                  # Resistance Statistical Parameters (Normal)
                  # Assuming Flexural Beam Bartlette Parameters
                  biasR = 1.049,
                  covR = 0.09,
                  # Roof adjustment from the code.
                  roof_adjust = 0.7,
                  # Safety Factor
                  gl_safety = 1.0,
                  # Don't use the minimum load requirements.
                  #(Assume all roofs subject to 0.7 multiplier.)
                  minLoad = 0,
                  # Steel phi Factor
                  phi = 0.9,
                  # Number of years represented in each simulation
                  years = 50)
}

# Calculate rtl in parallel
clusters <- parallel::makeCluster(cores)

parallel::clusterEvalQ(clusters, { library(MASS); RNGkind("L'Ecuyer-CMRG") })

parallel::clusterExport(clusters,
                        c("rtl_fun", "gr_model", "gr_data"),
                        envir = environment())

# Create reproducible cluster streams.
# - https://stackoverflow.com/questions/21560363/seed-and-clusterapply-how-to-select-a-specific-run
getseeds <- function(ntasks, iseed) {
  RNGkind("L'Ecuyer-CMRG")
  set.seed(iseed)
  seeds <- vector("list", ntasks)
  seeds[[1]] <- .Random.seed
  for (i in seq_len(ntasks - 1)) {
    seeds[[i + 1]] <- parallel::nextRNGSubStream(seeds[[i]])
  }
  seeds
}

seeds <- getseeds(length(rtl_input), original_seed)

#Sys.time()
#rtl_output <- parallel::parApply(clusters, rtl_input, 1, rtl_fun)
#Sys.time()

rtl_output <- parallel::clusterMap(clusters, rtl_fun,
                                   rtl_input, seeds)

parallel::stopCluster(clusters)

rtl_output <- do.call(rbind, rtl_output)

rt_final <- rt_ready[seq_len(length(rtl_input)), ] |>
  select(CLUST) |>
  cbind(rtl_output)

colnames(rt_final) <- c("CLUST", "RT_1_new", "RT_2_new", "RT_3_new", "RT_4_new")

saveRDS(rt_final, file = "data/new_gr_rt.RDS")



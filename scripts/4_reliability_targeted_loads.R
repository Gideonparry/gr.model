
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

dist_fits_final <- readRDS("data/dist_fits_final.RDS")
gideon_dist_fits <- read_csv("data/usa_data.csv") |>
  select(CLUST, w2, est_temp_avg) |>
  rename(est_wind = w2)

dist_fits_final <- left_join(dist_fits_final, gideon_dist_fits, by = "CLUST")

# Need to remove rows that Gideon's code is not ready to handle. This includes
# stations lacking ERA5 data (559 to be precise) as well as all Tier 3 stations. 
rt_ready <- dist_fits_final |>
  filter(!is.na(SHAPE), !is.na(est_wind), !is.na(est_temp_avg))

# Set seed for reproducibility
original_seed <- 100313

# ==============================================================================
# Step 1: Calculate reliability targeted loads.
# ==============================================================================

# Read in Gideon GR function and data
source("code/gideon_gr.R")
load("data/eramod.RData")

# Prep items needed for reliability target input
rtl_input <- vector("list", length = nrow(rt_ready))
# rtl_input <- vector("list", length = 100) # use for test
for(i in 1:length(rtl_input)){
  rtl_input[[i]] <- rt_ready[i, c("LOCATION", "SCALE", "SHAPE", "PROP_ZERO",
                                  "est_wind", "est_temp_avg")]
}


cores <- 8

rtl_fun <- function(x, seed, tlm = era_both) {
  assign(".Random.seed", seed, envir=.GlobalEnv) # For parallel reproducibility
  
  tdf <- data.frame(est_wind = x[["est_wind"]],
                    est_temp_avg = x[["est_temp_avg"]])
  
  gr_model <- function(sL){
    model_gr(sL, tdf, tlm, flat_line = 0.52, sheltered = 1)
  }
  
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
                        c("rtl_fun", "model_gr",
                          "era_both"), 
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

# Test 1 is for a building that exactly follows the reliability targets.   
# saveRDS(rt_final, file = "data/new_gr_rt_test1.RDS")

# Test 2 is for buildings in exposed conditions (exposed = 1). 
# saveRDS(rt_final, file = "data/new_gr_rt_test2.RDS")

# Test 3 is for buildings in sheletered conditions (sheltered = 1). 
saveRDS(rt_final, file = "data/new_gr_rt_test3.RDS")


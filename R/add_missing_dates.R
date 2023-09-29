#' Adds missing date in data
#'
#'
#' @param df The data to add dates to
#'
#'
#' @import dplyr

add_missing_dates <- function(df) {
  # Create a sequence of dates covering the entire range
  date_range <- seq(min(df$date), max(df$date), by = "days")

  # Create a data frame with all possible dates
  all_dates <- data.frame(date = date_range)

  # Left join the original data frame with all possible dates
  result_df <- all_dates %>%
    dplyr::left_join(df, by = "date")

  # Replace missing values in other columns with NA
  result_df[is.na(result_df)] <- NA

  return(result_df)
}

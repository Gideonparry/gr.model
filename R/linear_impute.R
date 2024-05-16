#' Imputes data linearly
#'
#'
#' @param df The data imputes linearly
#'
#'
#' @import dplyr
#' @export

# Define a custom imputation function
linear_impute <- function(vec) {
  for (i in seq_along(vec)) {
    if (is.na(vec[i])) {
      previous_non_na_indices <- which(!is.na(rev(vec[1:i])))
      next_non_na_indices <- which(!is.na(vec[(i + 1):length(vec)]))

      if (length(previous_non_na_indices) > 0 &&
          length(next_non_na_indices) > 0) {
        previous_non_na_index <- i - previous_non_na_indices[1] + 1
        next_non_na_index <- i + next_non_na_indices[1]

        before_distance <- i - previous_non_na_index
        after_distance <- next_non_na_index - i

        vec[i] <- (after_distance * vec[previous_non_na_index] +
          before_distance * vec[next_non_na_index]) /
          (before_distance + after_distance)
      }
    }
  }
  return(vec)
}

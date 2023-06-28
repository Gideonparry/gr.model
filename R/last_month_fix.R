#' Fixing dates moving that end in the wrong month
#'
#' @param data the data file to fix end month
#' @param firstmonth The number corresponding to the first month on the graph
#' @param wrongmonth The number corresponding to the wrong last month on graph
#' @param rightmonth Th number corresponding to the right last month on graph
#' @param startdate the 1st date on the graph
#' @param diffyearwrong TRUE if the wrong month is in a different year
#' @param diffyearright TRUE if the right month is in a different year

last_month_fix <- function(data, firstmonth, wrongmonth, rightmonth, startdate,
                          diffyearwrong = TRUE, diffyearright = TRUE){
  ## getting number for dates
  datevals <- as.numeric(as.Date(data[,1]))

  ## Saving the 1st date value
  val1 <- as.numeric(as.Date(startdate))

  ## Setting the 1st date to 0
  datevals <- datevals - val1

  ## multiplying by proper amount
  datevals <- datevals *
    ((12*diffyearright + rightmonth - firstmonth) /
       (12*diffyearwrong + wrongmonth - firstmonth))

  ## Going back to origninal start date
  datevals <- datevals + val1

  data[,1] <- as.Date(datevals)

  data
}

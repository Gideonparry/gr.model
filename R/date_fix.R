#' November 1 1964 is recorded and nov 26 1964 on the digizer
#'
#' This function exists to fix the issue on the digitizer of recoring the
#' wrong date.
#'
#' @param data the data file to fix end month
#' @param enddate The end date on the graph
#' @param wrongdate The inncorrect start date
#' @param rightdate The correct start date

date_fix <- function(data, enddate, wrongdate = "1964-12-01",
                     rightdate = "1964-11-01"){
  datenum <- as.numeric(as.Date(enddate))
  data[,1] <- as.numeric(as.Date(data[,1]))
  data[,1] <- data[,1] - datenum
  numerator <- datenum - as.numeric(as.Date(rightdate))
  denominator <- datenum - as.numeric(as.Date(wrongdate))
  data[,1] <- data[,1] * (numerator / denominator)
  data[,1] <- data[,1] + datenum
  data[,1] <- as.Date(data[,1])
  data
}




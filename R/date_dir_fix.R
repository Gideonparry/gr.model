date_dir_fix <- function(data, firstmonth, lastmonth){
  ## getting number for dates
  datevals <- as.numeric(as.Date(data[,1]))

  ## Saving the 1st date value
  val1 <- datevals[1]

  ## Setting the 1st date to 0
  datevals <- datevals - val1

  ## Making the dates move the right directon
  datevals <- abs(datevals)

  ##  the 1st and last  months shown in the report
  firstmonth <- 11
  lastmonth <- 5

  ## Months between 1st and last month. Added 12 to count elapesed time while
  ## accounting for the fact the the last month in in the 2nd year.
  numerator <- 12 + lastmonth - firstmonth + 1

  ## The actual time it counted between the months with the same year accidentally
  ## included
  denominator <- firstmonth - lastmonth - 1

  ## Multiplying to get the correct number of days.
  datevals <- datevals * (numerator/denominator)

  ## Rounding to get closest approximation
  datevals <- round(datevals)

  ## Going back to origninal start date
  datevals <- datevals + val1

  data[,1] <- as.Date(datevals)

  data
}

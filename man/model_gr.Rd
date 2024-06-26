% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gideon_gr.R
\name{model_gr}
\alias{model_gr}
\title{Helps create RTL simulations}
\usage{
model_gr(
  snow_loads,
  tdata,
  tlm,
  cap = 1,
  flat_line = 0.2,
  metric_adjust = 1,
  se = 0.1625,
  sheltered = 0,
  Parapet = 0,
  logsize = 5.913,
  roofflat = 1
)
}
\arguments{
\item{snow_loads}{a simulated set of snow loads, using existing functions in rtsnow.}

\item{tdata}{dataset with exactly one row that contains the building and wind statistics necessary to run your model}

\item{tlm}{linear model that you have previously fit, and you can save this as .Rdata file, that you load when you run the script}

\item{cap}{Do not let the simulated value exceed the cap (in this case = 1) cap should also be bounded below by zero.}

\item{flat_line}{set value, for comparison purposes, the mean of the distribution cannot fall below this value.}

\item{metric_adjust}{Adjusts units to metric system}

\item{se}{The standard error for the model}

\item{sheltered}{1 if shelteded, 0 if not}

\item{Parapet}{1 if roof contains parapet, 0 if not}

\item{logsize}{log of area of the roof}

\item{roofflat}{1 if roof is flat (0 degrees), 0 if not}
}
\description{
Helps create RTL simulations
}

Title:

   Supplementary files for "USING DIGITIZED BUILDING AND WEATHER RECORDS TO IMPROVE THE
ACCURACY OF GROUND TO ROOF SNOW LOAD RATIO ESTIMATIONS"
   
   
Authors: 

   Gideon Parry
   Utah State University
   3900 Old Main Hill
   Logan, UT 84322
   gideonparry@protonmail.com


   Brennan Bean 
   Utah State University
   3900 Old Main Hill
   Logan, UT 84322
   brennan.bean@usu.edu
   ORCid: 0000-0002-2853-0455

  
Abstract:

  Reliability targeted snow loads (RTLs) measure the weight in accumulated snow (i.e.
  snow load) that a roof is required to support to ensure the probability of failure is suf-
  ficiently low. This calculation has historically relied upon a probability distribution that
  characterizes the ratio between the annual maximum ground snow load to the annual max-
  imum roof snow load, a quantity referred to as Gr. The best available data for estimating
  Gr comes from Canadian case studies from the 1950s and 1960s. However, much of the
  data was never digitized, with only approximations of data being made available in scanned
  versions of printed graphs. As a result, existing models for Gr are based upon limited
  information that often fails to account for the interaction between a structure’s geometry
  and the surrounding environment as it relates to roof snow retention. This thesis digitizes
  data from these Canadian case studies and develops new models of Gr that better account
  for the effects of building geometry and wind speeds on roof snow retention. Using the dig-
  itized Canadian data, these new models improve the prediction accuracy in Gr compared
  to previous modeling efforts. To apply models from Canadian data to use in the United
  States, gridded estimations of weather variables are used to model Gr in place of digitized
  data from the Canadian reports. These gridded estimations of weather data do not improve
  prediction accuracy like the models using the digitized data, suggesting that site-specific
  variations in wind and exposure effects not captured in gridded weather maps are necessary
  for accurately predicting G 


Details:

   This folder contains a data folder, scripts to clean and the data, scripts to model
   the data, and scripts to validate and apply the models. The collected data come from
   the following sources.
   - Allen, C. & Peter, B. (1963). Snow loads on roofs 1962-63: Seventh progress report.
	Technical report, National Research Council, Division of Building Research, Ottawa,
	Canada. https://doi.org/10.4224/20386563
   - Allen, D. E. (1958). Snow loads on roofs 1956-57: A progress report. Technical report
	National Research Council, Division of Building Research, Ottawa, Canada.
	https://doi.org/10.4224/20338139
   - CCCS (2023). Era5 hourly data on pressure levels from 1940 to present.
	https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5
	-pressure-levels?tab=form
   - Faucher, Y. (1967). Snow loads on roofs 1964-65: Ninth progress report. Technical report,
	National Research Council, Division of Building Research, Ottawa, Canada. https://
	doi.org/10.4224/20386791
   - Hebert, P. & Peter, B. (1963). Snow loads on roofs 1961-62: Sixth progress report with an
	appendex on roof to ground load ratios. Technical report, National Research Coun-
	cil, Division of Building Research, Ottawa, Canada. https://doi.org/10.4224/
	20386760
   - Ho, M. & Lutes, D. A. (1968). Snow loads on roofs 1965-66: Tenth progress report. Technical
	report, National Research Council, Division of Building Research, Ottawa, Canada.
	https://doi.org/10.4224/20386688
   - Kennedy, I. & Lutes, D. (1968). Snow loads on roofs 1966-67: Eleventh progress report.
	Technical report, National Research Council, Division of Building Research, Ottawa,
	Canada. https://doi.org/10.4224/20386579
   - Scott, J. & Peter, B. (1961). Snow loads on roofs 1960-61: Fifth progress report. Technical
	report, National Research Council, Division of Building Research, Ottawa, Canada.
	https://doi.org/10.4224/20338224
   - Thorburn, H. & Peter, B. (1959). Snow loads on roofs, 1958-59. third progress report.
	Technical report, National Research Council, Division of Building Research, Ottawa,
	Canada. https://doi.org/10.4224/20386753
   - Watt, W. & Thorburn, H. J. (1960). Snow loads on roofs 1959-60: Fourth progress report.
	Technical report, National Research Council, Division of Building Research, Ottawa,
	Canada. https://doi.org/10.4224/20338150
  Data processing and models were created using R Statistical Software
  with the help of the tidyverse package.


Folders: 

1. Scripts
   This folder contains reproducible scrips to produce the figures and results from the thesis the files in order of
   usage include:
	Files: 
      0_data_variables.R: Start with this one. This files obtains the data created from digitizing the Canadian reports
	and aggregating them to one data file
      1_data.R: This file takes the aggregated data along with metadata to create the final data used in modeling and
	show rrelevant figures.
      2_methods.R: Creates the models used to predict GR. This file shows the process for selecting the final model, including
	figues and coefficient relevant for doing so.
      3_Validation_methods.R Shows cross validation being used for models that were attempted in the Thesis. This uses a
	function to run 25 different partitions of buildings and observations
      4_rtl.R This file uses RTL data and shows effects of different assumptions and different eco regions on RTLs.It shows
	sheltered vs non sheltered effects, and effects of different assumptions for wind and temperature.
      5_reliability_targeted_loads.R: Not reproducible. Creates simulations of RTLs. This is not reproducible due to the lack
	of some r scripts and data files it calls.

2. data-raw
	This folder contains data and non-reproducible scripts used to create it. Some notable data files are
	1. complete_data.csv: This is the data file that data_variables.R creates from the files in complete_data
	2. gr_meta_ca_all.csv This file is the metadata this complete_data is joined with
	3. updated_data.csv This is the final data used in modeling after running data.R
	The sub folders here are
	1. Unused_previous_attempts: Previous attempts at R scripts that are no longer in use
	2. data_fixing: Scripts used to correct errors in digitizing
	3. data_validation: Scripts used to validated that data was entered correctly
	4. era_maps: scrips used to aggreagate many ERA5 grids into one used in modeling

complete_data
	This folder contains all data obtained from digitized reports. It is recommended to avoid interacting with these 
	data directly, but rather interact with the data summaries available in the R scripts contained in this repository. 
 
	


Instructions:

To reproduce results and figures found in the thesis, all that needs to be run is 1_data.R, 2_methods.R, 
3_validation_methods.R and 4_rtl.R in that order. 0_data_variables.R and 5_reliability_targeted_loads.R are included
to demonstrate how these actions were performed, and 0_data_variables.R is reproducible. 





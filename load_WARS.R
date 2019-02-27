# load_WARS.R
# script to read '2019-02-26 Residential Duty Commercial Water Heaters (WARS).csv'
# from https://cacertappliances.energy.ca.gov/Pages/Search/AdvancedSearch.aspx
# and review 2nd stage validation for CEC Appliance Standards
# started by Jim Lutz "Tue Feb 26 15:46:04 2019"

# set packages & etc
source("setup.R")

# set up paths to working directories
wd_WARS <- "/home/jiml/HotWaterResearch/projects/CEC Appliance Standards/2019-02-25 validation/"

# read '2019-02-26 Residential Duty Commercial Water Heaters (WARS).csv'
DT_WARS <-
  read_xls(path = paste0(wd_WARS,
                      "2019-02-26 Residential Duty Commercial Water Heaters (WARS).xls"))

# see what's there
length(names(DT_RECS))
# [1] 940
nrow(DT_RECS)
# [1] 12083

# read the recs2009_public_repweights.csv
DT_RECS_repweights <-
  fread(file = paste0(wd_RECS,"recs2009_public_repweights.csv"))

# see what's there
length(names(DT_RECS_repweights))
# [1] 246
nrow(DT_RECS_repweights)
# [1] 12083

# merge on DOEID
DT_RECS <-
  merge(DT_RECS, DT_RECS_repweights, by='DOEID')

# see what's there
length(names(DT_RECS))
# [1] 1185
nrow(DT_RECS)
# [1] 12083

# keep only California data
DT_RECS_CA <-
  DT_RECS[ REPORTABLE_DOMAIN==26,]

# see what's there
length(names(DT_RECS_CA))
# [1] 1185
nrow(DT_RECS_CA)
# [1] 1606

# save as an .Rdata file
save(DT_RECS_CA, file = "data/DT_RECS_CA.Rdata")


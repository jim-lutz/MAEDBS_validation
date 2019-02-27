# load_WARS.R
# script to read '2019-02-26 Residential Duty Commercial Water Heaters (WARS).csv'
# from https://cacertappliances.energy.ca.gov/Pages/Search/AdvancedSearch.aspx
# and review 2nd stage validation for CEC Appliance Standards
# started by Jim Lutz "Tue Feb 26 15:46:04 2019"

# set packages & etc
source("setup.R")

# path to data
wd_WARS <- paste0(dirname(getwd()),"/2019-02-25 validation/")

# data directory
if(!dir.exists("./data")){
  dir.create("./data")
}

# charts directory
if(!dir.exists("./charts")){
  dir.create("./charts")
}

# read '2019-02-26 Residential Duty Commercial Water Heaters (WARS).csv'
DT_WARS <- data.table(
  read_xls(path = paste0(wd_WARS,
                      "2019-02-26 Residential Duty Commercial Water Heaters (WARS).xls"))
  )

# see what's there
length(names(DT_WARS))
# [1] 18
nrow(DT_WARS)
# [1] 205
names(DT_WARS)
#  [1] "Manufacturer"                                                                      
#  [2] "Brand"                                                                             
#  [3] "Model Number"                                                                      
#  [4] "Regulatory Status"                                                                 
#  [5] "Energy Source"                                                                     
#  [6] "Rated Volume"                                                                      
#  [7] "Measured Volume"                                                                   
#  [8] "Input Rating"                                                                      
#  [9] "Heat Traps? (T/F)"                                                                 
# [10] "Ozone Depleting Substance in Insulation? (T/F)"                                    
# [11] "Ozone Depleting Substance in Refrigerant (for heat pump water heaters only)? (T/F)"
# [12] "Constant burning pilot light? (T/F)"                                               
# [13] "Mobile Home? (T/F)"                                                                
# [14] "Water Heater Type"                                                                 
# [15] "Draw Pattern"                                                                      
# [16] "Uniform Energy Factor"                                                             
# [17] "Uniform Energy Factor Standard"                                                    
# [18] "Add Date"                                                                          

str(DT_WARS)

# look at Energy Source
DT_WARS[ ,list(n=.N),
         by=c('Energy Source')]
#          Energy Source   n
# 1:         Natural gas 109
# 2:                 LPG  87
# 3: Electric resistance   9

# summary of Measured Volume by Energy Source
ngas <- DT_WARS[1,'Energy Source']

DT_WARS[grepl("Natural gas","Energy Source"),] # no
DT_WARS[grep("Natural gas","Energy Source"),] # no
DT_WARS[, 'Energy Source'] # yes
DT_WARS$'Energy Source'== "Natural gas"  # yes
DT_WARS['Energy Source'== "Natural gas",] # no
DT_WARS["Energy Source"== "Natural gas",] # no
DT_WARS['Energy Source' %in% c("Natural gas"),] # no
DT_WARS['Energy Source' %in% "Natural gas",] # no
DT_WARS['Energy Source' %like% "Natural gas",] # no
DT_WARS["Natural gas" %like% 'Energy Source',] # no

DT_WARS[DT_WARS$'Energy Source'== "Natural gas","Energy Source"] # yes

setnames(DT_WARS, old = c("Energy Source"),
         new = c("Energy_Source"))

DT_WARS[grepl("Natural gas",Energy_Source),] # yes
DT_WARS[grep("Natural gas",Energy_Source),] # yes
DT_WARS[, Energy_Source] # yes
DT_WARS$Energy_Source== "Natural gas"  # yes
DT_WARS[Energy_Source== "Natural gas",] # yes
DT_WARS[Energy_Source== "Natural gas",] # yes
DT_WARS[Energy_Source %in% c("Natural gas"),] # yes
DT_WARS[Energy_Source %in% "Natural gas",] # yes
DT_WARS[Energy_Source %like% "Natural gas",] # yes
DT_WARS["Natural gas" %like% Energy_Source,] # no


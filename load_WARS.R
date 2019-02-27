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
DT_WARS[ ,list(min = min(`Measured Volume`),
               ave = mean(`Measured Volume`),
               max = max(`Measured Volume`)),
         by=`Energy Source`]
#          Energy Source min      ave max
# 1:         Natural gas  20 69.51376 112
# 2:                 LPG  20 67.94253 112
# 3: Electric resistance   1  1.00000   1
# The electric resistance are tankless?

DT_WARS[,`Regulatory Status`]
# it's all  "Federally-Regulated Commercial & Industrial Equipment"

# compare `Measured Volume` and `Uniform Energy Factor`
ggplot(data = DT_WARS) +
  geom_point(aes(x=`Measured Volume`, y=`Uniform Energy Factor`)) +
  facet_wrap(vars(`Energy Source`), scales = "free")
# nothing surprising

# compare `Input Rating` and `Uniform Energy Factor`
ggplot(data = DT_WARS) +
  geom_point(aes(x=`Input Rating`, y=`Uniform Energy Factor`,
                 color=`Energy Source`)) +
  facet_wrap(vars(`Water Heater Type`), scales = "free")




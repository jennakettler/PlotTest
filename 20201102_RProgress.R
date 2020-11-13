# load package to readxl (reads excel files)
library(tidyverse)
library(readxl) 
# reading Biomass and Plot Data from excel files
Biomass <- read_excel("/Users/jennakettler/Documents/Excel/20200927_BiomassPlotData.xlsx", col_names=FALSE)
PlotData <- read_excel("/Users/jennakettler/Documents/Excel/20200923_SeptemberPlotData_v1.xlsx", col_names = FALSE)
TPlotData <- as.data.frame(t(PlotData)) #
T <-tibble(TPlotData) # tibble of TPlotData
# chr to integer/double
# plant species as chr
# eventually can get rid of "Alive"
T <- T[,c(1,2,4,13,6,3,5,7,8,9,10,11,12,14,15,16,17)] # rearrange columns for T
Biomass <- Biomass[,c(1,2,4,5,3)] # rearrange columns for Biomass
T <- rename(T,
            Block = V1,
            Plot = V2,
            PlantNum = V4,
            Species = V6,
            Mass = V13,
            Typha = V3,
            TH = V7,
            CD = V8,
            BC = V9,
            Stem = V10,
            Leaves = V11,
            SH = V12) # renaming relevant columns for T
Biomass <- rename(Biomass,
                  Block = ...1,
                  Plot = ...2,
                  PlantNum = ...4,
                  Species = ...3,
                  Mass = ...5) #renaming relevant columns for Biomass
T$Block <- as.numeric(T$Block) #converting all relevant columns to a numeric
T$Plot <- as.numeric(T$Plot)
T$PlantNum <- as.numeric(T$PlantNum)
T$Mass <- as.numeric(T$Mass)
T$TH <- as.numeric(T$TH)
T$Typha <- as.numeric(T$Typha)
T$CD <- as.numeric(T$CD)
T$BC <- as.numeric(T$BC)
T$Stem <- as.numeric(T$Stem)
T$Leaves <- as.numeric(T$Leaves)
T$SH <- as.numeric(T$SH)
T$V5 <- NULL #removing the alive column
Biomass$Block <- as.numeric(Biomass$Block)
Biomass$Plot <- as.numeric(Biomass$Plot)
Biomass$PlantNum <- as.numeric(Biomass$PlantNum)
Biomass$Mass <- as.numeric(Biomass$Mass)
#attempting to merge the data however has proven to be ineffective

TBio <- merge(T, Biomass) 



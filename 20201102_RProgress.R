
library(tidyverse)

# reading Biomass and Plot Data as csv files
Biomass <- read.csv("20200927_BiomassPlotData.csv", header=TRUE)
PlotData <- read.csv("20200923_SeptemberPlotData_v1.csv", header=FALSE)

#convert to data frame, change row names, transpose TPlotData
PlotData <- rownames_to_column(PlotData, var = "Block")
PlotData <- t(PlotData)
PlotData<-as.data.frame(PlotData)

#removes filler row
names(PlotData)<-PlotData[1,]
PlotData<-PlotData[-1,]

#makes column headers as the first row and removes first row
colnames(PlotData)<-as.character(unlist(PlotData[1,]))
PlotData<-PlotData[-1,]

#reorder columns, remove alive column
PlotData <- PlotData[,c(1,2,4,6,3,5,7,8,9,10,11,12,13,14,15,16,17)]
PlotData$Alive <- NULL

#rename necessary columns to match Biomass data, rename unused columns to delete
colnames(PlotData)[colnames(PlotData) == "Plant_num"] <- "Plant"
colnames(PlotData)[colnames(PlotData) == "Plant_spec"] <- "Species"
colnames(PlotData)[colnames(PlotData) == ""] <- "A"
colnames(PlotData)[colnames(PlotData) == ".1"] <- "B"
colnames(PlotData)[colnames(PlotData) == ".2"] <- "C"
colnames(PlotData)[colnames(PlotData) == ".3"] <- "D"

#delete unused columns
PlotData$A <- NULL
PlotData$B <- NULL
PlotData$C <- NULL
PlotData$D <- NULL


#rearrange biomass data
Biomass <- Biomass[,c(1,2,4,3,5)]

#convert three columns to numeric
cols.num <- c("Block", "Plot", "Plant")
PlotData[cols.num] <-sapply(PlotData[cols.num], as.integer)
sapply(PlotData, class)

#attempt to merge data
PlotBio <- merge(PlotData, Biomass, by=c("Block", "Plot", "Plant"))

#change column names that were incorrect, delete columns that were extra
PlotBio$Mass.x <- NULL
PlotBio$Species.y <- NULL
colnames(PlotBio)[colnames(PlotBio) == "Mass.y"] <-"Mass"
colnames(PlotBio)[colnames(PlotBio) == "Species.x"] <-"Species"

#adds a new column to merged data, allocated for bag_wt 
PlotBio<-mutate(PlotBio, bag_wt=60.2)

d12 <- as.numeric(PlotBio[,12])
PlotBio[,12] <-d12


#assigns the bag weight to the correct plants
n<-NROW(PlotBio)
for(i in 1:n){
  if ((PlotBio[i,1]==1 || PlotBio[i,1] ==2 ||PlotBio[i,1]== 3 || PlotBio[i,1]==4 || PlotBio[i,1]==5))
    {
    PlotBio[i,13]<-5.43 }
  
  if ((PlotBio[i,1]==6 && PlotBio[i,2]<=12)){
    PlotBio[i,13]<-6.82
  }  
  
  if ((PlotBio[i,1]==6 && PlotBio[i,2]>=13 && PlotBio[i,2]<=24)){
    PlotBio[i,13]<-6.32
  }
  if (PlotBio[i,1]==6 && PlotBio[i,2]==13 && (PlotBio[i,3]==9 || PlotBio[i,3]==10)){
    PlotBio[i,13]<-6.34
  }
}

# creates a new column and calculates the true_mass
PlotBio<-mutate(PlotBio, true_mass=Mass-bag_wt)

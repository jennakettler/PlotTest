library(readxl)
Biomass <- read_excel("C:\\Users\\jenna\\OneDrive\\Documents\\Excel\\20200927_BiomassPlotData.xlsx", col_names=FALSE)
PlotData <- read_excel("C:\\Users\\jenna\\OneDrive\\Documents\\Excel\\20200923_SeptemberPlotData_v1.xlsx", col_names = FALSE)
TPlotData <- as.data.frame(t(PlotData))
Biomass
TPlotData


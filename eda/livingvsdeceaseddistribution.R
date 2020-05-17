library(dplyr)
library(ggplot2)
install.packages("ggplot2")

living_vs_deceased <- read.csv(file = 'distributiondata.csv')


plot1 <- barplot(living_vs_deceased$To.Date, names.arg= living_vs_deceased$Donors, col = rainbow(400000), 
        xlab ="Types of Donors", ylab="Number of Donors", main="Living vs. Deceased Donors", 
        beside=TRUE, ylim=range(pretty(c(0, living_vs_deceased$Donors)), ylim=c(0,400000)))


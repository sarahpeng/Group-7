library(dplyr)
library(ggplot2)
install.packages("ggplot2")

living_vs_deceased <- read.csv(file = 'distributiondata.csv')

living_vs_deceased <- living_vs_deceased %>% 
  rename(
    Donors = X
  )

plot1 <-ggplot(data=living_vs_deceased, aes(x=Donors, y=To.Date)) + 
  xlab("Types of Donors") + ylab("Number of Donors") + ggtitle("Living vs. Deceased Donors") +
  geom_bar(stat="identity", fill="steelblue")


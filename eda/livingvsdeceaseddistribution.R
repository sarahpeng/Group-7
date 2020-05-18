library(dplyr)
library(ggplot2)
install.packages("ggplot2")

living_vs_deceased <- read.csv(file = 'distributiondata.csv')

living_vs_deceased <- living_vs_deceased %>% 
  rename(
    Donors = X,
    Genders = X.1,
    Ages = X.2
  )

all_ages <- living_vs_deceased %>%
  select(Donors, Genders, Ages, To.Date)%>%
  filter(Ages== ("All Ages"),
         Genders== ("All Genders")
         )

plot1 <-ggplot(data=all_ages, aes(x=Donors, y=To.Date)) + 
  xlab("Types of Donors") + ylab("Number of Donors") + ggtitle("Living vs. Deceased Donors") +
  geom_bar(stat="identity", fill="steelblue")


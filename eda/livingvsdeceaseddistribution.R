library(dplyr)
library(ggplot2)
library(magrittr)
install.packages("ggplot2")
install.packages("dplyr")
install.packages("magrittr")

living_vs_deceased <- read.csv(file = 'donordata.csv')

living_vs_deceased <- living_vs_deceased %>% 
  rename(
    Donors = X,
    Genders = X.1,
    Ages = X.2
  )


#Donor Type Plot
donor_type <- living_vs_deceased %>%
  select(Donors, Genders, Ages, To.Date)%>%
  filter(Ages== ("All Ages"),
         Genders== ("All Genders")
         )

plot1 <- ggplot(data=donor_type, aes(x=Donors, y=To.Date)) + 
  xlab("Types of Donors") + ylab("Number of Donors") + ggtitle("Living vs. Deceased Donors") +
  geom_bar(stat="identity", fill="steelblue")

#Gender Type Plot
gender_diff <-living_vs_deceased %>%
  select(Donors, Genders, Ages, To.Date)%>%
  filter(Ages== ("All Ages"),
         Genders== c("Male","Female") 
  )

plot2 <- ggplot(data=gender_diff, aes(x=Genders, y=To.Date)) + 
  xlab("Gender of Donors") + ylab("Number of Donors") + ggtitle("Male vs. Female Donors") +
  geom_bar(stat="identity", fill="steelblue")

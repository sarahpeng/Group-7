library(dplyr)
library(ggplot2)
library(magrittr)
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("magrittr")

#populating 1st column
living_vs_deceased <- read.csv(file = 'donordata.csv')
living_vs_deceased$X[2] = "All Donor Types"
living_vs_deceased$X[3] = "All Donor Types"
living_vs_deceased$X[4] = "All Donor Types"
living_vs_deceased$X[5] = "All Donor Types"
living_vs_deceased$X[6] = "All Donor Types"
living_vs_deceased$X[7] = "All Donor Types"
living_vs_deceased$X[8] = "All Donor Types"
living_vs_deceased$X[9] = "All Donor Types"

#renaming columns
living_vs_deceased <- living_vs_deceased %>% 
  rename(
    Donors = X,
    Ages = X.1,
  )

#removing commas and turning values into doubles
living_vs_deceased$To.Date <- as.numeric(gsub(",","",living_vs_deceased$To.Date))
living_vs_deceased$To.Date <-  as.double(as.character(living_vs_deceased$To.Date))


#filtering mean data
mean_infant <- living_vs_deceased %>%
  filter(Donors== ("All Donor Types"),
         (Ages== "< 1 Year"))%>%
          mutate(To.Date = round(To.Date / 33),2)%>%
  select(Ages, To.Date)

mean_toddler <- living_vs_deceased %>%
  filter(Donors== ("All Donor Types"),
         (Ages== "1-5 Years"))%>%
  mutate(To.Date = round(To.Date / 33),2)%>%
  select(Ages, To.Date)

mean_child <- living_vs_deceased %>%
  filter(Donors== ("All Donor Types"),
         (Ages== "6-10 Years"))%>%
  mutate(To.Date = round(To.Date / 33),2)%>%
  select(Ages, To.Date)

mean_teen <- living_vs_deceased %>%
  filter(Donors== ("All Donor Types"),
         (Ages== "11-17 Years"))%>%
  mutate(To.Date = round(To.Date / 33),2)%>%
  select(Ages, To.Date)

mean_y_adult <- living_vs_deceased %>%
  filter(Donors== ("All Donor Types"),
         (Ages== "18-34 Years"))%>%
  mutate(To.Date = round(To.Date / 33),2)%>%
  select(Ages, To.Date)

mean_o_aldut <- living_vs_deceased %>%
  filter(Donors== ("All Donor Types"),
         (Ages== "35-49 Years"))%>%
  mutate(To.Date = round(To.Date / 33),2)%>%
  select(Ages, To.Date)

mean_midlife <- living_vs_deceased %>%
  filter(Donors== ("All Donor Types"),
         (Ages== "50-64 Years"))%>%
  mutate(To.Date = round(To.Date / 33),2)%>%
  select(Ages, To.Date)

mean_elderly <- living_vs_deceased %>%
  filter(Donors== ("All Donor Types"),
         (Ages== "65 +"))%>%
  mutate(To.Date = round(To.Date / 33),2)%>%
  select(Ages, To.Date)

#combining filtered data into new dataframe
mean_ages <- rbind( mean_infant,mean_toddler,mean_child,mean_teen,mean_y_adult,mean_o_aldut,
               mean_midlife,mean_elderly)

#ploting mean data
mean_ages_plot <- ggplot(data=mean_ages, aes(x=Ages, y=To.Date)) + 
  xlab("Ages of Donors") + ylab("Number of Donors") + 
  ggtitle("Average Number of Donors per Year by Age Group from 1988-2020") +
  geom_bar(stat="identity", fill="steelblue") + coord_flip()


















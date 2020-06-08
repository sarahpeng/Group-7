library(dplyr)
library(ggplot2)
library(magrittr)
library(reshape2)

options(stringsAsFactors = F)
df <- read.csv(file = 'Donors_Recovered_in_the_U.S._by_Donor_Type.csv')
# Drop unknown blood type
df<-df[!(df$Blood.Type=="Unknown"),]

# Create living/deceased Dataset
num_ddonors <- df[(df$Donor.Type=="Deceased Donor" & 
                     df$Blood.Type == "All ABO" & 
                     df$Organ == "All Donors") ,]
t<- num_ddonors[["To.Date"]]

# Living vs. Deceased Pie Chart
num_ddonors <- df[(df$Donor.Type=="Deceased Donor" & 
                     df$Blood.Type == "All ABO" & 
                     df$Organ == "All Donors") ,]
num_ddonors <- as.numeric(gsub(",","",num_ddonors$To.Date[[1]]))

num_ldonors <- df[(df$Donor.Type=="Living Donor" & 
                     df$Blood.Type == "All ABO" & 
                     df$Organ == "All Donors") ,]
num_ldonors <- as.numeric(gsub(",","",num_ldonors$To.Date[[1]]))


slices <- c(num_ddonors, num_ldonors)
lbls <- c("Deceased Donor", "Living Donor")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct)
lbls <- paste(lbls,"%",sep="")
p1 <- pie(slices, labels = lbls, col=rainbow(length(lbls)),
          main="Living vs. Deceased")





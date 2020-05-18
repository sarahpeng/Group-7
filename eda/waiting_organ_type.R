library(dplyr)
library(ggplot2)
library(magrittr)
library(tidyr)
organ_waiting <- read.csv(file = 'Organ_by_Blood_Type.csv', stringsAsFactors = FALSE)
organ_waiting_c <- subset(organ_waiting, select = -c(X.1, All.Organs))
organ_waiting_c = organ_waiting_c[-1,1:6]
waiting_long <- gather(organ_waiting_c, Organ, Waiting_Num, 2:6, factor_key=TRUE)
waiting_long$Waiting_Num <- as.numeric(gsub(",", "", waiting_long$Waiting_Num))
waiting_plot <- ggplot(data=waiting_long, aes(x=Organ, y=Waiting_Num, fill=X)) +
  geom_bar(stat="identity", position=position_dodge())+
  xlab("Organ Type") + 
  ylab("Number of people waiting") + 
  ggtitle("Organ Type vs Number of people waiting") 

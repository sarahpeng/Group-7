library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)

server <- function(input, output) {
  waiting_time <- read.csv("Organ_by_Blood_Type.csv", stringsAsFactors = FALSE, na.strings=c("","NA"))
  waiting_time <- waiting_time %>% 
    rename(
      Organ_Type = X,
      Age = X.1
    ) %>% 
    fill(Organ_Type)
  waiting_time$Age <- recode(waiting_time$Age, "1-5 Years" = "01-5 Years", "6-10 Years" = "06-10 Years", "< 1 Year" = "0-1 years")
  waiting_time <- subset(waiting_time, select = -(3:4))
  output$waiting_plot <- renderPlot({
    newdata <- subset(waiting_time, Organ_Type==input$organ_type)
    newdata <- subset(newdata, Age!="All Ages")
    waiting_time_long <- gather(newdata, Blood_Type, Waiting_num, 3:6, factor_key=TRUE)
    waiting_time_long$Waiting_num <- as.numeric(gsub(",", "", waiting_time_long$Waiting_num))
    ggplot(data = waiting_time_long, aes(x=.data[[input$X_Variable]] , y=Waiting_num, fill=.data[[input$Fill_Variable]])) +
      geom_bar(stat="identity", position=position_dodge())+
      xlab(input$X_Variable) + 
      ylab("Number of People Waiting") + 
      ggtitle("X Variable vs Number of People Waiting") 
  })
}


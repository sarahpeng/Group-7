library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(magrittr)
library(reshape2)
source("donorapp.R")
source("survey.R")


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
  options(stringsAsFactors = F)
  df <- read.csv(file = 'Donors_Recovered_in_the_U.S._by_Donor_Type.csv')
  # Drop unknown blood type
  df<-df[!(df$Blood.Type=="Unknown"),]
  
 
  output$blood_type_plot <- renderPlot({
    
    one_donor_type_data <- df %>%
      filter(Donor.Type == input$Donor_Type) %>%
      filter(Organ == input$Organ)
    

    # drops all ABO rows
    one_donor_type_data<-one_donor_type_data[!(one_donor_type_data$Blood.Type=="All ABO"),]
    # drops the To Date column
    one_donor_type_data <- within(one_donor_type_data, rm(To.Date))
    
    
    # melts data so that it can be easily plotted
    m_donor_type_data <- melt(one_donor_type_data, id.vars=c("Donor.Type","Blood.Type","Organ"))
    
    m_donor_type_data$clean_value <- as.numeric(sub(',', '', m_donor_type_data$value))
    m_donor_type_data$year <- as.numeric(format(as.Date(sub('.', '', m_donor_type_data$variable),format="%Y"),'%Y'))
    m_donor_type_data <-m_donor_type_data[!(m_donor_type_data$year=="2020"),]
    
    ggplot(m_donor_type_data, aes(x = year, y = clean_value, color = Blood.Type)) +
      geom_line() +
      ggtitle(title <- paste0(" Blood ", "type", " of ", input$Donor_Type, " for ", input$Organ,
                              " from", " 1988 to 2019 ")) +
      xlab("Year") + ylab(paste0("Number of ", input$Organ, "s")) +
      scale_color_discrete(name = "Blood type", labels = c("Type A", "Type B", "Type O", "Type AB"))
  })
  
  output$piechart_plot <- renderPlot({
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
              main="Percentage of Living vs. Deceased from 1988-2020")
    
  })
  
waitlist
transSupport
donateDeath
kidneys
livers
lungs
  
}

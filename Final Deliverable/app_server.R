library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(magrittr)
library(reshape2)
source("donorapp.R")


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
    print(input$Donor_Type)
    one_donor_type_data <- df %>%
      filter(Donor.Type == input$Donor_Type) %>%
      filter(Organ == input$Organ)
    
    print(one_donor_type_data)
    
    # drops all ABO rows
    one_donor_type_data<-one_donor_type_data[!(one_donor_type_data$Blood.Type=="All ABO"),]
    # drops the To Date column
    one_donor_type_data <- within(one_donor_type_data, rm(To.Date))
    
    
    # melts data so that it can be easily plotted
    m_donor_type_data <- melt(one_donor_type_data, id.vars=c("Donor.Type","Blood.Type","Organ"))
    
    # for each blood type, create x and y values that are associated w that blood type
    for (blood_type in c("A", "B", "O", "AB")){
      # filter to only that blood type
      temp_df <- m_donor_type_data[(m_donor_type_data$Blood.Type==blood_type), ]
      # create x_O, x_A, x_B.... etc.
      x_name <- paste("x_", blood_type, sep = "")
      # set name to formatted date type
      assign(x_name, as.numeric(format(as.Date(sub('.', '', temp_df$variable),format="%Y"),'%Y')))
      
      # create y_O, y_A,.... etc.
      y_name <- paste("y_", blood_type, sep = "")
      # set variable to the numeric values of that year
      assign(y_name, as.numeric(temp_df$value))
      
    }
    
    
    # plot the defined x and y points for each blood type on same plot
    ggplot() +
      geom_line(mapping = aes(x = x_A, y = y_A), color = "blue") +
      geom_line(mapping = aes(x = x_B, y = y_B), color = "red") +
      geom_line(mapping = aes(x = x_O, y = y_O), color = "green") +
      geom_line(mapping = aes(x = x_AB, y = y_AB), color = "orange")

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
              main="Living vs. Deceased")
    
  })
  
  
}

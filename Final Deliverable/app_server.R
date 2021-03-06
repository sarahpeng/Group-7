library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(magrittr)
library(reshape2)
source("donorapp.R")
source("survey.R")


server <- function(input, output) {
  url1 <- a("Organ Donation Statistics", href="https://www.organdonor.gov/statistics-stories/statistics.html")
  output$tab <- renderUI({
    tagList("", url1)
  })
  url2 <- a("National Survey of Organ Donation Attitudes and Practices", href="https://www.organdonor.gov/sites/default/files/about-dot/files/nsodap-organ-donation-survey-2019.pdf")
  output$tab2 <- renderUI({
    tagList("", url2)
  })
  
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
  

  
  graphs <- read.csv('data/graphs.csv')
  output$waitlist_plot <- renderPlot({  
    waitlistDie <- graphs%>% filter(Question == "WaitlistDie") %>% select(Response,Percent)
    ylabel <- c("Strongly Agree", "Somewhat Agree", "Somewhat Disagree", "Strongly Disagree")
    waitlist<- ggplot(waitlistDie) + geom_col(mapping = aes(x = reorder(ylabel, -waitlistDie$Percent) , y = waitlistDie$Percent )) + ggtitle("Percent of People Who Agree That People on the Waitlist Die Because the Organ They Need Isn't Donated in Time") +
      xlab("Response") + ylab("Percent")
    waitlist
  })
  
  output$transSupport_plot <- renderPlot({  
    transplantSupport <- graphs %>% filter(Question == "TransplantSupport")  %>% select(Response,Percent)
    tslabel <- c("Strongly Support","Support","Oppose","Strongly Oppose")
    transSupport <- ggplot(transplantSupport) + geom_col(mapping = aes(x = reorder(tslabel, -transplantSupport$Percent) , y =transplantSupport$Percent )) + ggtitle("Percent of People who Support Transplants") +
      xlab("Response") + ylab("Percent")
    transSupport
  })
  
  output$donateDeath_plot <- renderPlot({
  deathDonate <- graphs%>% filter(Question == "DeathDonate") %>% select(Response,Percent)
  ddlabel <- c("Likely Yes","Likely No","Strong No","Strong Yes")
  donateDeath <- ggplot(deathDonate) + geom_col(mapping = aes(x = reorder(ddlabel, -deathDonate$Percent) , y = deathDonate$Percent )) + ggtitle("Percent of People who are Willing to Donate Their Organs After Death") +
    xlab("Response") + ylab("Percent")
  donateDeath
  })
  
  output$kidney_plot <- renderPlot({
  kidney <- graphs%>% filter(Question == "Kidney") %>% select(Response,Percent)
  kidneys<- ggplot(kidney) + geom_col(mapping = aes(x = reorder(kidney$Response, -kidney$Percent) , y = kidney$Percent )) + ggtitle("Percent of People Who Believe That Kidneys Can Be Donated From a Living Donor") +
    xlab("Response") + ylab("Percent")
  kidneys
  })
  
  output$liver_plot <- renderPlot({
  liver <- graphs%>% filter(Question == "Liver") %>% select(Response,Percent)
  livers<- ggplot(liver) + geom_col(mapping = aes(x = reorder(liver$Response, -liver$Percent) , y = liver$Percent ))  + ggtitle("Percent of People Who Believe That Parts of Livers Can be Donated From Living Donors") +
    xlab("Response") + ylab("Percent")
  livers
  })
  
  output$lung_plot <- renderPlot({
  lung <- graphs%>% filter(Question == "Lung") %>% select(Response,Percent)
  lungs <- ggplot(lung) + geom_col(mapping = aes(x = reorder(lung$Response, -lung$Percent) , y = lung$Percent )) + ggtitle("Percent of People Who Believe That Parts of Lungs Can be Donated From Living Donors") +
    xlab("Response") + ylab("Percent")
  lungs
  })
  
  
}

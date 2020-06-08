library(shiny)
library(dplyr)


waiting_time <- read.csv("Organ_by_Blood_Type.csv", stringsAsFactors = FALSE)
library(shiny)
page_one <- tabPanel(
  "Introduction"
)
page_two <- tabPanel(
  "Organ Donor" 
)

Donors_input <- radioButtons(
  inputId = "Donor_Type",
  label = "Donors",
  choices = c("Living Donor", "Deceased Donor")
)

Organ_input <- selectInput(
  inputId = "Organ",
  label = "Organ",
  choices = c("Kidney", "Liver", "Heart", "Pancreas", "Lung", "Intestine")
)

page_two <- tabPanel(
  "Donors",
  Donors_input,
  Organ_input,
  plotOutput("blood_type_plot"),
  br(),
  br(),
  br(),
  br(),
  br(),
  plotOutput("piechart_plot"),
  tags$h4("Note:"),
  p("The pie chart shows the proportion of the two types of donors. As you can see, 
    there is more deceased donors than living donors. The interactive part shows users
    the trend of supply of a specific organ throughout the last 30 years. By picking a donor
    type first, then a organ, the graph will mark the trend using different colored lines 
    which represent different blood types for each organ."
  
))



Waiting_OT_input <- selectInput(
  inputId = "organ_type",
  label = "Organ Type",
  choices = waiting_time$X
)
Waiting_X_input <- radioButtons(
  inputId = "X_Variable",
  label = "X Variable",
  choices = c("Blood_Type", "Age")
)
Waiting_fill_input <- radioButtons(
  inputId = "Fill_Variable",
  label = "Fill Variable",
  choices = c("Age", "Blood_Type")
)
page_three <- tabPanel(
  "Current U.S. Waiting List for Organs",
  Waiting_OT_input,
  Waiting_X_input,
  Waiting_fill_input,
  plotOutput("waiting_plot")
)
page_four <- tabPanel(
  "Interpretation",
  tags$h4("Donors"),
  p("In this page, the graph shows the blood type of either the living or 
  deceased donor organ from 1988 to 2019. We did not include the data from 
  2020 because it was incomplete. From the graph, we see that theorgans that 
  were the least donated from living donors were the heart, pancreas, and 
  intestine. The most popular blood type of the organs was AB and A. The 
  most donated organ from a living donor was kidneys. This may be because 
  humans have two kidneys and can live off of one, thus there is a higher 
  possibility for a living donor to donate their kidney. The liver was the 
  second most donated organ which could be due to the fact that people 
  can live with half a live because it regenerates cells on its own to become 
  whole again in a matter of months. For the heart, pancreas and intestine, 
  they are all important organs for the body and crucial to live a healthy life 
  so that may be why there is less donations in those three categories.
From the deceased donors, all of the organs had a higher number of donations 
than the living donors. From all the displayed organs, the most popular organ 
blood type donated was AB and the least popular was type B. The least donated 
organ from deceased donors was the intestine. This could be because there is the 
least need for intestine donations. The kidney, liver, and heart donations 
increased immensely which could be due to the fact that heart disease, kidney
disease, and cancers are some of the top ten leading deaths in the U.S. 
Overall, from the pie graph, we see that there is a 16% higher chance of organ 
    donations coming from deceased donors than living donors from 1988 up to 2020."
  
))

ui <- navbarPage(
  "My Application", 
  page_one,         
  page_two,         
  page_three,
  page_four
)
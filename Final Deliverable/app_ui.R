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
  plotOutput("piechart_plot"),
  plotOutput("blood_type_plot"),
  tags$h4("Note:"),
  p("The pie chart shows the proportion of the two types of donors. As you can see, 
    there is more deceased donors than living donors. The interactive part shows users
    the trend of supply of a specific organ throughout the last 30 years. By picking a donor type
    first, then a organ, the graph will mark the trend using different colored lines which 
    represent different blood types for each organ."
  
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
  "Interpretation"
)

ui <- navbarPage(
  "My Application", 
  page_one,         
  page_two,         
  page_three,
  page_four
)
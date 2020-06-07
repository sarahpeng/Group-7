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


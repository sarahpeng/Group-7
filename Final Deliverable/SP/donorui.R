library(shiny)
shinyUI(fluidPage(
  
  titlePanel("Organ Donation Statistics"),
  sidebarLayout(
    sidebarPanel("Percentage of Living vs. Deceased from 1988-2020"),
      mainPanel("")
    )
  )
)

subplot(p1,, nrows = length(plots), shareX = TRUE, titleX = FALSE)


mainPanel(
  tabsetPanel(
    tabPanel("Plot",
             fluidRow(
             )),
    tabPanel("Summary",  verbatimTextOutput("summary"))
  )


df <- read.csv("Donors_Recovered_in_the_U.S._by_Donor_Type.csv", stringsAsFactors = FALSE)
library(shiny)


pie(Reserve_Data$UserDays, labels = Reserve_Data$Category,
    main = "Pie Chart of Living vs. Deceased from 1988-2020")

page_four <- tabPanel(
  "Organ Donation Statistics",
  titlePanel("Percentage of Living vs. Deceased "),
  sidebarLayout( 
    sidebarPanel(
      selectInput(inputId = "",
                  label = "Choose organ",
                  choices = c()
      ),
    ),
    
    mainPanel(
      plotlyOutput("my_plot")
    )
  )
)

page_one <- tabPanel(
  "Organ Donors" 
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

ui <- navbarPage(
  "My Application", 
  page_one
)
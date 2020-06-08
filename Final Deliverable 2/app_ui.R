library(shiny)
library(dplyr)
library(shinythemes)
waiting_time <- read.csv("Organ_by_Blood_Type.csv", stringsAsFactors = FALSE)
library(shiny)
page_one <- tabPanel(
  "Introduction",
  h1(strong("Introduction")), 
  tags$h1("Objective:"),
  tags$h2("Organ donation is an important part of the health care system which has not received enough attention. Many people only have heard about it, however, they either have not signed up to
     be donors nor have them realized the fact that there are lives saved by receiving the right organ. We want to compare the attitudes towards organ donations and transplants to the actual donation
     statistics to see if the correlation between support and action. And probably make more people participate in the system."),
  tags$h1("What we have:"),
  tags$h2("There are three interactive graphs in this app. The donor & organ type graph shows users the trend of the supply of a certain organ from past till now, differentiated by donor types and blood types.
     The trend of supply tells the preference of donors when it comes to organ donation. The waiting list graph visualized the demand of organs differentiated by blood types and age. Combining both graphs,
     users will have findings including but not limited to which organ is most wanted and which organ has more supplies than demands. As for the table, latest information on how general population view organ
     donation is shown. The attitudes and actions are compared."),
  tags$h1("Sources:"),
  tags$h2("Data used is mainly from: "), fluidPage(uiOutput("tab")),
  tags$h2("The survey is from: "), fluidPage(uiOutput("tab2")),
  tags$h1("Contributors:"),
  tags$h2("Savannah Umali-Jepson, Sarah Peng, Lufei Wang, Ming Yan"),
  p(""),
  img(src='logo1.jpg', align = "bottom"),
  img(src='logo2.jpg', align = "bottom")
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
  tags$h1("Donors"),
  tags$h2("In this page, the graph shows the blood type of either the living or
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
     donations coming from deceased donors than living donors from 1988 up to 2020."),
  tags$h1("Note:"),
  tags$h2("The pie chart shows the proportion of the two types of donors. As you can see,
     there is more deceased donors than living donors. The interactive part shows users
     the trend of supply of a specific organ throughout the last 30 years. By picking a donor
     type first, then a organ, the graph will mark the trend using different colored lines
     which represent different blood types for each organ."))
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
page_five <- tabPanel(
  "Conclusion"
)
page_four <- tabPanel("Survey",tags$h1("Background"),
                       tags$h2("The 2019 National Survey of Organ Donation Attitudes and
                          Practices is a nationally representative survey conducted to
                          understand public opinion about organ donation and transplantation,
                          and how those opinions have shifted over time. This survey was
                          completed by 10,000 U.S. adults online or by phone."), tags$h1("Demographics"),
                       tags$h2("Below is a table breakdown of the demographics for the 10,000 people who
                          were surveyed."), tags$h1("Survey Responses"), tags$h2("From the survey participants,
                        23.4% of people personally had or had someone close to them been an
                       organ donor, 16.5% of people personally had or had someone close to them
                        receive an organ transplant, and only 8.3% of people is or knows someone
                       close to them, that is currently waiting for an organ. Of these 10,000 people,
                       50% of them have signed up to be an organ donor, and 69.1% of them would be
                        willing to sign up. While organ donation has not personally affected a majority
                       of the population, most people recognize the importance of donation and are open
                       to the idea of being a donor. How can this number increase?"), tags$h1("Graphs"),
                       tags$h2("When asked if many people in the national transplant waiting list die because the
                          organ they need isn't donated in time, people responded:"),plotOutput("waitlist_plot"),
                       tags$h2("When asked if you strongly support, support oppose, or strongly oppose the donation of organs for transplants,
                          people responded"), plotOutput("transSupport_plot"), tags$h2("When asked if you would want your organs donated after death, people responded"),
                       plotOutput("donateDeath_plot"), tags$h2("And when asked whether you beleive the following statements
                                                          about organ donation are true, people responded"), plotOutput("kidney_plot"),plotOutput("liver_plot"),plotOutput("lung_plot"),
                       tags$h1("Analysis")
)
ui <- navbarPage(
  theme = shinytheme("sandstone"),
  "Organ Donation",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five
)
library(shiny)
library(dplyr)
library(shinythemes)
waiting_time <- read.csv("Organ_by_Blood_Type.csv", stringsAsFactors = FALSE)
library(shiny)
page_one <- tabPanel(
  "Introduction",
  h1(strong("INTRODUCTION")), 
  tags$h1("Objective:"),
  tags$h2("Organ donation is an important part of the health care system which has not received enough attention. While many people are aware of the need for donations, people still have not signed up to
     be donors. We want to compare the attitudes towards organ donations and transplants to the actual donation
     statistics to see if the correlation between support and action."),
  tags$h1("What we have:"),
  tags$h2("This app includes four main pages: Donor Information, Waitlist Information, Survey Information, and Conclusions. At the bottom of each 
  informational page there is an analsis. The donor & organ type graph on the donor page shows users the trend of the supply of a certain organ from 
  1988-2019, differentiated by donor types and blood types. The trend of supply tells the preference of donors when it comes to organ donation. 
  The waiting list graph visualizes the demand of organs differentiated by blood types and age. Combining both graphs,users will have findings 
  including but not limited to which organ is most wanted and which organ has more supplies than demands. As for the table, latest information on how 
  general population view organ donation is shown. The attitudes and actions are compared."),
  tags$h1("Sources:"),
  tags$h2("Graphing Data for Donor & Waitlist pages: "), fluidPage(uiOutput("tab")),
  tags$h2("Survey Data: "), fluidPage(uiOutput("tab2")),
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
  tags$h1("Analysis"),
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
  tags$h1("This page shows the current U.S. Waiting List for Organs."),
  br(),
  tags$h2("In this interactive bar chart,  you can choose an organ type and see the number of people waiting for organ by blood type or age. "),
  br(),
  Waiting_OT_input,
  Waiting_X_input,
  Waiting_fill_input,
  plotOutput("waiting_plot"),
  br(),
  tags$h1("Waiting List:"),
  tags$h2("By comparing the graph across organs, we can see that the kidney is the most in-demand organ.
  The demand for kidney is about 8 times greater than the second in-demand organ, liver.
  This shows that although kidneys can come from living donors, kidney failure is so
  rampant and that there are still not enough donated organs to meet the demand."),
  tags$h2("There are more people with blood type O waiting for donation for all organs.
  This is because people blood type O are compatible only with organs donated by another type O person.
  However, O blood type is the universal donor because all other blood types are also compatible with type O blood.
  Therefore, it is harder for O blood type person to receive the right organ.
  People with AB blood type. in contrast, have the least amount of people waiting for donation because
  AB blood type is compatible with blood types A, B, AB or O and they are the universal recipients."),
  tags$h2("The age group with the largest number of individuals on the transplant waiting list for
  all organs are those aged 50-64 years. Approximately 60 percent of all people waiting for organs are
  50 years and older.There are over 5000 people under the age 18 waiting for
  organ donations. One surprising finding is that more than three quarter of people waiting
  for intestinal are under the age of 18 and the age group with the largest number of individuals
  on the intestine waiting list is children from 1-5 years old.")
)
page_five <- tabPanel(
  "Conclusion", tags$h1(strong("CONCLUSION")), tags$h2("Based on the information and analysis provided on the past three pages a few conclusions can 
                        be drawn. When reviewing the donor page information, we can see that there has been a steady
                        growth in the number of donations for all organ types since 1988. It is important to note
                        that AB positive donors were the most common throughout all years. This surprising, being that
                        AB- and AB+ blood types are the rarest. Among the donor datam we can also see that there were
                        more deceased donors than living and that kidneys were the most common organ to be donated. 
                        The least common organ to be donated was the intestine."), tags$h2("When reviewing the 
                        waitilist information page, it can be seen that kidney was the most in demand organ. This shows
                        a correlation with kidneys being the top donated organ. Although kidneys are donated the most, in
                        efforts to match the high demand, there still remains a large need for more kidney donations. 
                        The number of people waiting for kidneys, is 5 times greater than the number of kidneys donated
                        per year. The waitinglist data also shows that organs with O blood types are in the highest demand. 
                        This makes sense since O- blood types are the univeral donor, meaning that they can be given to anyone.
                        Also this section showed that people ages 56-64, has the highest number of people on the waiting list."),
                        tags$h2("From the survey data, it is clear that people support the concept of donation and know that 
                        people on the waiting list are dying, waiting for an organ match. However, only half of the population
                        is actually signed up as organ donors, and the majority of people do not want to donate once they are deceased.
                                This contradicts the data from the donor page, since more donors are deceased. What this means, is that
                                although people may be signed up as donors, many do not donate while alive. From the survey, it showed
                                that a decent amount of people are unaware that they can donate parts of their kidneys, liver, and lungs,
                                while they are still living. If there is more awareness of this fact, then hopefully more people 
                                will donate while living."),
                        tags$h2("No matter what organs will be needed from as many donors, both living and deceased, as possible. 
                                Through education, analysis, and awareness, we beleive and hope that more people will consider donating.")
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
                       tags$h1("Analysis:"), tags$h2("From the graphs shown, it can be concluded that people recognize the urgency for organ donation and that in theory many people support the idea donating because of this. However, when asked if people would actually want to have their organs donated after death, the majority of people answered no. While it is easy to say and recognize that other people on the organ waiting list need organs, it can be difficult to offer one's own body. People can have several different reasons why they may not want to donate after death.

When reviewing true or false statements (the last three graphs), the survey results show that although many people beleive that kidneys and livers can be donated by living people, only half the population believes that parts of lungs can as well. The corrrect answer to these questions is yes, parts of livers, kidneys, and lungs can be donated by the living. If there is more awareness of these facts, and possibly more advertising of organ donation in general, then maybe people would become more willing to donate their own organs. 

It is important to note, that this data is only survey data, and that the number of deceased donors could be higher, since they cannot take the survey.")
)
ui <- navbarPage(
  theme = shinytheme("cerulean"),
  "Organ Donation",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five
)
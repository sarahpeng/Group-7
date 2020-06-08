library(dplyr)
library(knitr)
library(ggplot2)

graphs <- read.csv('data/graphs.csv')
population <- read.csv('data/population.csv')
sentences <- read.csv('data/sentences.csv')
#optional to include
kable(population, col.names = c("Total", "", "10,000"))

#used as sentences
signedup <- graphs%>% filter(Question == "SignedUp") %>% select(Response, Percent)
willing <- graphs%>%filter(Question == "Willing") %>% select(Response, Percent)

tableSignedUp <- kable(signedup)
tableWilling <- kable(willing)

#bar
waitlistDie <- graphs%>% filter(Question == "WaitlistDie") %>% select(Response,Percent)
ylabel <- c("Strongly Agree", "Somewhat Agree", "Somewhat Disagree", "Strongly Disagree")
waitlist<- ggplot(waitlistDie) + geom_col(mapping = aes(x = reorder(ylabel, -waitlistDie$Percent) , y = waitlistDie$Percent )) + ggtitle("Percent of People who Agree that People on the Waitlist Die") +
  xlab("Response") + ylab("Percent")


transplantSupport <- graphs %>% filter(Question == "TransplantSupport")  %>% select(Response,Percent)
tslabel <- c("Strongly Support","Support","Oppose","Strongly Oppose")
transSupport <- ggplot(transplantSupport) + geom_col(mapping = aes(x = reorder(tslabel, -transplantSupport$Percent) , y =transplantSupport$Percent )) + ggtitle("Percent of People who Support Transplants") +
  xlab("Response") + ylab("Percent")

deathDonate <- graphs%>% filter(Question == "DeathDonate") %>% select(Response,Percent)
ddlabel <- c("Likely Yes","Likely No","Strong No","Strong Yes")
donateDeath <- ggplot(deathDonate) + geom_col(mapping = aes(x = reorder(ddlabel, -deathDonate$Percent) , y = deathDonate$Percent )) + ggtitle("Percent of People who are Willing to Donate Thei Organs After Death") +
  xlab("Response") + ylab("Percent")

# stacked bar
kidney <- graphs%>% filter(Question == "Kidney") %>% select(Response,Percent)
kidneys<- ggplot(kidney) + geom_col(mapping = aes(x = reorder(kidney$Response, -kidney$Percent) , y = kidney$Percent )) + ggtitle("Percent of People whobelieve that kidney") +
  xlab("Response") + ylab("Percent")

liver <- graphs%>% filter(Question == "Liver") %>% select(Response,Percent)
livers<- ggplot(liver) + geom_col(mapping = aes(x = reorder(liver$Response, -liver$Percent) , y = liver$Percent ))  + ggtitle("Percent of People whobelieve that liver") +
  xlab("Response") + ylab("Percent")


lung <- graphs%>% filter(Question == "Lung") %>% select(Response,Percent)
lungs <- ggplot(lung) + geom_col(mapping = aes(x = reorder(lung$Response, -lung$Percent) , y = lung$Percent )) + ggtitle("Percent of People whobelieve that lung") +
  xlab("Response") + ylab("Percent")


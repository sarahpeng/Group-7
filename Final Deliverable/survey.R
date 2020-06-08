library(dplyr)
library(knitr)
library(ggplot2)

graphs <- read.csv('data/graphs.csv')
population <- read.csv('data/population.csv')
sentences <- read.csv('data/sentences.csv')

kable(population, col.names = c("Total", "", "10,000"))

#pie
signedup <- graphs%>% filter(Question == "SignedUp") %>% select(Response, Percent)
willing <- graphs%>%filter(Question == "Willing") %>% select(Response, Percent)

kable(signedup)
kable(willing)

#bar
waitlistDie <- graphs%>% filter(Question == "WaitlistDie") %>% select(Response,Percent)
ggplot(waitlistDie) + geom_col(mapping = aes(x = reorder(waitlistDie$Response, -waitlistDie$Percent) , y = waitlistDie$Percent ))


transplantSupport <- graphs %>% filter(Question == "TransplantSupport")  %>% select(Response,Percent)
ggplot(transplantSupport) + geom_col(mapping = aes(x = reorder(transplantSupport$Response, -transplantSupport$Percent) , y =transplantSupport$Percent ))

deathDonate <- graphs%>% filter(Question == "DeathDonate") %>% select(Response,Percent)
ggplot(deathDonate) + geom_col(mapping = aes(x = reorder(deathDonate$Response, -deathDonate$Percent) , y = deathDonate$Percent ))

# stacked bar
kidney <- graphs%>% filter(Question == "Kidney") %>% select(Response,Percent)
ggplot(kidney) + geom_col(mapping = aes(x = reorder(kidney$Response, -kidney$Percent) , y = kidney$Percent ))

liver <- graphs%>% filter(Question == "Liver") %>% select(Response,Percent)
ggplot(liver) + geom_col(mapping = aes(x = reorder(liver$Response, -liver$Percent) , y = liver$Percent ))

lung <- graphs%>% filter(Question == "Lung") %>% select(Response,Percent)
ggplot(lung) + geom_col(mapping = aes(x = reorder(lung$Response, -lung$Percent) , y = lung$Percent ))


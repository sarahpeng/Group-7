library(dplyr)
library(knitr)
library(ggplot2)

graphs <- read.csv('data/graphs.csv')
population <- read.csv('data/population.csv')
sentences <- read.csv('data/sentences.csv')

kable(population, col.names = c("Total", "", "10,000"))

#pie
graphs%>% filter(Question == "SignedUp") %>% select(Response,Percent)
graphs%>% filter(Question == "Willing") %>% select(Response,Percent)


#bar

graphs%>% filter(Question == "WaitlistDie") %>% select(Response,Percent)

graphs%>% filter(Question == "TransplantSupport") %>% select(Response,Percent)

graphs%>% filter(Question == "DeathDonate") %>% select(Response,Percent)

# stacked bar
graphs%>% filter(Question == "Kidney") %>% select(Response,Percent)

graphs%>% filter(Question == "Liver") %>% select(Response,Percent)

graphs%>% filter(Question == "Lung") %>% select(Response,Percent)

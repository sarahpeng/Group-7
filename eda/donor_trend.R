library(tidyr)
library(ggplot2)
donors <- read.csv("data/donors2.csv", stringsAsFactors = FALSE)
donors[, 1:3] <- sapply(donors[, 1:3], as.numeric)
donor_trend <- donors %>%
  gather(key,value, Living, Deceased) %>%
  ggplot(aes(x=Year, y=value, colour=key)) +
  geom_line() +
  ylab('Counts')+xlab('Year')+ ggtitle("Number of Donors by Year")
library(dplyr)
library(ggplot2)
library(magrittr)


df <- read.csv(file = 'all_donor_data.csv')

# convert to numeric
df[, c(2:34)] <- sapply(df[, c(2:34)], as.numeric)
# drop all ages
df = df[-c(1),]
# get max, min and find range
df$max <- apply(df[, 2:34], 1, max)
df$min <- apply(df[, 2:34], 1, min)
df$range <- df$max - df$min

df <- df %>% 
  rename(
    Age.Group = ï..Age.Group
  )

plot2 <- ggplot(data=df, aes(x=Age.Group, y=range)) +
  xlab("Age Group of Donors") + ylab("Range of Donators") + ggtitle("Range of Donators vs. Age Group of Donors") +
  geom_bar(stat="identity", fill="steelblue") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))


plot2


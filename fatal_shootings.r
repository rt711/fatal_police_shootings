library(readr)
library(ggplot2)
library(dplyr)
require(RCurl)

fpsd <- read.csv(text=getURL("https://raw.githubusercontent.com/rt711/fatal_police_shootings/master/data/fatal-police-shootings-data.csv"), header=T)


head(fpsd)

ggplot(fpsd, aes(x = armed, y = age, col = age)) + 
  geom_boxplot() + ggtitle("Weapon choice by age") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

top10 <- fpsd %>%
  select(date,armed, age, state) %>%
  count(armed) %>%
  top_n(10)

head(top10)

top10_ordered <- top10 %>%
  rename(count = n) %>%
  arrange(desc(count))

ggplot(top10_ordered, aes(x = armed, y = count, size = count, col = armed)) + 
  geom_point() + 
  ggtitle("Weapon frequency") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


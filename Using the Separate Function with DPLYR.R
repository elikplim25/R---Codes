library(tidyverse)

Timestamp2 <- read_excel("C:/Users/User/Desktop/Timestamp2.xlsx")
View(Timestamp2)

#Splitting the Timestamp column and saving the new data as TS1
TS1 <- Timestamp2 %>% separate(Timestamp, c("Date", "Time"), sep = 10)

#Splitting the Time Column in TS1 and saving the new data it as TS2
TS2 <- TS1 %>% separate(Time,  c("Hours", "minute/seconds"), sep = 3)

#Removing the "minute/seconds" column and saving it as TS3
TS3 <- TS2 %>% select(-`minute/seconds`)


WP_3 <- WorldPhones
names <- rownames(WP_3)
rownames(WP_3) <- NULL
WPdata <- cbind(Years,WP_3)
WPdata
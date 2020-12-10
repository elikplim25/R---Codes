library(tidyverse)

#Remove duplicates and assign data frame to new name
ADSC1 <- ADSC %>% distinct(`Name / Nom`, .keep_all = TRUE)

#change column names
colnames(ADSC1) <- c("Timestamp",                                                                             
                     "Name",                                                                         
                     "Number",                                                     
                     "Email",                                                   
                     "Organization",                                                  
                     "Internet Connectivity",
                     "Area_of_Interest",                                             
                     "Expectations",
                     "Country",                                                                            
                     "None1",                                                                                
                     "None2",                                                                                   
                     "Channel")

#Remove unimportant columns
ADSC2 <- ADSC1 %>% select(!(Name:Email))
ADSC3 <- ADSC2 %>% select(!(None1:None2))

#Splitting timestamp column 

ADSC4 <- ADSC3 %>% separate(Timestamp, c("Date", "Time"), sep = 10)
ADSC5 <- ADSC4 %>% separate(Time, c("Hours", "Mins / Secs"), sep = 3)
ADSC6 <- ADSC5 %>% select(-`Mins / Secs`)

#Counting the columns to start visualizing them

Date_ADSC<- ADSC6 %>% count(Date)
colnames(Date_ADSC) <- c("Date", "Number")
VIZ_ADSC<- ggplot(Date_ADSC, aes(Date, Number))+ geom_bar(stat = "identity", fill = "steelblue")+ coord_flip()
VIZ_ADSC + ggtitle("Number of Registrations per Day (18th August - 13th November, 2020)") + geom_text(aes(label = Number), hjust = -0.5, colour = "red") + theme_bw()

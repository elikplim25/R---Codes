library(tidyverse)
library(reshape2)
library(ggrepel)
head(KOJ)

KOJ_1 <- KOJ %>% 
  select(!(X))

#Changing the column names
colnames(KOJ_1) <- c("King", "Age_He_became_King", "Number_of_years_He_Reigned", 
                     "Age_He_Died", "Bible_Reference")

#Reshaping the data
KOJ_2 <- KOJ_1 %>%
  gather(Age_He_became_King, Age_He_Died, key = Ages, value = Number)

#Visualizing the data as a Cleveland Dot plot
ggplot(KOJ_2, 
       aes(x = factor(King, level =c("Zedekiah", "Jehoiachin","Jehoiakim",
                                     "Jehoahaz","Josiah","Amon","Manasseh",
                                     "Hezekiah", "Ahaz","Jotham","Uzziah",
                                     "Amaziah","Jehoash","Ahaziah","Jehoram",
                                     "Jehoshaphat","Asa","Abijah", "Rehoboam",
                                     "Solomon", "David") ), y = Number)) + 
  geom_point(size = 6,aes(colour = Ages)) +
  coord_flip() + 
  theme_bw() +
  geom_line(aes(group = King),colour = "grey", size =2)+
  labs(x = "Names of Kings", title = "Kings of Israel and Judah") + 
  theme(axis.text = element_text(size = 14, face = "bold", colour = "black"), 
        axis.title = element_text(size = 14, face = "bold", colour = "black")) + 
  theme(plot.title = element_text(size =25, face = "bold"))+
  geom_text_repel(aes(label = Number), size = 6, face = "bold") + 
  labs(y = "Number of Years", subtitle = " The Age they became Kings and the Age they Died")


#Bar graph to depict how many years each king spent during their reign

ggplot(KOJ_2 , 
       aes(x = factor(King, level =c("Zedekiah", "Jehoiachin","Jehoiakim",
                                     "Jehoahaz","Josiah","Amon","Manasseh",
                                     "Hezekiah", "Ahaz","Jotham","Uzziah",
                                     "Amaziah","Jehoash","Ahaziah","Jehoram",
                                     "Jehoshaphat","Asa","Abijah", "Rehoboam",
                                     "Solomon", "David") ), y = Number_of_years_He_Reigned)) + 
  geom_bar(stat = "identity", fill = "steelblue") + 
  coord_flip() + 
  theme_bw() + 
  geom_text(aes(label = Number_of_years_He_Reigned), hjust = 
              -1.5, colour = "red")

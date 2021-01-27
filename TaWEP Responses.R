library(tidyverse)
library(stringr)
library(readr)

## A cursory glance at the data
head(TAWEP2112021)
colnames(TAWEP2112021)
str(TAWEP2112021)

##Renaming columns
colnames(TAWEP2112021) <- c("Time", "Name", "Age", "Gender",
                            "Email", "Contact_Number", "Educational_Backround",
                            "Occupation", "Areas_of_Interests")

##Removing duplicates with the "distinct" function and unnecessary columns 
TAWEP_1 <- TAWEP2112021 %>% distinct(Name, .keep_all = TRUE)


###separating the "TIME" column into date and time then further split "Time" into hours and minutes.
TAWEP_3 <- TAWEP_1 %>% separate(Time, c("Date", "Time"), sep = 10)%>%
                  separate(Time, c("Hours", "min/sec"), sep = 3) %>%
                  select(-`min/sec`)

###Gender of registrants visualized

TAWEP_3 %>% count(Gender) %>%
            ggplot(aes(Gender, n)) +
            geom_bar(stat = "identity", fill = "steelblue") + 
            labs(x = "Gender", y = "Number", title = "TAWEP: Registrations by Gender")+
            theme_bw() + 
            geom_text(aes(label = n), vjust = 3, colour = "white", size = 7) + 
            theme(axis.text = element_text(size = 15, colour = "black", face = "bold"),
                  axis.title = element_text(size = 15, face = "bold")) + 
            theme(plot.title = element_text(size = 20, face = "bold"))

###Occupational background of registrants visualized
TAWEP_3 %>% count(Occupation) %>%
  ggplot(aes(Occupation, n)) +
  geom_bar(stat = "identity", fill = "lightblue") + 
  labs(x = "Occupational Background", y = "Number", title = "TAWEP: Registrations by Occupational Background")+
  theme_bw() + 
  geom_text(aes(label = n), vjust = 3, colour = "red", size = 7) + 
  theme(axis.text = element_text(size = 15, colour = "black", face = "bold"),
        axis.title = element_text(size = 15, face = "bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold"))

### Educational backgrounds of registrants visualized

#Rename the various elements in the Educational backgrounds column
 TAWEP_3[TAWEP_3 == "Basic Education (Primary School and Junior High School)"] <- "Basic Education"
 TAWEP_3[TAWEP_3 == "Secondary Education (Senior High School)"] <- "Secondary Education"
 TAWEP_3[TAWEP_3 == "Tertiary Education (University and other higher institutions of learning)"] <- "Tertiary Education"

TAWEP_3 %>% count(Educational_Backround) %>%
  ggplot(aes(Educational_Backround, n)) +
  geom_bar(stat = "identity", fill = "grey") + 
  labs(x = "Level of Education", y = "Number", title = "TAWEP: Registrations by Educational Backround")+
  theme_bw() + 
  geom_text(aes(label = n), vjust = -0.2, colour = "red", size = 7) + 
  theme(axis.text = element_text(size = 15, colour = "black", face = "bold"),
        axis.title = element_text(size = 15, face = "bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold"))


### Age of registrants visualized
TAWEP_3 %>% count(Age) %>% 
  ggplot(aes(Age, n)) +
  geom_bar(stat = "identity", fill = "pink") + 
  labs(x = "Age", y = "Number", title = "TAWEP: Ages of Resgistrants")+
  theme_bw() + 
  geom_text(aes(label = n), vjust = -0.2, colour = "red", size = 7) + 
  theme(axis.text = element_text(size = 15, colour = "black", face = "bold"),
        axis.title = element_text(size = 15, face = "bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold"))

## Dates on which registrations came in visualized

TAWEP_3 %>% count(Date) %>%
  ggplot(aes(Date, n)) +
  geom_bar(stat = "identity", fill = "salmon") + 
  labs(x = "Date", y = "Number", title = "TAWEP: Number of Registrations per Date")+
  theme_bw() + 
  geom_text(aes(label = n), hjust = -0.2, colour = "red", size = 7) + 
  theme(axis.text = element_text(size = 15, colour = "black", face = "bold"),
        axis.title = element_text(size = 15, face = "bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold")) + 
  coord_flip()


### Hours of the day that Participants registered - visualized
TAWEP_3 %>% count(Hours) %>%
  ggplot(aes(Hours, n)) +
  geom_bar(stat = "identity", fill = "skyblue") + 
  labs(x = "Hour", y = "Number", title = "TAWEP: Number of Registrations per Hour of Day")+
  theme_bw() + 
  geom_text(aes(label = n), hjust = -0.2, colour = "red", size = 7) + 
  theme(axis.text = element_text(size = 15, colour = "black", face = "bold"),
        axis.title = element_text(size = 15, face = "bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold")) + 
  coord_flip()

### Areas of Interest Visualized
##Renaming the elements under the AOI column
TAWEP_3[TAWEP_3 == "Get-Ready-for-Work Series"] <- "GRFWS"
TAWEP_3[TAWEP_3 == "Job Readiness (How to land your dream job,  Building your CV)"] <- "JR"
TAWEP_3[TAWEP_3 == "Job Readiness (How to land your dream job,  Building your CV), The Women Empowerment Program (Developing your leadership skills)"] <- "JR/TWEP"
TAWEP_3[TAWEP_3 == "STEM (Science, Technology, Engineering, Mathematics )"] <- "STEM"
TAWEP_3[TAWEP_3 == "STEM (Science, Technology, Engineering, Mathematics ), Job Readiness (How to land your dream job,  Building your CV)"] <- "STEM/JR"
TAWEP_3[TAWEP_3 == "STEM (Science, Technology, Engineering, Mathematics ), Job Readiness (How to land your dream job,  Building your CV), The Women Empowerment Program (Developing your leadership skills)"] <- "STEM/JR/TWEP"
TAWEP_3[TAWEP_3 == "STEM (Science, Technology, Engineering, Mathematics ), The Women Empowerment Program (Developing your leadership skills)"] <- "STEM/TWEP"
TAWEP_3[TAWEP_3 == "The STEM Program"] <- "STEM"
TAWEP_3[TAWEP_3 == "The Women Empowerment Program"] <- "TWEP"
TAWEP_3[TAWEP_3 == "The Women Empowerment Program (Developing your leadership skills)"] <- "TWEP"

TAWEP_3 %>% count(Areas_of_Interests) %>%
  ggplot(aes(Areas_of_Interests, n)) +
  geom_bar(stat = "identity", fill = "springgreen", colour = "red") + 
  labs(x = "Areas of Interests", y = "Number", title = "TAWEP: Areas of Interest of Participants (Combinations)")+
  theme_bw() + 
  geom_text(aes(label = n), hjust = -0.2, colour = "red", size = 7) + 
  theme(axis.text = element_text(size = 15, colour = "black", face = "bold"),
        axis.title = element_text(size = 15, face = "bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold")) + 
  coord_flip()

###Visualizing the total number of registrants for each Module

TAWEP_Totals %>%
  ggplot(aes(Modules, Number)) + 
  geom_col(fill = "wheat1") + 
  labs(x = "Modules", y = "Number", title = "TAWEP: Total number of registrants for each Module")+
  theme_bw() + 
  geom_text(aes(label = Number), vjust = -0.2, colour = "red", size = 7) + 
  theme(axis.text = element_text(size = 15, colour = "black", face = "bold"),
        axis.title = element_text(size = 15, face = "bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold"))


###Exporting the data for each track Module of the program#####

TAWEP_STEM <- TAWEP_3 %>% 
  filter(Areas_of_Interests %in% c("STEM","STEM/JR", "STEM/JR/TWEP", "STEM/TWEP")) %>%
            select(Name, Gender,Email, Contact_Number)
##Output
write.csv(TAWEP_STEM, file = "TAWEP_STEM.csv")

TAWEP_GRFWS <- TAWEP_3 %>%
  filter(Areas_of_Interests %in% c("GRFWS", "JR", "JR/TWEP", "STEM/JR", "STEM/JR/TWEP")) %>%
  select(Name, Gender,Email, Contact_Number)

###Output
write.csv(TAWEP_GRFWS, file = "TAWEP_GRFWS.csv")

TAWEP_TWEP <- TAWEP_3 %>%
  filter(Areas_of_Interests %in% c("TWEP", "JR/TWEP", "STEM/TWEP", "STEM/JR/TWEP")) %>%
  select(Name, Gender,Email, Contact_Number)
###Output
write.csv(TAWEP_TWEP, file = "TAWEP_TWEP.csv")


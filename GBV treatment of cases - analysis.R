library(tidyverse)
head(DovvHQ)
colnames(DovvHQ)

#Sorting and filtering the 2016 data 
Treatcases <- DovvHQ %>% select(OFFENCES, `S/COURT`,`CONVICTED`, `A&D`, `A&T`, `CLOSED CASES`, `UNDER INVEST`, `TOTAL`) %>% 
           filter(OFFENCES %in% c("ATTEMPTED DEFILEMENT","ATTEMPTED RAPE","CARNAL KNOWLEDGE OF FEMALE IDIOT",
                                  "DEFILEMENT", "INDECENT ASSAULT", "RAPE", "UNNATURAL CARNAL KNOWLEDGE"))
#adding the Year column to the 2016 data

Treatcases<- Treatcases %>% mutate(Year = paste0("2016"))

#Sorting and filtering the 2017 data 
Treatcases2 <- seventeen %>% select(OFFENCES, `S/COURT`,`CONVICTED`, `A&D`, `A&T`, `CLOSED CASES`, `UNDER INVEST`, `TOTAL`) %>% 
  filter(OFFENCES %in% c("ATTEMPTED DEFILEMENT","ATTEMPTED RAPE","CARNAL KNOWLEDGE OF FEMALE IDIOT",
                         "DEFILEMENT", "INDECENT ASSAULT", "RAPE", "UNNATURAL CARNAL KNOWLEDGE"))

#adding the Year column to the 2017 data
Treatcases2 <-Treatcases2 %>% mutate(Year = paste0("2017"))

#Sorting and filtering the 2018 data 
Treatcases3 <- eighteen %>% select(OFFENCES, `S/COURT`,`CONVICTED`, `A&D`, `A&T`, `CLOSED CASES`, `UNDER INVEST`, `TOTAL`) %>% 
  filter(OFFENCES %in% c("ATTEMPTED DEFILEMENT","ATTEMPTED RAPE","CARNAL KNOWLEDGE OF FEMALE IDIOT",
                         "DEFILEMENT", "INDECENT ASSAULT", "RAPE", "UNNATURAL CARNAL KNOWLEDGE"))

#adding the Year column to the 2017 data
Treatcases3 <- Treatcases3 %>% mutate(Year = paste0("2018"))

#merging the data

hwt <- merge(Treatcases, Treatcases2, all = TRUE)
Treatment_of_Cases <- merge(hwt, Treatcases3, all = TRUE)

#exporting the data as a CSV
write.csv(Treatment_of_Cases, file = "Treatment.csv")

#Further melting the data 
melt(Treatment_of_Cases, variable.name = "Treatment of Cases", value.name = "Number")

#exporting the data as a CSV
write.csv(melted_treatment, file = "mtreat.csv")



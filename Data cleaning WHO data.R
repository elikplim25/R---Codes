library(tidyr)
library(dplyr)
library(stringr)

#Gathering the individual columns
WHO_new <- who %>% gather(new_sp_m014:newrel_f65,
                          key = "key",
                          value = "cases",
                          na.rm = TRUE)

#Using the stringr to replace newrel with new_rel in the 'key' column
WHO_new2 <- WHO_new %>% 
            mutate(key = stringr::str_replace(key, "newrel", "new_rel"))

#separating the individual elements under the key column
WHO_new3 <- WHO_new2 %>% separate(key, 
                                  c("new", "type", "Sexage"),
                                  sep = "_")

# further separating the individual elements under the key column into sex and age

WHO_new4 <- WHO_new3 %>% separate(Sexage, 
                                  c("Sex", "Age range"),
                                  sep = 1)
#removing the 'new, 'iso2' and 'iso3' column from the data set
who_new5 <- WHO_new4 %>% select(-new, -iso2, -iso3)

#separating the ages in age range columns with a dash
Who_new6 <- who_new5 %>% 
  mutate(`Age range` = stringr::str_replace(`Age range`,"014","0-14"))
Who_new7 <- Who_new6 %>% 
  mutate(`Age range` = stringr::str_replace(`Age range`,"1524","15-24"))
Who_new8 <- Who_new7 %>% 
  mutate(`Age range` = stringr::str_replace(`Age range`,"2534","25-34"))
Who_new9 <- Who_new8%>% 
  mutate(`Age range` = stringr::str_replace(`Age range`,"3544","35-44"))
Who_new99 <- Who_new9 %>% 
  mutate(`Age range` = stringr::str_replace(`Age range`,"4554","55-64"))


view(Who_new99)

#exporting the data as a Microsoft excel file
write_excel_csv(Who_new99, "WHOdata.csv")


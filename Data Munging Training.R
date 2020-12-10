library(magrittr)
library(tidyverse)

url <- "http://lib.stat.cmu.edu/datasets/wseries"
series <- scan( url,skip = 35,nlines = 23,what = list(year = integer(0),
                                                      pattern = character(0)))


#Permutation ordering the columns
perm <- order(series$year)
series <- list(year = series$year[perm],
                pattern = series$pattern[perm])
series$year
series$pattern

#this changes the FY column from integers to factors (just like in tableau)
companiesData$fy <- factor(companiesData$fy, ordered = TRUE)

#adding a new column called 'margin'
companiesData$margin <- (companiesData$profit / companiesData$revenue) * 100

#round figures under 'margin'
companiesData$margin <- round(companiesData$margin, 1)

#creating margin in 'tidyverse'
companiesData %>% mutate(Margin = round(profit / revenue*100, 1))

delays <- Newyorkflights %>% 
          group_by(dest) %>%
          summarise(
            count = n(),
            dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE)
          ) %>%
  filter(count > 20, dest!= "HNL")

head(delays)




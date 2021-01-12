library(inspectdf)
library(tidyverse)

view(starwars)

#Inspecting data frame to expose NAs and plot that data
inspect_na(starwars) %>%
  show_plot()

#Inspecting data frame to summarize the levels of each category and plot that data
inspect_cat(starwars) %>%
  show_plot()

#Inspecting data frame to summarize Pearson, Kendall and Spearman corelation of numeriacal columns and plot that data
inspect_cor(starwars) %>% 
  show_plot()

#Inspecting data frame to summarize the most common level in each categorical column and plot that data
inspect_imb(starwars) %>%
  show_plot()

#Inspecting data frame to summarize the memory usage in each column and plot that data
inspect_mem(starwars) %>%
  show_plot()

#Inspecting data frame to summarize the numeric columns and plot that data
inspect_num(starwars) %>%
  show_plot()

### All of these functions can work with either one or grouped data frames at a time.
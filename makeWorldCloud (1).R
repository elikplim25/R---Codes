library(tidytext)
library(dplyr)
library(tibble)
library(wordcloud2)

wordsLoc <- "~/Documents/Trainings/GIZ_Agenda_2030/files/expectations_wrg.txt"
text <- readLines(con = wordsLoc)

text_df <- tibble(line = 1:length(text), text = text)

text_df <- text_df %>% 
           unnest_tokens(word, text) %>% 
           anti_join(stop_words) %>% 
           count(word, sort = TRUE)

names(text_df) <- c("word", "freq")

# 
wordcloud2(text_df, size = 1)
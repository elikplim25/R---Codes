library(tidyverse)
library(tm)
library(wordcloud2)
library(tidytext)
library(RColorBrewer)

Review_data <- read.csv("C:\\Users\\PAS\\Documents\\t_kjv.csv", header = TRUE, stringsAsFactors = FALSE)
View(Review_data)

tidy_data <- Review_data %>% 
            unnest_tokens(word, t)
view(tidy_data)
word_count <- tidy_data %>%
  count(word, sort = TRUE)
view(word_count)

word_count <- tidy_data %>%
  anti_join(stop_words)%>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE)

word_count %>% 
  group_by(sentiment) %>% 
  #filter(sentiment == "positive") %>%
  top_n(20)%>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) + geom_col(show.legend = TRUE)+
  facet_wrap(~sentiment, scales = "free_y") + 
  labs(y = "contribution to sentiment", x = NULL, title = "Sentiment Analysis: Top 20 Positive and Negative words of the Bible") +
  coord_flip() + geom_text(aes(label = n), hjust = 2, size = 4) + theme_bw()

wordcloud2(tidy_data, size = 1)

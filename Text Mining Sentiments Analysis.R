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
word_count1 <- tidy_data %>%
  count(word, sort = TRUE)
view(word_count1)

word_count1 <- tidy_data %>%
  anti_join(stop_words)%>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE)

word_count1 %>% 
  group_by(sentiment) %>% 
  #filter(sentiment == "positive") %>%
  top_n(20)%>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) + geom_col(show.legend = TRUE)+
  facet_wrap(~sentiment, scales = "free_y") + 
  labs(y = "contribution to sentiment", x = NULL, title = "Sentiment Analysis: Top 20 Positive and Negative words of the Bible") +
  coord_flip() + geom_text(aes(label = n), hjust = 2, size = 4) + theme_bw()

#Creating a word cloud out for this data
wc <- word_count1 %>%
  select(!sentiment)

wordcloud2(wc, size = 1, shape = "diamond")

library(tidyverse)
library(tidytext)
library(wordcloud2)

##Reading in the data
Lyrics <- read.csv("C:\\Users\\PAS\\Documents\\Lyrics.csv", header = TRUE, stringsAsFactors = FALSE)

##Tokenizing the words
Lyrics_1 <- Lyrics %>% 
  unnest_tokens(word, Text)
view(Lyrics_1)

##Counting the words
Lyrics_2 <- Lyrics_1 %>%
  count(word, sort = TRUE)
view(Lyrics_2)

##Sentiments analysis
Lyrics_3 <- Lyrics_1 %>%
  #anti_join(stop_words)%>%
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment, sort = TRUE)

##Making the word cloud 

wordcloud2(Lyrics_2)

##making bar graph including stop words

Lyrics_2 %>%
  top_n(20) %>%
  ggplot(aes(reorder(word, n), n)) +
  geom_col(fill = "firebrick3") + 
  coord_flip() + 
  geom_text(aes(label = n), hjust = 2, colour = "white", size = 5) + 
  theme_bw() + 
  labs(x = "WORDS", y = "NUMBER", title = "Frequency of top 20 words in 'So Will I' lyrics (without stopwords) #Hillsong") + 
  theme(axis.text=element_text(size=15, face = "bold", colour = "black"),axis.title=element_text(size=20,face="bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold"))
  

##making bar graph excluding stop words
Lyrics_4 <- Lyrics_1 %>%
  anti_join(stop_words)%>%
  count(word,sort = TRUE)

Lyrics_4[1:20,] %>%
  ggplot(aes(reorder(word, n), n)) +
  geom_col(fill = "coral4") + 
  coord_flip() + 
  geom_text(aes(label = n), hjust = 2, colour = "white", size = 5) + 
  theme_bw() + 
  labs(x = "WORDS", y = "NUMBER", title = "Frequency of top 20 words in 'So Will I' lyrics #Hillsong") + 
  theme(axis.text=element_text(size=15, face = "bold", colour = "black"),axis.title=element_text(size=20,face="bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold"))


##Bar graph to visualize the sentiments expressed in the lyrics

Lyrics_5 <- Lyrics_1 %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE)


Lyrics_6 <- Lyrics_3 %>% count(sentiment)
colnames(Lyrics_6) <- c("Sentiment", "Number")


Lyrics_6 %>%
  ggplot(aes(reorder(Sentiment, Number), Number)) +
  geom_col(fill = "darkorange1") + 
  coord_flip() + 
  geom_text(aes(label = Number), hjust = 2, colour = "black", size = 7) + 
  theme_bw() + 
  labs(x = "WORDS", y = "NUMBER", title = "Frequency of Sentiments in 'So Will I' Lyrics #Hillsong") + 
  theme(axis.text=element_text(size=15, face = "bold", colour = "black"),axis.title=element_text(size=20,face="bold")) + 
  theme(plot.title = element_text(size = 20, face = "bold"))

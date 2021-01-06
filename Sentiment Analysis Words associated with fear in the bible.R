
library(tidyverse)
library(tm)
library(tidytext)
library(RColorBrewer)

##loading the bible data into R
Review_data <- read.csv("C:\\Users\\PAS\\Documents\\t_kjv.csv", header = TRUE, stringsAsFactors = FALSE)
View(Review_data)

##Unnest into tokens
tidy_data <- Review_data %>% 
  unnest_tokens(word, t)
view(tidy_data)

###counting the number of times the words appear in the full text 
word_count <- tidy_data %>%
  count(word, sort = TRUE)
view(word_count)

## removing stopwords and also using the NRC sentiment analysis
word_count <- tidy_data %>%
  anti_join(stop_words)%>%
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment, sort = TRUE)

### Filtering out the words that were expressed in fear in the bible
word_fear <- word_count %>% 
  group_by(sentiment) %>%
  filter(sentiment == "fear") 

###change the column names
colnames(word_fear) <- c("Word", "Fear", "Number_of_Words")

###Data munging to prepare data for analysis
fear_Top10<- word_fear %>% 
  filter(Word == c("god","evil","fire","sin",
                   "fear","death","wicked",
                   "die","pray","wilderness")) %>%
  mutate(Top_Bottom = "Top")

fear_Bottom10 <- word_fear %>%
  filter(Word == c("superstitious",
         "threaten","threatening","traitor",
         "treachery","uprising","venom",
         "venomous","warrior","yell")) %>%
  mutate(Top_Bottom = "Bottom")

Fear_TOPs <-merge(fear_Top10, fear_Bottom10, all = TRUE)

###Data Visualization with GGPLOT2

#top 10 words
ggplot(fear_Top10, aes(reorder(Word, Number_of_Words), Number_of_Words)) +
  geom_bar(stat = "identity", fill = "steelblue")+
  coord_flip()+
  theme_bw()+
  labs(x = "Word", y = "Number", title = "Sentiment Analysis: Top 10 words associated with fear in the Bible")+ 
  geom_text(aes(label = Number_of_Words), hjust = -0.1, colour = "red", size = 5) + 
  theme(axis.text=element_text(size=16, color = "black", face = "bold"),axis.title=element_text(size=14,face="bold")) + 
  theme(plot.title = element_text(size = 25, face = "bold"))
  
  


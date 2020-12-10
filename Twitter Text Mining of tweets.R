library(rtweet)
library(tidyverse)
library(httpuv)



twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret)

token <- create_token(
  app = "XXX XXXXXXX",
  consumer_key = key,
  consumer_secret = secret)

tweet_df <- search_tweets("The NDC", n = 200, 
                          include_rts = FALSE)
dim(tweet_df
    )

rt <- search_tweets("#adsc2020",  n = 100,retryonratelimit = TRUE,
                    include_rts = FALSE,since = "2020-11-10", until = "2020-11-12")

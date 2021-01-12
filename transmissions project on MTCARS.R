library(tidyverse)
head(mtcars)

#making the rownames into a column
mtrows <- mtcars
names <- rownames(mtrows)
rownames(mtrows) <- NULL
mtrows <- cbind(names,mtrows)

#Selecting the columns to work with
mpg_transmission <- mtrows %>% select(names, mpg, am)

#arranging the 'am' column to distinguish between automatic and manually transmitted cars
mpg_transmission %>% arrange(am)

#Putting automatic and manual cars in separate data frames
mpg_auto<- mpg_transmission %>% filter(am == 0)
mpg_man <- mpg_transmission %>% filter(am ==1)

#Creating a whole new column in both data frames and labelling them with the appropriate transmission
mpg_auto <- mpg_auto %>% mutate(Transmission = paste0("Automatic"))
mpg_man <- mpg_man %>% mutate(Transmission = paste0("Manual"))

#merging the two data frames
Transmerge <- merge(mpg_auto, mpg_man, all = TRUE
      )
#replacing all NAs in the transmission column with 'automatic'
TransMerge$Transmission[is.na(TransMerge$Transmission)] <- "Automatic"

#removing the 'am' column from the data set
TransMerge %>% select(-am)

#Visualizing to distinguish between the miles per gallon of automatic and manual cars
GG <- ggplot(TransMerge, aes(x=reorder(names, mpg),y =  mpg, fill = Transmission)) 
GG + geom_bar(stat = "identity") + coord_flip() + theme_bw() + labs(x = "names", y = "Miles Per Gallon", title = "Miles Per Gallon for Automatic/Manual cars in the MTCARS Data set")+ geom_text(aes(label = mpg), hjust = -0.3, colour = "red")

       
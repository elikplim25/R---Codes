library(readxl)
library(writexl)
library(dplyr)



xl_file_path <- "C:\\Users\\User\\Desktop\\HDR 2007-2008 Table 01.xls"

#Reading excel sheet into R from Low Medium Development session

wb_data_1 <- read_excel(path = file.choose(),
                        col_types = c("text", "text", "skip", "text",
                                      "skip","text","skip", "text", 
                                      "skip", "text", "skip","skip",
                                      "skip","skip","skip","skip","skip",
                                      "skip","skip","skip","skip","skip",
                                      "skip","skip","skip","skip","skip","skip",
                                      "skip","skip","skip"), range = cell_rows(13:82),
                        na=(".."), col_names = FALSE)
wb_data_1 <- wb_data_1 %>% mutate(category = "High Human Development")

#Reading excel sheet into R from Medium Development session
wb_data_2 <- read_excel(path = file.choose(),
                        col_types = c("text", "text", "skip", "text",
                                      "skip","text","skip", "text", 
                                      "skip", "text", "skip","skip",
                                      "skip","skip","skip","skip","skip",
                                      "skip","skip","skip","skip","skip",
                                      "skip","skip","skip","skip","skip","skip",
                                      "skip","skip","skip"), range = cell_rows(84:168),
                        na=(".."), col_names = FALSE)
wb_data_2 <- wb_data_2 %>% mutate(category = "Medium Human Development")

#Reading excel sheet into R from Low  Development session

wb_data_3 <- read_excel(path = file.choose(),
                        col_types = c("text", "text", "skip", "text",
                                      "skip","text","skip", "text", 
                                      "skip", "text", "skip","skip",
                                      "skip","skip","skip","skip","skip",
                                      "skip","skip","skip","skip","skip",
                                      "skip","skip","skip","skip","skip","skip",
                                      "skip","skip","skip"), range = cell_rows(170:191),
                        na=(".."), col_names = FALSE)

wb_data_3 <- wb_data_3 %>% mutate(category = "Low Human Development")


#Giving header names to the 3 datasets created
names(wb_data_1) <- c("HDI_Rank", "Country", "HDI_2005", "LE_2005", 
                      "ALR_1995-2005", "CE_GDP", "Category")

names(wb_data_2) <- c("HDI_Rank", "Country", "HDI_2005", "LE_2005", 
                      "ALR_1995-2005", "CE_GDP", "Category")

names(wb_data_3) <- c("HDI_Rank", "Country", "HDI_2005", "LE_2005", 
                      "ALR_1995-2005", "CE_GDP", "Category")

#Merging the 3 data sets

WorldBank_Data <- merge(wb_data_1, wb_data_2, all = TRUE)

WorldBank_Data <- merge(WorldBank_Data, wb_data_3, all = TRUE)

#Exporting as a Microsoft Excel Data

writexl::write_xlsx(x = WorldBank_Data, path = "World_Bank Data.xlsx")

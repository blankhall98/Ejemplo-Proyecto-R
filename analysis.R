library(readr)
library(ggplot2)
library(dplyr)
poverty_database <- read_csv("data/poverty_database.csv")
View(poverty_database)

colnames(poverty_database)

years <- c(1960:2022)
years <- as.character(years)

important_columns <- c("Country Code",years)


database <- poverty_database[,important_columns]
names(database)[names(database) == "Country Code"] <- "country_code"

code <- "ALB"
sub <- database %>% filter(country_code == code)
sub <- sub %>% select(where(~ !any(is.nan(.))))
View(sub)

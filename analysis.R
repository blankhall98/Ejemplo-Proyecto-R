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

filter_base <- function(df,code){
  sub <- database %>% filter(country_code == code)
  sub <- sub %>% select(where(~ !any(is.nan(.))))
  
  value_row <- sub %>% slice(1) %>% select(2:ncol(sub))
  
  value_vector <- as.vector(unlist(value_row))
  
  sub_df <- data.frame(
    years <- years,
    value <- value_vector
  )
  
  p <- ggplot(sub_df, aes(x = years, y = value)) +
    geom_line() +
    geom_point() +
    ggtitle(paste("Time Series Data for", code)) +
    xlab("Year") +
    ylab("Value")
  
  print(p)
}


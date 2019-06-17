library(ggplot2)
library(readr)
library(dplyr)
library(magrittr)
library(ggthemes)
library(stringr)
library(tools)

full_trains <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-26/full_trains.csv")

# Visualisation 3 ####
full_trains %>% 
  filter(str_detect(departure_station, "PARIS")) %>%
  mutate(departure_station = toTitleCase(tolower(departure_station))) %>%
  group_by(month, year, departure_station) %>%
  summarise(mean_num_of_canceled_trains = mean(num_of_canceled_trains, na.rm = TRUE)) %>%
  ggplot(aes(x = departure_station, 
             y = mean_num_of_canceled_trains,
             colour = departure_station)) +
  geom_jitter(width = .2, alpha = .6, size = 5, stroke = 1) +
  guides(colour = FALSE) +
  coord_flip() +
  labs(x = NULL, y = NULL, 
       title = "Cancelled Trains from Paris Railway Stations by Year",
       subtitle = "Average Number of Cancellations per Month") +
  theme(text = element_text(size = 12)) +
  scale_color_tableau() +
  facet_wrap(~ year) 

# TidyTuesday 2022 week 29 2022-07-19
# Technology adoption

# load data and library
tuesdata <- tidytuesdayR::tt_load('2022-07-19')
technology <- tuesdata$technology

library(tidyverse)
library(ggplot2)
library(countrycode) # countrycode library to convert between iso3c name to country name

# subset out "energy" category to make dataset easier to examine/ explore and focus on year "2019" only
energy <- filter(technology, category == "Energy")
energy_2019 <- energy %>% 
  filter(year == 2019) %>%
  group_by(country_name)

# changing country name from iso3c to full name since map package are using full name format
energy$country_name <- countrycode(energy$iso3c, origin = 'iso3c', destination = 'country.name')

world_map <- map_data("world")
world_map$region<- ifelse(world_map$region == "USA", "United States",world_map$region)

# final plot, using log scale to enable better contrast
ggplot(subset(energy_2019, label %in% "Gross output of electric energy (TWH)"), aes(map_id = country_name)) +  
  geom_map(aes(fill = value), map = world_map) +
  scale_fill_gradientn(trans = "log10", colors = hcl.colors(10, "RdYlBu")) + 
  scale_color_binned() + 
  expand_limits(x = world_map$long, y = world_map$lat) +
  ggtitle("Gross output of electric energy in 2019 (TWH)") + 
  labs(fill = "energy output (log 10)") +
  theme(plot.title = element_text(family = "serif", hjust = 0.5, size = rel(1.5)), plot.caption.position = "plot", plot.caption = element_text(hjust = 1),
        legend.position = c(0.1, 0.25), legend.background = element_blank(),
        axis.title.x = element_blank(), axis.title.y = element_blank(), axis.text.x  = element_blank(), axis.text.y  = element_blank())  # remove x, y axis  

ggplot(subset(energy_2019, label %in% c("Electricity from hydro (TWH)", "Electricity from solar (TWH)", "Electricity from wind (TWH)","Electricity from other renewables (TWH)")), aes(map_id = country_name)) +  
  geom_map(aes(fill = value), map = world_map) +
  scale_fill_gradientn(trans = "log10", colors = hcl.colors(10, "RdYlBu")) + 
  #scale_fill_gradientn(colors = hcl.colors(50, "RdYlGn")) +  # must specify n in hcl.colors
  scale_color_binned() + 
  expand_limits(x = world_map$long, y = world_map$lat) +
  ggtitle("Renewable energy output in 2019 (TWH)") + 
  labs(fill = "energy output (log 10)") +
  theme(plot.title = element_text(family = "serif", hjust = 0.5, size = rel(1.5)), plot.caption.position = "plot", plot.caption = element_text(hjust = 1),
        legend.position = c(0.1, 0.25), legend.background = element_blank(),
        axis.title.x = element_blank(), axis.title.y = element_blank(), axis.text.x  = element_blank(), axis.text.y  = element_blank()) 

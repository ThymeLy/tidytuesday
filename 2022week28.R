## tidyTuesday 2022 Week 28 2022.07.12

# setup and load library
library(dplyr)
tuesdata <- tidytuesdayR::tt_load('2022-07-12')
flights <- tuesdata$flights
library(ggridges)
library(ggplot2)
library(tidyverse)

# percentage change by year 
perc_change_flights <- 
  flights %>% group_by(STATE_NAME, YEAR) %>%
  summarise(total_flight = sum(FLT_TOT_1, na.rm = TRUE)) %>%
  mutate(perc_change = (total_flight - lag(total_flight))/lag(total_flight))

# ----- heatmap plot of yearly percentage change
ggplot(perc_change_flights, aes(x = YEAR, y = STATE_NAME, fill = perc_change)) + 
  # scale_fill_gradient(low = "white", high = "red")  +
  scale_fill_gradientn(colors = hcl.colors(20, "RdYlGn")) +
  geom_tile(color = "white", lwd = 1, linetype = 1) +  
  # to show all year instead of just alternate one (cannot use xlim)
  scale_x_discrete(limits = c(2016, 2017, 2018, 2019, 2020, 2021, 2022), guide = guide_axis(angle = -50)) + 
  coord_equal()  +         # to draw square instead of rectangle
  theme(text=element_text(family="sans"), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.title = element_text(family = "serif", hjust = 0.5), plot.caption.position = "plot", plot.caption = element_text(hjust = 1)) + 
  ggtitle(label = "Number of flights from 2016 to 2022 ")

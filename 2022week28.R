## tidyTuesday 2022 Week 28 2022.07.12

# setup and load library
library(dplyr)
tuesdata <- tidytuesdayR::tt_load('2022-07-12')
flights <- tuesdata$flights
library(ggridges)
library(ggplot2)

# clean data by removing na
cleaned_flights <- na.omit(flights)
nrow(cleaned_flights)

# ------ ridge plot
ggplot(cleaned_flights, aes(x = YEAR, y = STATE_NAME, fill = STATE_NAME, group = STATE_NAME)) +
  geom_density_ridges() +
  theme_ridges() +
 theme(legend.position = "none", axis.title.x = element_blank(), axis.title.y = element_blank())

# ----- heatmap plot 
ggplot(cleaned_flights, aes(x = YEAR, y = STATE_NAME, fill = FLT_DEP_1)) + 
  geom_tile(color = "white", lwd = 1, linetype = 1) +  
  scale_x_discrete(limits = c(2016, 2017, 2018, 2019, 2020, 2021, 2022), guide = guide_axis(angle = -50)) +  # to show all year instead of just alternate one (cannot use xlim)
  coord_equal()  +  # to draw square instead of rectangle
  theme(legend.position = "none", axis.title.x = element_blank(), axis.title.y = element_blank())

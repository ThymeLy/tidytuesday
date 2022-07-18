# TidyTuesday 2022 week 3 - chocolate
# Viz inspiration from https://twitter.com/KittJonathan/status/1483716556127453185/photo/1
# Sankey diagram inspiration from https://www.data-to-viz.com/graph/sankey.html

# load data and library
tuesdata <- tidytuesdayR::tt_load('2022-01-18')
chocolate <- tuesdata$chocolate

library(tidyverse)
library(networkD3)

# retain only main columns
choc_shortened <- chocolate[c("country_of_bean_origin", "cocoa_percent", "ingredients", "rating")]

# round off rating 
choc_shortened$rating <- round(choc_shortened$rating, 0)

# calculate rating assoc with each country to give value for Sankey diagram, retaining only n > 10
choc4sankey <- choc_shortened %>% group_by(country_of_bean_origin, rating) %>% count() %>% filter(n>10) %>% arrange(desc(rating))

# Create nodes for source and target dataframe
nodes <- data.frame(name=c(as.character(choc4sankey$rating), as.character(choc4sankey$country_of_bean_origin)) %>% unique())

# Match source and target ID position
choc4sankey$IDsource=match(choc4sankey$rating, nodes$name)-1 
choc4sankey$IDtarget=match(choc4sankey$country_of_bean_origin, nodes$name)-1

# plot Sankey diagram, iterations = 0 to position rating 4 at the top
sankey <- sankeyNetwork(Links = choc4sankey, Nodes = nodes,
              Source = "IDsource", Target = "IDtarget",
              Value = "n", NodeID = "name", 
              nodeWidth=40, fontSize=13, iterations = 0, width = 900, height = 580)

# append plot title
htmlwidgets::prependContent(sankey, htmltools::tags$h1("Which country produced the best chocolate?", style= "text-align:center"))

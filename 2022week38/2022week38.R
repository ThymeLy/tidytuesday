## tidyTuesday 2022 Week 38 2022.10.05

library(sf)
library(tidyverse)
library(ggplot2)
library(ggtext) 
JP_shapefile <- st_read("C:/Users/81707/Downloads/Japan shapefile/JPN_adm1.shp")

# load data
tuesdata <- tidytuesdayR::tt_load(2022, week = 38)
HydroWASTE_v10 <- tuesdata$HydroWASTE_v10
Japan_WWTP <- HydroWASTE_v10 %>% filter(COUNTRY == "Japan")
windowsFonts("Georgia" = windowsFont("Georgia"))    # import font

# plot
ggplot(data = JP_shapefile) +
  geom_sf(fill = "grey10") +
  ggtitle("Wastewater Treatment Plants in Japan") +
  labs (subtitle = "Distribution of wastewater treatment plants in Japan, shown by each <span style='color:#addbdb'><b>dot</b></span>.<br>Treatment plants less than 10 km from coast is coloured <span style='color:#EA337E'><b>pink</b></span>.",
        caption = "Source: Ehalt Macedo, H., Lehner, B., Nicell, J., Grill, G., Li, J., Limtong, A., and Shakya, R.: \nDistribution and characteristics of wastewater treatment plants within the global river network, Earth Syst. Sci. Data, 14, 559–577, 2022. \n TidyTuesday 2022 week38") +
  geom_point(data = Japan_WWTP, aes(x = LON_WWTP, y = LAT_WWTP), size = 0.8, color = "#addbdb") +
  geom_point(data = filter(Japan_WWTP, COAST_10KM == 1), aes(x = LON_WWTP, y = LAT_WWTP), size = 0.8, color = "#EA337E") + # "#FCF050"
  coord_sf(xlim = c(120, 155), ylim = c(24, 46), expand = FALSE) +
  theme_void() +
  theme(
        plot.background = element_rect(fill = "grey20"),
        panel.grid = element_blank(),
        legend.position = "bottom",
        plot.subtitle = element_markdown(color = "grey95", size = rel(1.1), family = "Georgia"),  
        plot.caption = element_text(color = "grey80", hjust = 1),
        plot.title = element_text(color = "grey95", size = rel(2), family = "Georgia"),
        plot.margin = margin(0.5,0.5,0.5,1, "cm"))

ggsave('2022week38_JP_wastewater_distr.png', width = 10, height = 8.7)



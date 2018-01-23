# This function creates a leaflet map with a map number

library(tidyverse)
library(leaflet)

map_finnic <- function(map =  "151"){
  
  my_colors <-
    c(
      "#1f77b4",
      "#ff7f0e",
      "#2ca02c",
      "#d62728",
      "#9467bd",
      "#8c564b",
      "#e377c2",
      "#7f7f7f",
      "#17becf",
      sample(grDevices::colors()[!grepl("ivory|azure|white|gray|grey|black|pink|1",
                                        grDevices::colors())])
    )
  corpus <- read_rds("data/kettunen.rds")
  current_selection <- corpus %>% filter(map_id == map)
  pal <- colorFactor({my_colors[1:length(unique(current_selection$feature_value))]},
                     domain = current_selection$feature_value)
  
  title_text <- current_selection$feature_description[1] %>% as.character()
  
  current_selection <- current_selection %>% mutate(popup_text = glue("<b>{location}:</b></br>{feature_value}"))
  
  leaflet(data = current_selection) %>%
    addTiles() %>%
    addCircleMarkers(color = ~pal(feature_value),
                     radius = 4,
                     stroke = FALSE, fillOpacity = 0.5,
                     popup = ~popup_text) %>%
    addLegend("bottomleft", pal = pal, values = ~feature_value,
              title = title_text,
              opacity = 1
    )
  
}

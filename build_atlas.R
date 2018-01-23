## This is the script that reads the shapefile and does everything

# devtools::install_github('rstudio/bookdown')

library(tidyverse)
library(leaflet)
library(sf)
library(glue)
library(bookdown)

source("R/map_finnic.R")
source("R/write_atlas_page.R")

1:10 %>% walk(write_atlas_page)

bookdown::render_book("index.Rmd", "bookdown::gitbook", output_dir = "docs")

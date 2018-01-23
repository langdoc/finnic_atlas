## This is the script that reads the shapefile and does everything

# devtools::install_github('rstudio/bookdown')

library(tidyverse)
library(leaflet)
library(sf)
library(glue)
library(bookdown)

# download.file("http://avaa.tdata.fi/adata/kotus/kettunen.zip", "data/kettunen.zip")

unzip("data/kettunen.zip", exdir = "data", overwrite = TRUE)

source("R/parse_kettunen.R")
source("R/map_finnic.R")
source("R/write_atlas_page.R")

1:20 %>% walk(write_atlas_page)

bookdown::render_book("index.Rmd", "bookdown::gitbook", output_dir = "docs")

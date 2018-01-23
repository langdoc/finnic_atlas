# This reads the Kettunen's atlas.

# This function was copy-pasted from somewhere in sf issues 
# I want to store the geometry in latitude and longitude
# columns, but in order to do the projection transformation
# I want to have it in sf geometry too

sfc_as_cols <- function(x, names = c("longitude","latitude")) {
  stopifnot(inherits(x,"sf") && inherits(sf::st_geometry(x),"sfc_POINT"))
  ret <- sf::st_coordinates(x)
  ret <- tibble::as_tibble(ret)
  stopifnot(length(names) == ncol(ret))
  x <- x[ , !names(x) %in% names]
  ret <- setNames(ret,names)
  dplyr::bind_cols(x,ret)
}

kettunen <- st_read('data/kettunen.shp') %>% 
  st_transform("+proj=longlat +datum=WGS84") %>% 
  sfc_as_cols()

# This renames the columns and picks up the map number

kettunen <- kettunen %>% mutate(ilmio = as.character(ilmio)) %>%
  rename(feature_id = ilmio_id,
         feature_value = ilmio,
         feature_description = kuvaus,
         location = paikka_nim) %>%
  mutate(map_id = str_extract(alaryhma_n, "(?<=^Kartta )[^:]+(?=:)"))

readr::write_rds(kettunen, "data/kettunen.rds")

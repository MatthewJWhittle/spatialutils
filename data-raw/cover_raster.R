rm(list = ls())

require(tidyverse)
devtools::load_all()

points <- xy_to_points() %>% st_buffer(1000) %>%
  st_bbox() %>% random_points(n_points = 200)

circles <- points %>% st_buffer(20)

raster <- sf_to_raster(sf = circles, resolution = 1)
random_cover_raster <- get_cover(circles, raster)


usethis::use_data(random_cover_raster, overwrite = TRUE)

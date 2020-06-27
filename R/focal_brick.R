focal_brick <-
  function(brick, window, stat_fun = mean) {
    layers <- names(brick)
    
    focal_brick <-
      purrr::map(.x = layers,
                 ~ brick[[.x]] %>% raster::focal(w = window, fun = stat_fun)) %>% raster::brick()
    
    
    return(focal_brick)
  }

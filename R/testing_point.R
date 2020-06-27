testing_point <-
  function(x = 456203,
           y = 503210,
           buffer = NULL) {
    point <-
      tibble(x = x, y = y) %>%
      st_as_sf(coords = c("x", "y"), crs = 27700)
    
    if (is.null(buffer)) {
      return(point)
    } else{
      return(st_buffer(point, buffer))
    }
  }
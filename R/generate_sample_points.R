generate_sample_points <-
  function(bbox, n_points, seed = NULL) {
    if (!is.null(seed)) {
      set.seed(seed)
    }
    
    x <-
      bbox["xmin"] + ((bbox["xmax"] - bbox["xmin"]) * runif(n_points))
    y <-
      bbox["ymin"] + ((bbox["ymax"] - bbox["ymin"]) * runif(n_points))
    
    
    points <-
      tibble(x = x, y = y) %>%
      st_as_sf(coords = c("x", "y"), crs = 27700)
    
    return(points)
  }

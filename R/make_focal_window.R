make_focal_window <-
  function(x, resolution_m) {
    
    resolution <- raster::res(x)
    window_size <- resolution_m
    
    dim_x <- window_size / resolution[1]
    
    padding <- dim_x %% 2 == 0
    
    if (padding) {
      dim_x <- dim_x + 1
    }
    
    ratio <- 1
    dim_y <- dim_x * ratio
    
    # Make a window of equal weights
    window <- matrix(ncol = dim_x,
                     nrow = dim_y,
                     data = 1)
    
    
    # Add padding if neccessary
    if (padding) {
      window[, 1] <- 0
      window[1,] <- 0
      window[, dim_x] <- 0
      window[dim_y,] <- 0
    }
    
    return(window)
    
  }

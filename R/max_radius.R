require(sf)

max_radius <-
  function(x) {
    x <- st_geometry(x)
    centroid <- st_centroid(x)
    
    points <-
      st_cast(x, "POINT")
    
    max_distance <- max(st_distance(centroid, points))
    
    
    return(as.numeric(max_distance))
  }

#' Calculate Max Radius
#'
#' Calculate the maiximum distance from the center of an sf object to its furthest extent
#'
#' @param x an sf object
#' @param numeric a logical value defining whether the output should be converted to a numeric value
#' @export max_sf_radius
#' @import sf
#' @return either a numeric or units class of the maximum distance from the center of x to it's furthest extent
max_sf_radius <-
  function(x, numeric = FALSE) {
    # It would be useful to vectorise this function

    # Assert that the crs is planar
    stopifnot(sf::st_crs(x)$epsg == 27700)

    # Strip out just the geometry to simplify the process
    x <- sf::st_geometry(x)

    # Calculate the centroid
    centroid <- sf::st_centroid(x)

    # cast the geometry as points to calculate the maximum distance
    points <-
      sf::st_cast(x, "POINT")

    # Calculate the distancce between the center and each geometry point
    # Returnthe maximum value
    max_distance <- max(sf::st_distance(centroid, points))

    # Conditionally return either a numeric or the native units of the distance calculation
    if(numeric){
      as.numeric(max_distance)
    }else{
      max_distance
    }
  }

#' Covert xy to points
#'
#' Convert XY coordinates to a points object based upon xy coordinates
#'
#' @param x the x coordinate of the point
#' @param y  the y coordinate of the point
#' @param crs the crs of the point, default is epsg 27700 (BNG)
#' @return an sf object of points
#' @import sf
#' @importFrom magrittr %>%
#' @import dplyr
#' @export xy_to_points

xy_to_points <-
  function(x = 456203,
           y = 503210,
           crs = 27700) {
    # Convert the xy values to a point and set the crs
    points <-
      dplyr::tibble(x = x, y = y) %>%
      sf::st_as_sf(coords = c("x", "y"), crs = crs)

    return(points)
  }

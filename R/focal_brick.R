#' Focal Stat brick
#'
#' Calculate focal stats for each layer in a raster brick
#'
#' @param brick a raster brick object
#' @param window a matrix defining the windo across which to calculate the statistic
#' @param fun the function to use when calculating the statistic (mean by default)
#' @return a raster brick with the same extents as \code{brick}
#' @import raster
#' @import purrr
#' @importFrom magrittr %>%
#' @export focal_brick

focal_brick <-
  function(brick, window, fun = mean) {
    # Get the layer names to rename the output
    layers <- names(brick)
    # Calculate the statistic for each layer using a mapping function and bick back to a brick
    focal_brick <-
      purrr::map(.x = layers,
                 ~ brick[[.x]] %>%
                   raster::focal(w = window, fun = fun)) %>% raster::brick()

    return(focal_brick)
  }

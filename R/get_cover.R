#' Get Cover
#'
#' Get the cover of an sf object based upon an input raster
#'
#' @param x an sf object which must be a polygon/multipolygon
#' @param raster the model raster to define the output extents and resolution
#' @return a raster with a value of 1 for every cell covered by x
#' @export get_cover
#' @import fasterize
#' @import sf
get_cover <- function(x, raster) {
  # Need to add code here to assert that x and raster are the same crs

  # convert x to an sf object
  x_sf <-
    sf::st_as_sf(x)

  # I'm not sure if this is actually neccessary
  # It is intended to ensure fasterise returns a value of 1
  # wherever the raster covers the sf. This may be done by fasterize automatically
  x_sf$value <- TRUE

  # Use fasterize to generate the cover raster with a background of 0
  fasterize::fasterize(
    sf = x_sf,
    raster = raster,
    field = "value",
    fun = "any",
    background = 0
  )
}

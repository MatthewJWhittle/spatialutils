#' SF to Raster
#'
#' Generate an empty raster based upon the extents and projection of an sf object
#'
#' @param sf and sf object
#' @param resolution a numeric defining the resolution of the output raster
#' @return a raster object with the same extents as \code{sf} and the resolution set by \code{resolution}
#' @export sf_to_raster
#' @import sf
#' @import raster
sf_to_raster <- function(sf, resolution) {
  # Extract just the extents of the sf object as an sp object
  # This step makes the call to raster much faster as it only deals with the extents of the sf
  # instead of each feature
  sf_extent <- sf::as_Spatial(sf::st_as_sfc(sf::st_bbox(sf)))
  # Define a raster based upon the extents
  extent_rast <- raster::raster(sf_extent)
  # Set the raster resoltuion
  raster::res(extent_rast) <- resolution
  # Return the object
  return(extent_rast)
}

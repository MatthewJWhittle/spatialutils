

sf_to_raster <- function(x, resolution) {
  x_extent <- as_Spatial(st_as_sfc(st_bbox(x)))
  extent_rast <- raster(x_extent)
  res(extent_rast) <- resolution
  return(extent_rast)
}
get_cover <- function(x, raster) {
  x_sf <-
    st_as_sf(x)
  x_sf$value <- TRUE
  
  fasterize(
    sf = x_sf,
    raster = raster,
    field = "value",
    fun = "any",
    background = 0
  )
}
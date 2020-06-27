#' Calculate grid stats
#' 
#' Use paralell processing to calculate grid stats
#' 
#' @param x an sf object
#' @param grid an sf object produced by st_make_grid
#' @param stat a string specifying which statistic to calculate
#' @return a raster object with the same extent and resolution as \code{grid}
#' @import sf
#' @import raster
#' @import dplyr
#' @importFrom magrittr %>%
#' @import parallel
#' @import fasterize

st_grid_stat_parallel <-
  function(x, grid, stat = "length") {
    n_cores <- parallel::detectCores() - 1
    if (n_cores == 0) {
      n_cores <- 1
    }
    
    # Check that the requested stat matches a suported function
    stat_functions <- c("length" = "st_length", "area" = "st_area")
    stopifnot(exprs = {
      stat %in% names(stat_functions)
    })
    
    # convert to a linestring to calculate the length stat (returns zero otherwise)
    if (stat == "length") {
      x <-
        x %>%  st_cast(to = "MULTILINESTRING") %>% st_cast(to = "LINESTRING")
    }
      x <- st_combine(x)
    
    # Get the stat function using the supplied name
    stat_func <- get(stat_functions[stat  == names(stat_functions)])
    
    empty_grids <-
      st_intersects(grid, x, sparse = T, prepared = F) %>%
      map(~ (length(.x) > 0)) %>% unlist()
    
    empty_grids <- !empty_grids
    
    nonempty_grids <- grid[!empty_grids]
    
    n_squares <- length(nonempty_grids)
    split <-
      seq(from = 0,
          to = n_squares,
          by = round(n_squares / n_cores))
    
    # Ensure the final split ends on the number of squares
    split[length(split)] <- n_squares
    
    ind <- c(1:(length(split) - 1))
    
    work_division <-
      lapply(ind,
             function(i) {
               (split[i] + 1):split[i + 1]
             })
    
    
    x_intersection_split <-
      mclapply(work_division,
               function(division) {
                 st_intersection(nonempty_grids[division], x)
               },
               mc.cores = n_cores)
    
    
    # Combine interesected polygons
    x_intersection <- do.call(c, x_intersection_split)
    
    
    values <- stat_func(x_intersection)
    
    
    
    
    # Get the resolution
    resolution <- sqrt(as.numeric(st_area(grid[1])))
    
    
    grid_rast <-
      raster::raster(as_Spatial(st_as_sfc(st_bbox(grid))))
    res(grid_rast) <- resolution
    
    grid <- st_as_sf(grid)
    
    value_vector <- numeric(nrow(grid))
    
    value_vector[!empty_grids] <- values
    grid$value <- value_vector
    
    
    
    
    value_raster <-
      fasterize::fasterize(grid, grid_rast, background = 0, field = "value")
    
    return(value_raster)
  }
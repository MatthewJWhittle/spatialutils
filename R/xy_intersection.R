#' Get values from intersecting objects
#'
#' Extract values from intersecting sf objects
#'
#' @param x an sf object
#' @param y an sf object
#' @param x_id a column in x that uniquely identfies features
#' @param y_id a column in y that uniquely identfies features
#' @import sf
#' @import purrr
#' @import dplyr
#' @importFrom magrittr %>%
#' @return a tibble with nrows equal to nrows(x) containing the intersecting values
#' @export xy_intersection
xy_intersection <-
  function(x, y, x_id, y_id) {

    # Get the intersects
    intersects <-
      sf::st_intersects(x, y)

    # Create a logical vector where the intersect is empty
    # This ensures that the operation that retreives the values doesn't encounter empty indexes
    empty_x <- purrr::map(intersects,
                   ~ length(.x) == 0) %>% unlist()

    # Simplify x and y to tables
    x_table <- sf::st_drop_geometry(x)
    y_table <- sf::st_drop_geometry(y)

    # Map over the intersect and x to return all pairs of ids that intersect
    x_y <-
      purrr::map2(.x = intersects[!empty_x],
           .y = x_table[!empty_x, x_id],
           ~ tibble(y = y_table[.x, y_id], x = .y)) %>%
      dplyr::bind_rows()

    # Rename the columns to match the input variable
    colnames(x_y) <- c(y_id, x_id)
    # Perform a final step to ensure that all values of x_id are present in the output
    dplyr::left_join(x_table[x_id], x_y, by = x_id)
  }

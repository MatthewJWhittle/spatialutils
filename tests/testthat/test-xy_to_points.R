test_that("creates points", {
  expect_equal(class(xy_to_points()),
               c("sf", "tbl_df", "tbl", "data.frame"))
  expect_equal(sf::st_is(xy_to_points(), "POINT"), TRUE)

})


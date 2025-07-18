library(testthat)

test_that("link class methods behave as expected", {
  # Create a link object
  link_obj <- link$new(
    from_data_frame = "df1",
    to_data_frame = "df2",
    type = "keyed",
    link_columns = list(
      c(colA = "colX"),
      c(colB = "colY")
    )
  )
  
  # Test initial values
  expect_equal(link_obj$from_data_frame, "df1")
  expect_equal(link_obj$to_data_frame, "df2")
  expect_equal(link_obj$type, "keyed")
  expect_equal(link_obj$link_columns[[1]], c(colA = "colX"))
  
  # Test cloning
  cloned <- link_obj$data_clone()
  expect_equal(cloned$from_data_frame, "df1")
  expect_equal(cloned$link_columns[[2]], c(colB = "colY"))
  
  # Test renaming data frames
  link_obj$rename_data_frame_in_link("df1", "data_frame_1")
  expect_equal(link_obj$from_data_frame, "data_frame_1")
  
  link_obj$rename_data_frame_in_link("df2", "data_frame_2")
  expect_equal(link_obj$to_data_frame, "data_frame_2")
  
  # Test renaming columns in from_data_frame
  link_obj$rename_column_in_link("data_frame_1", "colA", "newA")
  expect_equal(names(link_obj$link_columns[[1]]), "newA")
  
  # Test renaming columns in to_data_frame
  link_obj$rename_column_in_link("data_frame_2", "colY", "newY")
  expect_equal(link_obj$link_columns[[2]], c(colB = "newY"))
})
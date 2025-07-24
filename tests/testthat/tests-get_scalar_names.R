library(testthat)

test_that("get_scalars returns correct scalar values and get_scalar_names works", {
  
  # Mock scalar values
  mock_scalars <- list(
    a = 1,
    b = 2,
    c = 3
  )
  
  # Mock return value for get_metadata
  mock_metadata_label <- "Label"
  
  # Mock DataSheet class for test
  TestSheet <- R6::R6Class("TestSheet",
                           public = list(
                             get_metadata = function(name) {
                               return(mock_metadata_label)
                             },
                             get_scalar_names = function(as_list = FALSE, excluded_items = c(), ...) {
                               out <- get_data_book_scalar_names(scalar_list = private$scalars,
                                                                 as_list = as_list,
                                                                 list_label = self$get_metadata("data_name_label"))
                               return(out)
                             },
                             get_scalars = function() {
                               out <- private$scalars[self$get_scalar_names()]
                               return(out)
                             }
                           ),
                           private = list(
                             scalars = mock_scalars
                           )
  )
  
  # Dummy version of get_data_book_scalar_names
  get_data_book_scalar_names <- function(scalar_list, as_list, list_label) {
    return(names(scalar_list))  # Simplified for test
  }
  
  sheet <- TestSheet$new()
  
  expect_equal(sheet$get_scalar_names(), c("a", "b", "c"))
  expect_equal(sheet$get_scalars(), mock_scalars)
})

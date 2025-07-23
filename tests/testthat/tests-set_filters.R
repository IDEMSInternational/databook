test_that("set_filters sets filters and handles 'no_filter' correctly", {
  # Mock Set_property constant
  Set_property <- "Set_property"
  
  # Create a mock DataSheet class
  MockSheet <- R6::R6Class("MockSheet",
                           private = list(
                             filters = NULL
                           ),
                           public = list(
                             change_log = list(),
                             added_filters = list(),
                             
                             # Mock append_to_changes
                             append_to_changes = function(entry) {
                               self$change_log[[length(self$change_log) + 1]] <- entry
                             },
                             
                             # Mock add_filter
                             add_filter = function(filter, filter_name, replace, set_as_current, na.rm, is_no_filter) {
                               self$added_filters[[filter_name]] <- list(
                                 filter = filter,
                                 replace = replace,
                                 set_as_current = set_as_current,
                                 na.rm = na.rm,
                                 is_no_filter = is_no_filter
                               )
                             },
                             
                             # Method to test
                             set_filters = function(new_filters) {
                               if (!is.list(new_filters)) stop("Filters must be of type: list")
                               self$append_to_changes(list(Set_property, "filters"))  
                               private$filters <- new_filters
                               if (!"no_filter" %in% names(private$filters)) {
                                 self$add_filter(filter = list(), filter_name = "no_filter", replace = TRUE, set_as_current = TRUE, na.rm = FALSE, is_no_filter = TRUE)
                               }
                             },
                             
                             get_filters = function() private$filters
                           )
  )
  
  # Create instance and test
  sheet <- MockSheet$new()
  test_filters <- list(type = "numeric")
  
  # Run method
  sheet$set_filters(test_filters)
  
  # Check that filters were set
  expect_equal(sheet$get_filters(), test_filters)
  
  # Check that append_to_changes was called correctly
  expect_equal(length(sheet$change_log), 1)
  expect_equal(sheet$change_log[[1]], list("Set_property", "filters"))
  
  # Check that no_filter was added
  expect_true("no_filter" %in% names(sheet$added_filters))
  expect_equal(sheet$added_filters$no_filter$is_no_filter, TRUE)
})

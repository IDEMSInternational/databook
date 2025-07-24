test_that("set_changes sets changes list and appends log", {
  # Mock constant if not available
  Set_property <- "Set_property"
  
  # Create a mock class to test
  MockSheet <- R6::R6Class("MockSheet",
                           private = list(
                             changes = NULL
                           ),
                           public = list(
                             change_log = list(),
                             
                             append_to_changes = function(entry) {
                               self$change_log[[length(self$change_log) + 1]] <- entry
                             },
                             
                             set_changes = function(new_changes) {
                               if (!is.list(new_changes)) stop("Changes must be of type: list")
                               private$changes <- new_changes
                               self$append_to_changes(list(Set_property, "changes"))
                             },
                             
                             get_changes = function() private$changes  # Helper to check result
                           )
  )
  
  # Instantiate and test
  sheet <- MockSheet$new()
  new_data <- list(a = 1, b = 2)
  
  sheet$set_changes(new_data)
  
  # Expectations
  expect_equal(sheet$get_changes(), new_data)
  expect_equal(length(sheet$change_log), 1)
  expect_equal(sheet$change_log[[1]], list("Set_property", "changes"))
})

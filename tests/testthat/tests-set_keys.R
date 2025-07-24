test_that("set_keys correctly sets keys and logs the change", {
  # Define mock Set_property constant
  Set_property <- "Set_property"
  
  # Define a minimal mock DataSheet class
  MockSheet <- R6::R6Class("MockSheet",
                           public = list(
                             change_log = list(),
                             
                             append_to_changes = function(change) {
                               self$change_log[[length(self$change_log) + 1]] <- change
                             },
                             
                             set_keys = function(new_keys) {
                               if (!is.list(new_keys)) stop("new_keys must be of type: list")
                               self$append_to_changes(list(Set_property, "keys"))  
                               private$keys <- new_keys
                             }
                           ),
                           private = list(
                             keys = NULL
                           ),
                           active = list(
                             # Expose keys for testing purposes
                             get_keys = function() private$keys
                           )
  )
  
  # Create a mock instance
  sheet <- MockSheet$new()
  
  # Define test input
  keys_input <- list(id = "ID001", category = "TypeA")
  
  # Call the method
  sheet$set_keys(keys_input)
  
  # Check that keys were correctly stored
  expect_equal(sheet$get_keys, keys_input)
  
  # Check change log updated
  expect_equal(length(sheet$change_log), 1)
  expect_equal(sheet$change_log[[1]], list("Set_property", "keys"))
})


test_that("set_keys throws error for non-list input", {
  Set_property <- "Set_property"
  
  # Minimal sheet to test error
  sheet <- R6::R6Class("MockSheet",
                       public = list(
                         append_to_changes = function(change) {},  # stub
                         set_keys = function(new_keys) {
                           if (!is.list(new_keys)) stop("new_keys must be of type: list")
                           self$append_to_changes(list(Set_property, "keys"))  
                           private$keys <- new_keys
                         }
                       ),
                       private = list(keys = NULL)
  )$new()
  
  # Call with invalid input
  expect_error(sheet$set_keys("not_a_list"), "new_keys must be of type: list")
})

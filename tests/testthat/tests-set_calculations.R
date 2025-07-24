test_that("set_calculations correctly sets calculations and tracks changes", {
  # Mock constant
  Set_property <- "Set_property"
  
  # Create a mock DataSheet class
  MockSheet <- R6::R6Class("MockSheet",
                           public = list(
                             change_log = list(),
                             
                             append_to_changes = function(change) {
                               self$change_log[[length(self$change_log) + 1]] <- change
                             },
                             
                             set_calculations = function(new_calculations) {
                               if (!is.list(new_calculations)) stop("new_calculations must be of type: list")
                               self$append_to_changes(list(Set_property, "calculations"))  
                               private$calculations <- new_calculations
                             }
                           ),
                           private = list(
                             calculations = NULL
                           ),
                           active = list(
                             # For testing: expose private$calculations safely
                             get_calculations = function() private$calculations
                           )
  )
  
  # Create instance
  sheet <- MockSheet$new()
  
  # Define test input
  calc_input <- list(mean = "mean(x)", sum = "sum(x)")
  
  # Run method
  sheet$set_calculations(calc_input)
  
  # Check that private$calculations is set correctly
  expect_equal(sheet$get_calculations, calc_input)
  
  # Check that change log is updated
  expect_equal(length(sheet$change_log), 1)
  expect_equal(sheet$change_log[[1]], list("Set_property", "calculations"))
})


test_that("set_calculations throws error for non-list input", {
  Set_property <- "Set_property"
  sheet <- R6::R6Class("MockSheet",
                       public = list(
                         append_to_changes = function(change) {},
                         set_calculations = function(new_calculations) {
                           if (!is.list(new_calculations)) stop("new_calculations must be of type: list")
                           self$append_to_changes(list(Set_property, "calculations"))  
                           private$calculations <- new_calculations
                         }
                       ),
                       private = list(calculations = NULL)
  )$new()
  
  expect_error(sheet$set_calculations("not_a_list"), "new_calculations must be of type: list")
})

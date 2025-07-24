test_that("set_data_changed correctly updates data_changed", {
  # Define a minimal mock class to test
  MockSheet <- R6::R6Class("MockSheet",
                           public = list(
                             data_changed = NULL,
                             set_data_changed = function(new_val) {
                               self$data_changed <- new_val
                             }
                           )
  )
  
  # Create instance
  sheet <- MockSheet$new()
  
  # Test setting TRUE
  sheet$set_data_changed(TRUE)
  expect_true(sheet$data_changed)
  
  # Test setting FALSE
  sheet$set_data_changed(FALSE)
  expect_false(sheet$data_changed)
})

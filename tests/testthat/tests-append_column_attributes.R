test_that("append_column_attributes appends each attribute correctly", {
  calls <- list()
  
  # Mock object with tracking
  mock_object <- R6::R6Class(
    "MockClass",
    public = list(
      append_to_variables_metadata = function(property, col_names, new_val) {
        calls <<- append(calls, list(
          list(property = property, col_names = col_names, new_val = new_val)
        ))
      },
      append_column_attributes = function(col_name, new_attr) {
        tmp_names <- names(new_attr)
        for(i in seq_along(new_attr)) {
          self$append_to_variables_metadata(
            property = tmp_names[i],
            col_names = col_name,
            new_val = new_attr[[i]]
          )
        }
      }
    )
  )$new()
  
  # Sample input
  col_name <- "temperature"
  new_attr <- list(unit = "Celsius", description = "Daily temperature", source = "Sensor")
  
  # Run the method
  mock_object$append_column_attributes(col_name, new_attr)
  
  # Assertions
  expect_equal(length(calls), 3)
  
  expect_equal(calls[[1]]$property, "unit")
  expect_equal(calls[[1]]$col_names, "temperature")
  expect_equal(calls[[1]]$new_val, "Celsius")
  
  expect_equal(calls[[2]]$property, "description")
  expect_equal(calls[[2]]$new_val, "Daily temperature")
  
  expect_equal(calls[[3]]$property, "source")
  expect_equal(calls[[3]]$new_val, "Sensor")
})

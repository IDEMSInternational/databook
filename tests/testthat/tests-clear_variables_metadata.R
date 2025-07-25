test_that("clear_variables_metadata clears metadata and calls add_defaults_variables_metadata", {
  
  # Constants (these should match your actual values)
  data_type_label <- "data_type"
  data_name_label <- "data_name"
  
  # Simulated data frame with attributes
  col1 <- 1:5
  attributes(col1) <- list(
    data_type = "numeric",
    unit = "mm",
    source = "NOAA"
  )
  col2 <- 6:10
  attributes(col2) <- list(
    data_name = "temperature",
    method = "manual"
  )
  df <- data.frame(a = col1, b = col2)
  
  # Create a mock R6-like object
  obj <- new.env()
  
  # Add get_data_frame method
  obj$get_data_frame <- function(use_current_filter = FALSE) df
  
  # Add get_column_names method
  obj$get_column_names <- function() names(df)
  
  # Create a tracker for add_defaults_variables_metadata
  obj$add_defaults_variables_metadata <- function(columns) {
    assign("was_called", TRUE, envir = .GlobalEnv)
    assign("called_with", columns, envir = .GlobalEnv)
  }
  
  # Define the clear_variables_metadata method
  obj$clear_variables_metadata <- function() {
    for(column in obj$get_data_frame(FALSE)) {
      for(name in names(attributes(column))) {
        if(!name %in% c(data_type_label, data_name_label)) attr(obj, name) <- NULL
      }
    }
    obj$add_defaults_variables_metadata(obj$get_column_names())
  }
  
  # Run the function
  obj$clear_variables_metadata()
  
  # Check results
  expect_true(exists("was_called"))
  expect_true(was_called)
  expect_equal(called_with, c("a", "b"))
})

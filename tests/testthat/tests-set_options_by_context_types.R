test_that("set_options_by_context_types sets metadata for valid types and other columns", {
  # Set up global variables assumed used by the method
  obyc_all_types <- c("location", "season", "farmer")
  obyc_type_label <- "obyc_type"
  
  # Capture the metadata update calls
  calls <- list()
  
  mock_object <- R6::R6Class(
    "MockClass",
    public = list(
      append_to_variables_metadata = function(col_names, property, new_val) {
        calls <<- append(calls, list(
          list(col_names = col_names, property = property, new_val = new_val)
        ))
      },
      get_column_names = function() {
        return(c("col1", "col2", "col3", "col4"))
      },
      set_options_by_context_types = function(obyc_types = NULL, key_columns = NULL) {
        if (!all(names(obyc_types) %in% obyc_all_types)) {
          stop("Cannot recognize the following types: ",
               paste(names(obyc_types)[!names(obyc_types) %in% obyc_all_types], collapse = ", "))
        }
        
        invisible(sapply(names(obyc_types), function(name)
          self$append_to_variables_metadata(obyc_types[[name]], obyc_type_label, name)))
        
        other_cols <- dplyr::setdiff(x = self$get_column_names(), y = unlist(obyc_types))
        self$append_to_variables_metadata(other_cols, obyc_type_label, NA)
      }
    )
  )$new()
  
  # Define test input
  obyc_types <- list(
    location = "col1",
    season = c("col2", "col3")
  )
  
  # Run the method
  mock_object$set_options_by_context_types(obyc_types)
  
  # Check that metadata was appended for valid types
  expect_equal(length(calls), 3)
  
  # Call 1: location -> col1
  expect_equal(calls[[1]]$col_names, "col1")
  expect_equal(calls[[1]]$property, obyc_type_label)
  expect_equal(calls[[1]]$new_val, "location")
  
  # Call 2: season -> col2, col3
  expect_equal(calls[[2]]$col_names, c("col2", "col3"))
  expect_equal(calls[[2]]$new_val, "season")
  
  # Call 3: other column -> col4, NA type
  expect_equal(calls[[3]]$col_names, "col4")
  expect_equal(calls[[3]]$new_val, NA)
})

test_that("set_options_by_context_types throws error on invalid type", {
  obyc_all_types <- c("location", "season", "farmer")
  obyc_type_label <- "obyc_type"
  
  mock_object <- R6::R6Class(
    "MockClass",
    public = list(
      append_to_variables_metadata = function(...) {},
      get_column_names = function() {
        return(c("col1", "col2"))
      },
      set_options_by_context_types = function(obyc_types = NULL, key_columns = NULL) {
        if (!all(names(obyc_types) %in% obyc_all_types)) {
          stop("Cannot recognize the following types: ",
               paste(names(obyc_types)[!names(obyc_types) %in% obyc_all_types], collapse = ", "))
        }
      }
    )
  )$new()
  
  # Invalid type name "invalid_type"
  invalid_input <- list(invalid_type = "col1")
  
  expect_error(
    mock_object$set_options_by_context_types(invalid_input),
    "Cannot recognize the following types: invalid_type"
  )
})

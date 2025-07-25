test_that("get_variables_metadata_fields works as expected", {
  # Create a mock object with inline method
  mock_obj <- R6::R6Class("MockDataSheet", public = list(
    
    get_variables_metadata = function() {
      list(field1 = "a", field2 = "b", field3 = "c")
    },
    
    get_metadata = function(label) {
      return("mock_data")
    },
    
    get_variables_metadata_fields = function(as_list = FALSE, include = c(), exclude = c(), excluded_items = c()) {
      out = names(self$get_variables_metadata())
      if (length(excluded_items) > 0) {
        ex_ind = which(out %in% excluded_items)
        if (length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of objects")
        if (length(ex_ind) > 0) out = out[-ex_ind]
      }
      if (as_list) {
        lst = list()
        lst[[self$get_metadata("data_name_label")]] <- out
        return(lst)
      } else {
        return(out)
      }
    }
  ))$new()
  
  # Test basic case
  expect_equal(
    mock_obj$get_variables_metadata_fields(),
    c("field1", "field2", "field3")
  )
  
  # Test with excluded_items
  expect_equal(
    mock_obj$get_variables_metadata_fields(excluded_items = "field2"),
    c("field1", "field3")
  )
  
  # Test with multiple excluded_items (one invalid)
  expect_warning(
    result <- mock_obj$get_variables_metadata_fields(excluded_items = c("field2", "not_here")),
    "Some of the excluded_items were not found"
  )
  expect_equal(result, c("field1", "field3"))
  
  # Test as_list = TRUE
  expect_equal(
    mock_obj$get_variables_metadata_fields(as_list = TRUE),
    list(mock_data = c("field1", "field2", "field3"))
  )
  
  # Confirm output types
  expect_type(mock_obj$get_variables_metadata_fields(), "character")
  expect_type(mock_obj$get_variables_metadata_fields(as_list = TRUE), "list")
})

test_that("get_variables_metadata_names returns unique metadata names for specified columns", {
  mock_object <- R6::R6Class(
    "MockClass",
    public = list(
      get_columns_from_data = function(columns, force_as_data_frame = TRUE) {
        # Simulate a data frame with two columns having different attributes
        return(list(
          temp = structure(1:3, attr1 = "x", attr2 = "y"),
          humidity = structure(4:6, attr2 = "y", attr3 = "z")
        )[columns])
      },
      get_variables_metadata_names = function(columns) {
        if (missing(columns)) columns <- self$get_column_names()
        cols <- self$get_columns_from_data(columns, force_as_data_frame = TRUE)
        return(unique(as.character(unlist(sapply(cols, function(x) names(attributes(x)))))))
      },
      get_column_names = function() {
        return(c("temp", "humidity"))
      }
    )
  )$new()
  
  # Test with specified columns
  result <- mock_object$get_variables_metadata_names(c("temp", "humidity"))
  expect_equal(sort(result), sort(c("attr1", "attr2", "attr3")))
  
  # Test with missing columns (i.e., all columns)
  result_all <- mock_object$get_variables_metadata_names()
  expect_equal(sort(result_all), sort(c("attr1", "attr2", "attr3")))
})

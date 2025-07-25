test_that("get_filter_column_names returns correct column names from a filter", {
  # Mock object replicating the needed structure
  MockSheet <- R6::R6Class(
    "MockSheet",
    public = list(
      get_filter = function(filter_name) {
        expect_equal(filter_name, "test_filter")  # Check correct filter passed
        return(list(
          filter_conditions = list(
            list(column = "age"),
            list(column = "gender")
          )
        ))
      },
      get_filter_column_names = function(filter_name) {
        filter <- self$get_filter(filter_name)
        return(sapply(filter$filter_conditions, function(x) x$column))
      }
    )
  )
  
  # Create instance
  sheet <- MockSheet$new()
  
  # Run the method and test output
  result <- sheet$get_filter_column_names("test_filter")
  expect_equal(result, c("age", "gender"))
})

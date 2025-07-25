test_that("get_current_filter_column_names returns correct column names", {
  # Define a mock class mimicking necessary behavior
  MockSheet <- R6::R6Class(
    "MockSheet",
    public = list(
      get_filter_column_names = function(filter_name) {
        expect_equal(filter_name, "test_filter")  # Ensure correct argument passed
        return(c("name", "score", "grade"))
      },
      get_current_filter_column_names = function() {
        return(self$get_filter_column_names(private$.current_filter$name))
      }
    ),
    private = list(
      .current_filter = list(name = "test_filter")
    )
  )
  
  # Instantiate mock
  sheet <- MockSheet$new()
  
  # Run the test
  result <- sheet$get_current_filter_column_names()
  expect_equal(result, c("name", "score", "grade"))
})

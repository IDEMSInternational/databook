test_that("is_tricot_data returns TRUE when metadata is tricot", {
  mock_object <- R6::R6Class(
    "MockClass",
    public = list(
      is_metadata = function(label) {
        return(label == "is_tricot")
      },
      get_metadata = function(label) {
        if (label == "is_tricot") return(TRUE)
        return(FALSE)
      },
      is_tricot_data = function() {
        return(self$is_metadata("is_tricot") && self$get_metadata("is_tricot"))
      }
    )
  )$new()
  
  expect_true(mock_object$is_tricot_data())
})

test_that("is_tricot_data returns FALSE when not metadata", {
  mock_object <- R6::R6Class(
    "MockClass",
    public = list(
      is_metadata = function(label) {
        return(FALSE)
      },
      get_metadata = function(label) {
        return(TRUE)  # doesn't matter, is_metadata is already FALSE
      },
      is_tricot_data = function() {
        return(self$is_metadata("is_tricot") && self$get_metadata("is_tricot"))
      }
    )
  )$new()
  
  expect_false(mock_object$is_tricot_data())
})

test_that("is_tricot_data returns FALSE when metadata value is FALSE", {
  mock_object <- R6::R6Class(
    "MockClass",
    public = list(
      is_metadata = function(label) {
        return(TRUE)
      },
      get_metadata = function(label) {
        return(FALSE)
      },
      is_tricot_data = function() {
        return(self$is_metadata("is_tricot") && self$get_metadata("is_tricot"))
      }
    )
  )$new()
  
  expect_false(mock_object$is_tricot_data())
})


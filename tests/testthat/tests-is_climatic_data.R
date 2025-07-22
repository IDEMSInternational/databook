# Assume label used in metadata
is_climatic_label <- "is_climatic"

# Create a minimal mock object that includes is_climatic_data and mocks metadata methods
MockData <- R6::R6Class("MockData",
  public = list(
    metadata = list(),

    is_metadata = function(label) {
      return(!is.null(self$metadata[[label]]))
    },

    get_metadata = function(label) {
      return(self$metadata[[label]])
    },

    is_climatic_data = function() {
      return(self$is_metadata(is_climatic_label) &&
             self$get_metadata(is_climatic_label))
    }
  )
)

# Unit tests
test_that("is_climatic_data returns TRUE when metadata exists and is TRUE", {
  obj <- MockData$new()
  obj$metadata[[is_climatic_label]] <- TRUE
  expect_true(obj$is_climatic_data())
})

test_that("is_climatic_data returns FALSE when metadata exists but is FALSE", {
  obj <- MockData$new()
  obj$metadata[[is_climatic_label]] <- FALSE
  expect_false(obj$is_climatic_data())
})

test_that("is_climatic_data returns FALSE when metadata is missing", {
  obj <- MockData$new()
  expect_false(obj$is_climatic_data())
})

# Define symbolic constants
Added_metadata <- "Added_metadata"
is_hidden_label <- "is_hidden"

# Minimal class definition
DataSheet <- R6::R6Class("DataSheet",
                     private = list(
                       data = data.frame(a = 1:3),
                       changes = list()
                     ),
                     public = list(
                       metadata_changed = FALSE,
                       data_changed = FALSE,
                       
                       append_to_changes = function(change) {
                         private$changes <- append(private$changes, list(change))
                       },
                       
                       get_changes = function() {
                         private$changes
                       },
                       
                       append_to_metadata = function(property, new_value = "") {
                         if (missing(property)) stop("property must be specified.")
                         if (!is.character(property)) stop("property must be of type: character")
                         
                         attr(private$data, property) <- new_value
                         self$append_to_changes(list(Added_metadata, property, new_value))
                         self$metadata_changed <- TRUE
                         if (property == is_hidden_label) self$data_changed <- TRUE
                       },
                       
                       get_data = function() {
                         private$data
                       }
                     )
)

# Unit test
test_that("append_to_metadata adds metadata correctly", {
  ds <- DataSheet$new()
  
  ds$append_to_metadata("source", "MOH Kenya")
  
  expect_equal(attr(ds$get_data(), "source"), "MOH Kenya")
  
  expected_change <- list(Added_metadata, "source", "MOH Kenya")
  expect_equal(ds$get_changes()[[1]], expected_change)
  
  expect_true(ds$metadata_changed)
})

test_that("append_to_metadata sets data_changed if is_hidden_label is used", {
  ds <- DataSheet$new()
  
  ds$append_to_metadata("is_hidden", TRUE)
  
  expect_equal(attr(ds$get_data(), "is_hidden"), TRUE)
  expect_true(ds$data_changed)
})

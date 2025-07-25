# Constants
data_type_label <- "data_type"
data_name_label <- "data_name"
Set_property <- "Set_property"

# Sample R6 class with clear_metadata
DataSheet <- R6::R6Class("DataSheet",
                     private = list(
                       data = structure(
                         data.frame(x = 1:5),
                         source = "Survey Data",
                         note = "Important",
                         data_type = "numeric",
                         data_name = "SampleData"
                       ),
                       changes = list()
                     ),
                     public = list(
                       metadata_changed = FALSE,
                       
                       append_to_changes = function(change) {
                         private$changes <- append(private$changes, list(change))
                       },
                       
                       get_changes = function() {
                         private$changes
                       },
                       
                       get_data = function() {
                         private$data
                       },
                       
                       add_defaults_meta = function() {
                         attr(private$data, data_type_label) <- "default_type"
                         attr(private$data, data_name_label) <- "default_name"
                       },
                       
                       clear_metadata = function() {
                         for (name in names(attributes(private$data))) {
                           if (!name %in% c(data_type_label, data_name_label, "row.names", "names")) {
                             attr(private$data, name) <- NULL
                           }
                         }
                         self$add_defaults_meta()
                         self$metadata_changed <- TRUE
                         self$append_to_changes(list(Set_property, "meta data"))
                       }
                     )
)

# Unit test
test_that("clear_metadata removes custom metadata but retains defaults", {
  ds <- DataSheet$new()
  
  # Before clearing, should have custom attributes
  attrs_before <- attributes(ds$get_data())
  expect_true("source" %in% names(attrs_before))
  expect_true("note" %in% names(attrs_before))
  
  ds$clear_metadata()
  
  attrs_after <- attributes(ds$get_data())
  
  # Ensure custom attributes are removed
  expect_false("source" %in% names(attrs_after))
  expect_false("note" %in% names(attrs_after))
  
  # Ensure default attributes exist (re-added)
  expect_equal(attr(ds$get_data(), "data_type"), "default_type")
  expect_equal(attr(ds$get_data(), "data_name"), "default_name")
  
  # Check metadata changed flag
  expect_true(ds$metadata_changed)
  
  # Check changes log
  expect_equal(ds$get_changes()[[1]], list(Set_property, "meta data"))
})

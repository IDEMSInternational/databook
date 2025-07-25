# Define a minimal DataSheet class with necessary structure if it's not sourced
DataSheet <- R6::R6Class("DataSheet",
                         private = list(
                           data = NULL
                         ),
                         public = list(
                           metadata_changed = FALSE,
                           
                           initialize = function(df) {
                             private$data <- df
                           },
                           
                           get_data_frame = function(use_current_filter = FALSE) {
                             return(private$data)
                           },
                           
                           get_column_names = function() {
                             return(names(private$data))
                           },
                           
                           add_defaults_variables_metadata = function(columns) {
                             # You can leave this empty or mock it for the test
                           },
                           
                           clear_variables_metadata = function() {
                             for (column_name in names(private$data)) {
                               column <- private$data[[column_name]]
                               for (name in names(attributes(column))) {
                                 if (!name %in% c("data_type_label", "data_name_label")) {
                                   attr(private$data[[column_name]], name) <- NULL
                                 }
                               }
                             }
                             self$add_defaults_variables_metadata(self$get_column_names())
                           }
                         )
)

# Unit test
test_that("clear_variables_metadata removes unwanted attributes and keeps defaults", {
  df <- data.frame(x = 1:5, y = 6:10)
  attr(df$x, "extra_attr") <- "to_remove"
  attr(df$y, "data_type_label") <- "keep"
  
  ds <- DataSheet$new(df)
  ds$clear_variables_metadata()
  
  expect_null(attr(ds$get_data_frame()[["x"]], "extra_attr"))
  expect_equal(attr(ds$get_data_frame()[["y"]], "data_type_label"), "keep")
})

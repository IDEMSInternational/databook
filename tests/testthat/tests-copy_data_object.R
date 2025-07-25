library(testthat)
library(R6)

# --- Minimal dummy classes ---

DummyData <- R6Class("DummyData",
                     public = list(
                       data = NULL,
                       filters = list(),
                       column_selections = list(),
                       
                       initialize = function(data) {
                         self$data <- data
                       },
                       
                       data_clone = function() {
                         DummyData$new(self$data)
                       },
                       
                       add_filter = function(name, fn) {
                         self$filters[[name]] <- fn
                       },
                       
                       add_column_selection = function(name, fn) {
                         self$column_selections[[name]] <- fn
                       },
                       
                       get_data_frame = function(use_current_filter = FALSE, filter_name = "", column_selection_name = "",
                                                 use_column_selection = FALSE, retain_attr = FALSE) {
                         df <- self$data
                         if (filter_name != "") {
                           df <- self$filters[[filter_name]](df)
                         }
                         if (column_selection_name != "") {
                           df <- self$column_selections[[column_selection_name]](df)
                         }
                         df
                       },
                       
                       remove_current_filter = function() {},
                       remove_current_column_selection = function() {},
                       set_data = function(df) {
                         self$data <- df
                       }
                     )
)

DummyObject <- R6Class("DummyObject",
                       public = list(
                         objects = list(),
                         
                         initialize = function(objects = list()) {
                           self$objects <- objects
                         },
                         
                         get_data_objects = function(name) {
                           self$objects[[name]]
                         },
                         
                         append_data_object = function(name, obj) {
                           self$objects[[name]] <- obj
                         },
                         
                         copy_data_object = function(data_name, new_name, filter_name = "", column_selection_name = "", reset_row_names = TRUE) {
                           new_obj <- self$get_data_objects(data_name)$data_clone()
                           if (filter_name != "") {
                             subset_data <- self$get_data_objects(data_name)$get_data_frame(use_current_filter = FALSE, filter_name = filter_name, retain_attr = TRUE)
                             if (reset_row_names) rownames(subset_data) <- 1:nrow(subset_data)
                             new_obj$remove_current_filter()
                             new_obj$set_data(subset_data)
                           }
                           if (column_selection_name != "") {
                             subset_data <- self$get_data_objects(data_name)$get_data_frame(
                               use_current_filter = FALSE,
                               filter_name = filter_name,
                               column_selection_name = column_selection_name,
                               use_column_selection = FALSE,
                               retain_attr = TRUE
                             )
                             new_obj$remove_current_column_selection()
                             new_obj$set_data(subset_data)
                           }
                           self$append_data_object(new_name, new_obj)
                         }
                       )
)

# --- Tests ---

test_that("copies without filter or column selection", {
  df <- data.frame(a = 1:3, b = 4:6)
  obj <- DummyObject$new(objects = list(original = DummyData$new(df)))
  obj$copy_data_object("original", "copy")
  
  expect_equal(obj$objects$copy$data, df)
})

test_that("applies filter", {
  df <- data.frame(x = 1:5, y = letters[1:5])
  obj <- DummyObject$new(objects = list(original = DummyData$new(df)))
  
  obj$objects$original$add_filter("filter1", function(d) d[d$x > 2, , drop = FALSE])
  obj$copy_data_object("original", "copy2", filter_name = "filter1")
  
  expected_df <- df[df$x > 2, , drop = FALSE]
  rownames(expected_df) <- 1:nrow(expected_df)
  
  expect_equal(obj$objects$copy2$data, expected_df)
})

test_that("applies column selection", {
  df <- data.frame(x = 1:5, y = letters[1:5])
  obj <- DummyObject$new(objects = list(original = DummyData$new(df)))
  
  obj$objects$original$add_column_selection("select1", function(d) d["y"])
  obj$copy_data_object("original", "copy3", column_selection_name = "select1")
  
  expected_df <- df["y"]
  expect_equal(obj$objects$copy3$data, expected_df)
})

test_that("applies both filter and column selection", {
  df <- data.frame(x = 1:5, y = letters[1:5])
  obj <- DummyObject$new(objects = list(original = DummyData$new(df)))
  
  obj$objects$original$add_filter("filter1", function(d) d[d$x > 2, , drop = FALSE])
  obj$objects$original$add_column_selection("select1", function(d) d["y", drop = FALSE])
  
  obj$copy_data_object("original", "copy4", filter_name = "filter1", column_selection_name = "select1")
  
  actual <- obj$objects$copy4$data
  expected_df <- df[df$x > 2, "y", drop = FALSE]
  
  # Make rownames integer to match actual
  rownames(expected_df) <- 3:5
  
  expect_equal(actual, expected_df)
})

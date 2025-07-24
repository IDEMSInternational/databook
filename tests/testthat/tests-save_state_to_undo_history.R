test_that("replace_values_with_NA replaces specified values with NA", {
  MockDataSheet <- R6::R6Class("MockDataSheet",
                               private = list(
                                 data = data.frame(
                                   A = 1:5,
                                   B = 6:10,
                                   C = 11:15
                                 )
                               ),
                               public = list(
                                 undo_history_saved = FALSE,
                                 
                                 get_data_frame = function(use_current_filter = FALSE) {
                                   private$data
                                 },
                                 
                                 save_state_to_undo_history = function() {
                                   self$undo_history_saved <- TRUE
                                 },
                                 
                                 set_data = function(new_data) {
                                   private$data <- new_data
                                 },
                                 
                                 get_data = function() private$data,
                                 
                                 replace_values_with_NA = function(row_index, column_index) {
                                   curr_data <- self$get_data_frame(use_current_filter = FALSE)
                                   self$save_state_to_undo_history()
                                   if(!all(row_index %in% seq_len(nrow(curr_data)))) stop("All row indexes must be within the dataframe")
                                   if(!all(column_index %in% seq_len(ncol(curr_data)))) stop("All column indexes must be within the dataframe")
                                   curr_data[row_index, column_index] <- NA
                                   self$set_data(curr_data)
                                 }
                               )
  )
  
  # Create object
  sheet <- MockDataSheet$new()
  
  # Call method to replace specific values
  sheet$replace_values_with_NA(c(1, 3), c(2))
  
  # Get updated data
  updated_data <- sheet$get_data()
  
  # Check values replaced by NA
  expect_true(is.na(updated_data[1, 2]))
  expect_true(is.na(updated_data[3, 2]))
  expect_false(is.na(updated_data[2, 2]))
  
  # Check that undo state was saved
  expect_true(sheet$undo_history_saved)
})

test_that("replace_values_with_NA throws error for invalid indices", {
  sheet <- R6::R6Class("MockDataSheet",
                       private = list(
                         data = data.frame(A = 1:3, B = 4:6)
                       ),
                       public = list(
                         get_data_frame = function(use_current_filter = FALSE) private$data,
                         save_state_to_undo_history = function() {},
                         set_data = function(new_data) private$data <- new_data,
                         replace_values_with_NA = function(row_index, column_index) {
                           curr_data <- self$get_data_frame(use_current_filter = FALSE)
                           self$save_state_to_undo_history()
                           if(!all(row_index %in% seq_len(nrow(curr_data)))) stop("All row indexes must be within the dataframe")
                           if(!all(column_index %in% seq_len(ncol(curr_data)))) stop("All column indexes must be within the dataframe")
                           curr_data[row_index, column_index] <- NA
                           self$set_data(curr_data)
                         }
                       )
  )$new()
  
  # Out-of-bounds row
  expect_error(sheet$replace_values_with_NA(5, 1), "All row indexes must be within the dataframe")
  
  # Out-of-bounds column
  expect_error(sheet$replace_values_with_NA(1, 5), "All column indexes must be within the dataframe")
})

library(testthat)

test_that("comment lifecycle: add, list, dataframe, delete", {
  # Initialising R (e.g Loading R packages)
  data_book <- DataBook$new()
  
  # Importing Data
  df <- data.frame(id = 1:3, val = c(10,20,30), stringsAsFactors = FALSE)
  data_book$import_data(list(x = df))
  
  # Add Cell Comment
  row <- data_book$get_row_names(data_name="x")
  data_book$add_columns_to_data(data_name="x", before=TRUE, col_data=row, col_name="row")
  data_book$add_key(data_name="x", col_names="row")
  data_book$add_new_comment(data_name="x", row="1", column="id", comment="Cell comment")
  
  # Add Row Comment
  data_book$add_new_comment(data_name="x", row="1", comment="Row comment")
  
  # Add Column Comment
  data_book$add_new_comment(data_name="x", column="id", comment="Column comment")
  
  # Add DF Comment
  data_book$add_new_comment(data_name="x", comment="Data frame comment")
  
  comment_data <- data_book$get_data_frame(".comment")
  
  comment_text <- comment_data$comment
  
  expect_true("Cell comment" %in% comment_text[1])
  expect_true("Row comment" %in% comment_text[2])
  expect_true("Column comment" %in% comment_text[3])
  expect_true("Data frame comment" %in% comment_text[4])
})
 
test_that("adding comment without key raises error", {
  # Initialising R (e.g Loading R packages)
  data_book <- DataBook$new()
  
  # Importing Data
  df <- data.frame(id = 1:3, val = c(10,20,30), stringsAsFactors = FALSE)
  data_book$import_data(list(x = df))
  
  # Add Cell Comment
  row <- data_book$get_row_names(data_name="x")
  data_book$add_columns_to_data(data_name="x", before=TRUE, col_data=row, col_name="row")
  expect_error(data_book$add_new_comment(data_name="x", row="1", column="id", comment="Cell comment"),
               "A key must be defined in the data frame to add a comment. Use the Add Key dialog to define a key.")
})
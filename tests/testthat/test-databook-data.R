test_that("rename_dataframe and copy_data_object work as expected", {
  db <- DataBook$new()
  df <- data.frame(a = 1:3, b = letters[1:3], stringsAsFactors = FALSE)
  db$import_data(list(orig = df))
  
  # Rename the dataframe
  db$rename_dataframe(data_name = "orig", new_value = "renamed", label = "My label")
  expect_true("renamed" %in% db$get_data_names())
  expect_false("orig" %in% db$get_data_names())
  
  # Copy the dataframe (copy_data_object)
  db$copy_data_object(data_name = "renamed", new_name = "renamed_copy")
  expect_true("renamed_copy" %in% db$get_data_names())
  expect_equal(nrow(db$get_data_frame("renamed_copy")), nrow(df))
})

# test_that("copy_columns duplicates columns and names them appropriately", {
#   db <- DataBook$new()
#   df <- data.frame(x = 1:4, y = c('a','b','a','b'), stringsAsFactors = FALSE)
#   db$import_data(list(t1 = df))
#   
#   db$copy_columns(data_name = "t1", col_names = c("x"), TRUE)
#   #  new_cols <- db$get_column_names(data_name = "t1")
#   expect_false(any(grepl("x_copy", new_cols)))
#   #  expect_equal(db$get_columns_from_data(data_name = "t1", col_names = c("x_copy"))$x_copy, df$x)
# })
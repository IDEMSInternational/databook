library(testthat)

test_that("drop_unused_factor_levels and factor editing functions behave correctly", {
  db <- DataBook$new()

  # create factor with an unused level
  f <- factor(c("low","high","low"), levels = c("low","mid","high"))
  df <- data.frame(id = 1:3, score = f, stringsAsFactors = FALSE)
  db$import_data(list(fdata = df))

  # Ensure 'mid' is an unused level
  expect_true("mid" %in% levels(db$get_columns_from_data(data_name = "fdata", col_names = "score")))

  # Drop unused levels
  db$drop_unused_factor_levels(data_name = "fdata", col_name = "score")
  expect_false("mid" %in% levels(db$get_columns_from_data(data_name = "fdata", col_names = "score")))

  # Set new factor levels (rename levels)
  db$set_factor_levels(data_name = "fdata", col_name = "score", new_labels = c("LOW","HIGH"))
  expect_true(all(levels(db$get_columns_from_data(data_name = "fdata", col_names = "score")) %in% c("LOW","HIGH")))

  # Edit factor level (rename a value)
  db$edit_factor_level(data_name = "fdata", col_name = "score", old_level = "LOW", new_level = "L")
  expect_true(any(db$get_columns_from_data(data_name = "fdata", col_names = "score") == "L"))

  # Set reference level
  db$set_factor_reference_level(data_name = "fdata", col_name = "score", new_ref_level = "L")
  expect_equal(levels(db$get_columns_from_data(data_name = "fdata", col_names = "score"))[1], "L")
})


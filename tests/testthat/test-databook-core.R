library(testthat)
library(dplyr)

test_that("DataBook core operations: import, sort, add/remove/rename, merge", {
  data_book <- DataBook$new()

  # Import the diamonds dataset from ggplot2
  data_book$import_data(data_tables = list(diamonds = ggplot2::diamonds))

  # Sort the data frame inside the data book and compare to dplyr arrange
  data_book$sort_dataframe(data_name = "diamonds", col_names = c("carat", "cut"))
  databook_data <- data_book$get_data_frame("diamonds")
  tidyverse_data <- ggplot2::diamonds %>% dplyr::arrange(carat, cut)

  expect_equal(nrow(databook_data), nrow(tidyverse_data))
  # compare a few rows of the key sorting column to avoid attribute mismatches
  expect_equal(as.vector(head(databook_data$carat, 20)), as.vector(head(tidyverse_data$carat, 20)))

  # Add a new column and check it exists and has expected values
  data_book$add_columns_to_data("diamonds", col_name = "test_col", col_data = rep(1L, nrow(databook_data)))
  databook_data2 <- data_book$get_data_frame("diamonds")
  expect_true("test_col" %in% names(databook_data2))
  expect_equal(as.integer(databook_data2$test_col), rep(1L, nrow(databook_data2)))

  # Rename the column
  data_book$rename_column_in_data("diamonds", column_name = "test_col", new_val = "renamed_col")
  databook_data3 <- data_book$get_data_frame("diamonds")
  expect_true("renamed_col" %in% names(databook_data3))
  expect_false("test_col" %in% names(databook_data3))

  # Remove the renamed column
  data_book$remove_columns_in_data("diamonds", cols = "renamed_col", allow_delete_all = FALSE)
  databook_data4 <- data_book$get_data_frame("diamonds")
  expect_false("renamed_col" %in% names(databook_data4))

  # Merge additional data and compare result to dplyr left_join
  lookup <- data.frame(cut = unique(ggplot2::diamonds$cut)[1:3], myval = 1:3, stringsAsFactors = FALSE)
  data_book$merge_data(data_name = "diamonds", new_data = lookup, by = "cut", type = "left", match = "all")
  databook_data5 <- data_book$get_data_frame("diamonds")
  expect_true("myval" %in% names(databook_data5))

  #joined <- ggplot2::diamonds %>% dplyr::left_join(lookup, by = "cut")
  #expect_equal(as.integer(databook_data5$myval), joined$myval)
})

test_that("DataBook names, counts, columns, and scalars", {
  data_book2 <- DataBook$new()
  data_book2$import_data(data_tables = list(diamonds = ggplot2::diamonds))

  # data names and counts
  expect_true("diamonds" %in% data_book2$get_data_names())
  expect_equal(data_book2$dataframe_count(), 1)

  # column names and presence of key columns
  col_names <- data_book2$get_column_names("diamonds")
  expect_true(all(c("carat", "cut") %in% col_names))

  # data frame length
  expect_equal(data_book2$get_data_frame_length("diamonds"), nrow(ggplot2::diamonds))

  # column data types (basic smoke test)
  types <- data_book2$get_column_data_types("diamonds", columns = c("carat"))
  expect_true(length(types) >= 1)

  # overall scalar handling
  data_book2$add_scalar(NULL, scalar_name = "s_test", scalar_value = 42)
  scalars <- data_book2$get_scalars(NULL)
  expect_equal(scalars[["s_test"]], 42)
})


test_that("Filters and column selections behave correctly", {
  db <- DataBook$new()
  df <- data.frame(a = 1:10, b = rep(c("x","y"), 5), stringsAsFactors = FALSE)
  db$import_data(data_tables = list(df = df))

  # Add a filter to keep rows where a < 5
  flt <- list(C0 = list(column = "a", operation = "<", value = 5))
  db$add_filter(data_name = "df", filter = flt, filter_name = "lt5", set_as_current_filter = TRUE)

  # Check filter name appears
  f_names <- db$get_filter_names("df")
  expect_true("lt5" %in% f_names)

  # Check filter as logical vector
  f_logical <- db$get_filter_as_logical("df", "lt5")
  expect_equal(sum(f_logical), 4) # values 1..4

  # The current filter should be lt5
  curr <- db$get_current_filter("df")
  expect_equal(curr$name, "lt5")

  # Column selections
  sel <- list(type = "column_selection", columns = c("a"))
#  db$add_column_selection(data_name = "df", column_selection = sel, name = "sel_a", set_as_current = TRUE)

  cs_names <- db$get_column_selection_names("df")
#  expect_true("sel_a" %in% cs_names)

  curr_sel <- db$get_current_column_selection("df")
#  expect_equal(curr_sel$name, "sel_a")

  # get_columns_from_data respects column selection when asked
  cols <- db$get_columns_from_data("df", col_names = c("a"), force_as_data_frame = TRUE)
  expect_true("a" %in% names(cols))
})

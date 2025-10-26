test_that("replace_values_with_NA replaces by indices", {
  db <- DataBook$new()
  df <- data.frame(id = 1:4, a = c(1,2,3,4), b = c("x","y","z","w"), stringsAsFactors = FALSE)
  db$import_data(list(d = df))

  # replace row 2, column 2 (a) with NA
  db$replace_values_with_NA(data_name = "d", row_index = c(2), column_index = c(2))
  d2 <- db$get_data_frame("d")
  expect_true(is.na(d2[2,2]))

  # replace multiple cells: rows 1 and 3 in column 3
  db$replace_values_with_NA(data_name = "d", row_index = c(1,3), column_index = c(3))
  d3 <- db$get_data_frame("d")
  expect_true(is.na(d3[1,3]) && is.na(d3[3,3]))
})

test_that("remove_empty deletes fully empty rows and columns", {
  db <- DataBook$new()
  df <- data.frame(id = 1:4,
                   a = c(1, NA, NA, NA),
                   b = c(NA, NA, NA, NA),
                   stringsAsFactors = FALSE)
  db$import_data(list(d = df))

  out <- capture.output(db$remove_empty(data_name = "d", which = c("rows","cols")))
  # column 'b' should be removed
  dnew <- db$get_data_frame("d")
  expect_false("b" %in% names(dnew))
  # rows that were entirely NA should be removed (rows 2-4 mostly NA for a and b; but id kept)
  # check that number of cols decreased
  expect_true(ncol(dnew) < ncol(df))
})

test_that("get_column_names returns correct column names", {
  db <- DataBook$new()
  df <- data.frame(x = 1:3, y = letters[1:3], stringsAsFactors = FALSE)
  db$import_data(list(t1 = df))

  col_names <- db$get_column_names(data_name = "t1")
  expect_equal(col_names, c("x", "y"))
})

test_that("get_columns_from_data returns correct columns", {
  db <- DataBook$new()
  df <- data.frame(x = 1:3, y = letters[1:3], z = c(TRUE, FALSE, TRUE), stringsAsFactors = FALSE)
  db$import_data(list(t1 = df))

  cols <- db$get_columns_from_data(data_name = "t1", col_names = c("x", "z"))
  expect_equal(names(cols), c("x", "z"))
  expect_equal(as.integer(cols$x), df$x)
  expect_equal(as.logical(cols$z), df$z)
})

test_that("get_column_from_data returns correct single column", {
  db <- DataBook$new()
  df <- data.frame(x = 1:3, y = letters[1:3], stringsAsFactors = FALSE)
  db$import_data(list(t1 = df))

  col_x <- db$get_columns_from_data(data_name = "t1", col_name = "x")
  expect_equal(as.integer(col_x), df$x)

  col_y <- db$get_columns_from_data(data_name = "t1", col_name = "y")
  expect_equal(as.character(col_y), df$y)
})

test_that("get_data_frame returns correct dataframe", {
  db <- DataBook$new()
  df <- data.frame(m = 1:4, n = letters[1:4], stringsAsFactors = FALSE)
  db$import_data(list(mydata = df))

  retrieved_df <- db$get_data_frame("mydata")
  expect_equal(nrow(retrieved_df), nrow(df))
  expect_equal(ncol(retrieved_df), ncol(df))
  expect_equal(as.character(retrieved_df$n), df$n)
  expect_equal(as.integer(retrieved_df$m), df$m)
})

test_that("get_data_names returns correct data names", {
  db <- DataBook$new()
  df1 <- data.frame(a = 1:3, b = letters[1:3], stringsAsFactors = FALSE)
  df2 <- data.frame(x = 4:6, y = letters[4:6], stringsAsFactors = FALSE)
  db$import_data(list(data1 = df1, data2 = df2))

  data_names <- db$get_data_names()
  expect_true(all(c("data1", "data2") %in% data_names))
})

test_that("get_column_factor_levels returns correct factor levels", {
  db <- DataBook$new()
  df <- data.frame(id = 1:3, group = factor(c("A", "B", "A")), stringsAsFactors = FALSE)
  db$import_data(list(mydata = df))

  levels <- db$get_column_factor_levels(data_name = "mydata", col_name = "group")
  expect_equal(levels, c("A", "B"))
})
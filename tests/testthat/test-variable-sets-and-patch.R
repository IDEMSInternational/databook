test_that("variable set lifecycle: create, get, update, delete", {
  db <- DataBook$new()
  df <- data.frame(a = 1:4, b = 5:8, c = 9:12, stringsAsFactors = FALSE)
  db$import_data(list(df = df))

  # create set
  db$create_variable_set(data_name = "df", set_name = "myset", columns = c("a", "b"))
  names <- db$get_variable_sets_names(data_name = "df")
  expect_true("myset" %in% names)

  # get set columns
  cols <- db$get_variable_sets(data_name = "df", set_names = "myset")
  expect_true(all(c("a","b") %in% cols))

  # update set (rename and change columns)
  db$update_variable_set(data_name = "df", set_name = "myset", columns = c("b","c"), new_set_name = "newset")
  names2 <- db$get_variable_sets_names(data_name = "df")
  expect_false("myset" %in% names2)
  expect_true("newset" %in% names2)

  # delete set
  db$delete_variable_sets(data_name = "df", set_names = "newset")
  names3 <- db$get_variable_sets_names(data_name = "df")
  expect_false("newset" %in% names3)
})

test_that("patch_climate_element adds patched column (skipped if chillR missing)", {
  skip_if_not_installed("chillR")

  db <- DataBook$new()
  # build a small daily dataset for one variable and one patch source
  dates <- as.Date("2020-01-01") + 0:4
  t1 <- c(10, NA, 12, 11, NA)
  t2 <- c(9, 10, 11, 12, 13)
  df <- data.frame(date = dates, t = t1, t2 = t2)
  db$import_data(list(clim = df))

  # run patch; expect a new column 't_patched' to be added
  db$patch_climate_element(data_name = "clim", date_col_name = "date", var = "t", vars = c("t2"), column_name = "t_patched", time_interval = "month")
  out <- db$get_data_frame("clim")
  expect_true("t_patched" %in% names(out))
  expect_equal(nrow(out), nrow(df))
  expect_true(is.numeric(out$t_patched) || is.integer(out$t_patched))
})

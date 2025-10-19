library(testthat)

test_that("delete_dataframes removes frames and leaves others", {
  db <- DataBook$new()
  df_small <- data.frame(x = 1:2)
  db$import_data(list(a = df_small, b = df_small))
  expect_true(all(c("a", "b") %in% db$get_data_names()))

  db$delete_dataframes(c("a"))
  expect_false("a" %in% db$get_data_names())
  expect_true("b" %in% db$get_data_names())
})


test_that("keys: add_key, is_key, has_key and get_keys", {
  db <- DataBook$new()
  df <- data.frame(id = c(1,2,3), val = c("a","b","c"), stringsAsFactors = FALSE)
  db$import_data(list(df = df))

  # add key
  db$add_key("df", col_names = "id", key_name = "id_key")
  expect_true(db$is_key("df", "id"))
  expect_true(db$has_key("df"))
  keys <- db$get_keys("df")
  expect_true(length(keys) >= 1)
})

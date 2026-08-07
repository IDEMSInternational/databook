#clone_data_object
test_that("clone_data_object errors without get_data_frame", {
  db <- DataBook$new()
  bad_obj <- list()

  expect_error(
    db$clone_data_object(bad_obj),
    "Cannot import data. No 'get_data_frame' method."
  )
})

test_that("clone_data_object respects include_metadata", {
  db <- DataBook$new()
  df <- data.frame(a = 1:3, b = 4:6)
  db$import_data(list(df = df))

  obj <- db$get_data_objects("df")
  obj$append_to_metadata("custom_meta", "value")
  clone_no_meta <- db$clone_data_object(obj, include_metadata = FALSE)

  expect_equal(nrow(clone_no_meta$get_data_frame()), nrow(df))
  expect_false("custom_meta" %in% names(clone_no_meta$get_metadata()))
})

test_that("clone_data_object copies filters and column selections when included", {
  db <- DataBook$new()
  df <- data.frame(a = 1:3, b = 4:6)
  db$import_data(list(df = df))

  db$add_filter(
    filter = list(C0 = list(column = "a", operation = ">", value = 1)),
    data_name = "df",
    filter_name = "filter"
  )
  db$set_current_filter(data_name = "df", filter_name = "filter")

  db$add_column_selection(
    data_name = "df",
    name = "selection",
    column_selection = list(C0 = list(operation = "base::match", parameters = list(x = "a"))),
    and_or = "|"
  )
  db$set_current_column_selection(data_name = "df", name = "selection")

  obj <- db$get_data_objects("df")
  clone_with <- db$clone_data_object(obj, include_filters = TRUE, include_column_selections = TRUE)
  clone_without <- db$clone_data_object(obj, include_filters = FALSE, include_column_selections = FALSE)

  expect_true(clone_with$filter_applied())
  expect_true(clone_with$column_selection_applied())
  expect_false(clone_without$filter_applied())
  expect_false(clone_without$column_selection_applied())
})

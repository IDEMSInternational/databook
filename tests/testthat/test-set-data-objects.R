#set_data_objects
test_that("set_data_objects rejects non-list input", {
  db <- DataBook$new()

  expect_error(
    db$set_data_objects(iris),
    "new_data_objects must be a list of data_objects"
  )
})

test_that("set_data_objects rejects list with non-data objects", {
  db <- DataBook$new()

  expect_error(
    db$set_data_objects(list(bad = data.frame(x = 1))),
    "new_data_objects must be a list of data_objects"
  )
})

test_that("set_data_objects accepts DataSheet list", {
  db <- DataBook$new()
  sheet1 <- DataSheet$new(data = iris)
  sheet1$append_to_metadata("data_name", "df1")
  sheet2 <- DataSheet$new(data = mtcars)
  sheet2$append_to_metadata("data_name", "df2")

  db$set_data_objects(list(df1 = sheet1, df2 = sheet2))

  expect_equal(length(db$get_data_objects()), 2)
  expect_true("df1" %in% db$get_data_names())
  expect_true("df2" %in% db$get_data_names())
})

test_that("set_data_objects accepts empty list", {
  db <- DataBook$new()

  db$set_data_objects(list())

  expect_equal(length(db$get_data_objects()), 0)
})

library(testthat)
library(R6)

test_that("copies without filter or column selection", {
  data_book <- DataBook$new()
  df <- data.frame(a = 1:3, b = 4:6)
  data_book$import_data(list(df = df))

  data_book$copy_data_object("df", "copy")
  
  expect_identical(data.frame(data_book$get_data_frame("copy")),
                   data.frame(data_book$get_data_frame("df")))
})

test_that("applies filter", {
  data_book <- DataBook$new()
  df <- data.frame(a = 1:3, b = 4:6)
  data_book$import_data(list(df = df))
  
  # Create Filter subdialog: Created new filter
  data_book$add_filter(filter=list(C0=list(column="a", operation="<", value=3)), data_name="df", filter_name="filter")
  data_book$set_current_filter(data_name="df", filter_name="filter")
  
  data_book$copy_data_object("df", "copy")
  
  expect_identical(data.frame(data_book$get_data_frame("copy")),
                   data.frame(data_book$get_data_frame("df")))
})

test_that("applies column selection", {
  data_book <- DataBook$new()
  df <- data.frame(a = 1:3, b = 4:6)
  data_book$import_data(list(df = df))
  
  # Column selection subdialog: Created new column selection
  data_book$add_column_selection(data_name="df",
                                 name="selection",
                                 column_selection=list(C0=list(operation="base::match",
                                                               parameters=list(x="a"))),
                                 and_or="|")
  
  data_book$set_current_column_selection(data_name="df", name="selection")
  
  data_book$copy_data_object("df", "copy")
  
  expect_identical(data.frame(data_book$get_data_frame("copy")),
                   data.frame(data_book$get_data_frame("df")))
  
  # expect one column
  expect_equal(length(data.frame(data_book$get_data_frame("copy"))), 1)
})
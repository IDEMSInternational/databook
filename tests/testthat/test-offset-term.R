test_that("get_offset_term returns default when no doy_start metadata", {
  data_book <- DataBook$new()
  
  daily_data <- data.frame(
    rain = c(1, 2, 3),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(daily = daily_data))
  
  expect_equal(data_book$get_offset_term("daily"), 1)
})

test_that("get_offset_term returns the single doy_start value", {
  data_book <- DataBook$new()
  
  daily_data <- data.frame(
    rain = c(1, 2, 3),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(daily = daily_data))
  data_book$get_data_objects("daily")$append_to_variables_metadata("rain", "doy_start", 120)
  
  expect_equal(data_book$get_offset_term("daily"), 120)
})

test_that("get_offset_term warns and returns first doy_start when multiple values", {
  data_book <- DataBook$new()
  
  daily_data <- data.frame(
    rain = c(1, 2, 3),
    temp = c(10, 11, 12),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(daily = daily_data))
  data_book$get_data_objects("daily")$append_to_variables_metadata("rain", "doy_start", 120)
  data_book$get_data_objects("daily")$append_to_variables_metadata("temp", "doy_start", 150)
  
  expect_warning(
    expect_equal(data_book$get_offset_term("daily"), 120),
    regexp = "Multiple start DOYs"
  )
})

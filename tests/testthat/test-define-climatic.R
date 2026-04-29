test_that("define_as_climatic sets Is_Climatic metadata to TRUE", {
  data_book <- DataBook$new()
  
  daily_data <- data.frame(
    station = c("A", "A", "A"),
    date = as.Date(c("2020-01-01", "2020-01-02", "2020-01-03")),
    rain = c(5, 10, 0),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(daily = daily_data))
  
  types <- c("station", "date", "rain")
  names(types) <- c("station", "date", "rain")
  
  data_book$define_as_climatic(
    data_name = "daily",
    types = types,
    key_col_names = c("station", "date"),
    key_name = "station_date"
  )
  
  # Check that Is_Climatic metadata is set to TRUE
  is_climatic <- data_book$get_data_objects("daily")$get_metadata("Is_Climatic")
  expect_true(is_climatic)
})

test_that("define_as_climatic creates key when key_col_names provided", {
  data_book <- DataBook$new()
  
  daily_data <- data.frame(
    station = c("A", "A", "A"),
    date = as.Date(c("2020-01-01", "2020-01-02", "2020-01-03")),
    rain = c(5, 10, 0),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(daily = daily_data))
  
  types <- c("station", "date", "rain")
  names(types) <- c("station", "date", "rain")
  
  data_book$define_as_climatic(
    data_name = "daily",
    types = types,
    key_col_names = c("station", "date"),
    key_name = "station_date"
  )
  
  # Check that key was created
  keys <- data_book$get_data_objects("daily")$get_keys()
  expect_true("station_date" %in% names(keys))
})

test_that("define_as_climatic works without key_col_names", {
  data_book <- DataBook$new()
  
  daily_data <- data.frame(
    station = c("A", "A", "A"),
    date = as.Date(c("2020-01-01", "2020-01-02", "2020-01-03")),
    rain = c(5, 10, 0),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(daily = daily_data))
  
  types <- c("station", "date", "rain")
  names(types) <- c("station", "date", "rain")
  
  # Should work without error when key_col_names is NULL
  data_book$define_as_climatic(
    data_name = "daily",
    types = types,
    key_col_names = NULL,
    key_name = "station_date"
  )
  
  # Check that Is_Climatic metadata is still set
  is_climatic <- data_book$get_data_objects("daily")$get_metadata("Is_Climatic")
  expect_true(is_climatic)
})

test_that("define_as_climatic sets Is_Climatic metadata on the specified data table", {
  data_book <- DataBook$new()
  
  daily_data <- data.frame(
    station = c("A", "A"),
    date = as.Date(c("2020-01-01", "2020-01-02")),
    rain = c(5, 10),
    stringsAsFactors = FALSE
  )
  
  other_data <- data.frame(
    id = 1:3,
    value = c(10, 20, 30),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(
    daily = daily_data,
    other = other_data
  ))
  
  types <- c("station", "date", "rain")
  names(types) <- c("station", "date", "rain")
  
  data_book$define_as_climatic(
    data_name = "daily",
    types = types,
    key_col_names = c("station", "date"),
    key_name = "station_date"
  )
  
  # Check that the climatic data has Is_Climatic = TRUE
  is_climatic_daily <- data_book$get_data_objects("daily")$get_metadata("Is_Climatic")
  expect_true(is_climatic_daily)
  
  # Verify that the data has been defined as climatic
  expect_true(data_book$get_data_objects("daily")$is_climatic_data())
})

test_that("define_as_climatic calls set_climatic_types with overwrite parameter", {
  data_book <- DataBook$new()
  
  daily_data <- data.frame(
    station = c("A", "A"),
    date = as.Date(c("2020-01-01", "2020-01-02")),
    rain = c(5, 10),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(daily = daily_data))
  
  types <- c("station", "date", "rain")
  names(types) <- c("station", "date", "rain")
  
  # Test with overwrite = TRUE (default)
  data_book$define_as_climatic(
    data_name = "daily",
    types = types,
    key_col_names = c("station", "date"),
    key_name = "station_date",
    overwrite = TRUE
  )
  
  # Verify climatic types were set
  var_metadata <- data_book$get_variables_metadata("daily")
  expect_true("Climatic_Type" %in% colnames(var_metadata))
})

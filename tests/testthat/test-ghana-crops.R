test_that("ghana crops_definitions produces crop tables", {
  skip_if_not_installed("dplyr")

  # load the packaged example instat object
  data(ghana, package = "databook")

  data_book <- DataBook$new()
  # ghana is an instat RDS-like object saved in data/; import it into a fresh DataBook
  suppressWarnings(data_book$import_RDS(data_RDS = ghana))

  # Ensure any pre-existing outputs are removed so the test is deterministic
  try(data_book$delete_dataframes(data_names = c("crop_prop", "crop_def")), silent = TRUE)

  # Run the crops_definitions workflow using the expected column names in the example
  data_book$crops_definitions(data_name = "ghana",
                              year = "year",
                              station = "station",
                              rain = "rainfall",
                              day = "doy",
                              plant_days = c(100, 150),
                              plant_lengths = c(110),
                              rain_totals = c(370, 400, 500),
                              start_day = "start_rain",
                              season_data_name = "ghana_by_station_year",
                              end_day = "end_rains",
                              start_check = "both")

  out_names <- data_book$get_data_names()
  expect_true("crop_def" %in% out_names)
  expect_true("crop_prop" %in% out_names)

  crop_def <- data_book$get_data_frame("crop_def")
  crop_prop <- data_book$get_data_frame("crop_prop")

  # Structural checks: crop_def should include the plant/rain columns and station
  expect_true(all(c("plant_day", "plant_length", "rain_total", "rain_total_actual") %in% names(crop_def)))
  expect_true("station" %in% names(crop_def))

  # crop_prop should include proportion columns produced when start_check = "both"
  expect_true(any(c("prop_success_with_start", "prop_success_no_start") %in% names(crop_prop)))
})

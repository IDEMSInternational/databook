# File: tests/testthat/test-summary_sd_circular.R

test_that("summary_sd_circular computes sd for circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  # Use a simple dataset
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_sd_circular(x)
  
  # Expect a numeric value
  expect_type(result, "double")
  expect_false(is.na(result))
})

test_that("summary_sd_circular returns NA if all values are NA and na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(NA, NA), units = "degrees")
  result <- summary_sd_circular(x, na.rm = TRUE)
  
  # sd of empty after NA removal = NA
  expect_true(is.na(result))
})

test_that("summary_sd_circular returns NA if NA present and na.rm = FALSE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_sd_circular(x, na.rm = FALSE)
  
  # should be NA because NA is present
  expect_true(is.na(result))
})

test_that("summary_sd_circular removes NAs when na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_sd_circular(x, na.rm = TRUE)
  
  # Should be numeric and not NA
  expect_type(result, "double")
  expect_false(is.na(result))
})

test_that("summary_sd_circular returns NA when run_na_check fails", {
  skip_if_not_installed("circular")
  library(circular)
  
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_sd_circular(x)
  
  expect_true(is.na(result))
})

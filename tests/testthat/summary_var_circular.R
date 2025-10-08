# File: tests/testthat/test-summary_var_circular.R

test_that("summary_var_circular computes variance for circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  # Simple dataset
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_var_circular(x)
  
  # Expect numeric and not NA
  expect_type(result, "double")
  expect_false(is.na(result))
})

test_that("summary_var_circular returns NA if all values are NA and na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(NA, NA), units = "degrees")
  result <- summary_var_circular(x, na.rm = TRUE)
  
  # variance of empty after NA removal = NA
  expect_true(is.na(result))
})

test_that("summary_var_circular returns NA if NA present and na.rm = FALSE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_var_circular(x, na.rm = FALSE)
  
  expect_true(is.na(result))
})

test_that("summary_var_circular removes NAs when na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_var_circular(x, na.rm = TRUE)
  
  expect_type(result, "double")
  expect_false(is.na(result))
})

test_that("summary_var_circular returns NA when run_na_check fails", {
  skip_if_not_installed("circular")
  library(circular)
  
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_var_circular(x)
  
  expect_true(is.na(result))
})

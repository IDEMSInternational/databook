# File: tests/testthat/test-summary_min_circular.R

test_that("summary_min_circular computes minimum for circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_min_circular(x)
  
  expect_equal(result, 10)
})

test_that("summary_min_circular returns NA for empty vector", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(numeric(0), units = "degrees")
  result <- summary_min_circular(x)
  
  expect_true(is.na(result))
})

test_that("summary_min_circular returns NA if all values are NA and na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(NA, NA), units = "degrees")
  result <- summary_min_circular(x, na.rm = TRUE)
  
  expect_true(is.na(result))
})

test_that("summary_min_circular returns NA if NA present and na.rm = FALSE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_min_circular(x, na.rm = FALSE)
  
  expect_true(is.na(result))
})

test_that("summary_min_circular removes NAs when na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_min_circular(x, na.rm = TRUE)
  
  expect_equal(result, 10)
})

test_that("summary_min_circular returns NA when run_na_check fails", {
  skip_if_not_installed("circular")
  library(circular)
  
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_min_circular(x)
  
  expect_true(is.na(result))
})

test_that("summary_min_circular works with names = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(5, 15, 25), units = "degrees")
  result <- summary_min_circular(x, names = TRUE)
  
  # quantile.circular with names=TRUE returns a named vector, 
  # but we extract [[1]] in the function
  expect_equal(result, 5)
  expect_type(result, "double")
})

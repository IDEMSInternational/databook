# File: tests/testthat/test-summary_quantile_circular.R

test_that("summary_quantile_circular computes first quantile for circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, 20, 30, 40), units = "degrees")
  result <- summary_quantile_circular(x, probs = c(0, 0.5, 1))
  
  # The first quantile at probs=0 is the minimum (10)
  expect_equal(result, 10)
})

test_that("summary_quantile_circular returns NA for empty vector", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(numeric(0), units = "degrees")
  result <- summary_quantile_circular(x)
  
  expect_true(is.na(result))
})

test_that("summary_quantile_circular returns NA if all values are NA and na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(NA, NA), units = "degrees")
  result <- summary_quantile_circular(x, na.rm = TRUE)
  
  expect_true(is.na(result))
})

test_that("summary_quantile_circular returns NA if NA present and na.rm = FALSE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_quantile_circular(x, na.rm = FALSE)
  
  expect_true(is.na(result))
})

test_that("summary_quantile_circular removes NAs when na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30, 40), units = "degrees")
  result <- summary_quantile_circular(x, na.rm = TRUE, probs = c(0, 0.5, 1))
  
  # First quantile (minimum of non-NA values) = 10
  expect_equal(result, 10)
})

test_that("summary_quantile_circular respects custom probs", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(5, 15, 25, 35), units = "degrees")
  result <- summary_quantile_circular(x, probs = c(0.75, 1))
  
  # It always extracts [[1]] → so we expect the 75% quantile
  expect_equal(result, as.numeric(circular::quantile.circular(x, probs = 0.75)[[1]]))
})

test_that("summary_quantile_circular works with names = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(5, 15, 25), units = "degrees")
  result <- summary_quantile_circular(x, probs = c(0, 0.5, 1), names = TRUE)
  
  # Even though quantile.circular returns names, [[1]] extracts numeric
  expect_type(result, "double")
})

test_that("summary_quantile_circular returns NA when run_na_check fails", {
  skip_if_not_installed("circular")
  library(circular)
  
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_quantile_circular(x)
  
  expect_true(is.na(result))
})

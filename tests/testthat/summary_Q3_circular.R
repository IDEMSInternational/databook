# File: tests/testthat/test-summary_Q3_circular.R

test_that("summary_Q3_circular computes Q3 for circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, 20, 30, 40), units = "degrees")
  result <- summary_Q3_circular(x)
  
  # Q3 (75th percentile) of [10,20,30,40] is 32.5
  expect_equal(result, 32.5)
})

test_that("summary_Q3_circular returns NA for empty vector", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(numeric(0), units = "degrees")
  result <- summary_Q3_circular(x)
  
  expect_true(is.na(result))
})

test_that("summary_Q3_circular returns NA if all values are NA and na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(NA, NA), units = "degrees")
  result <- summary_Q3_circular(x, na.rm = TRUE)
  
  expect_true(is.na(result))
})

test_that("summary_Q3_circular returns NA if NA present and na.rm = FALSE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30, 40), units = "degrees")
  result <- summary_Q3_circular(x, na.rm = FALSE)
  
  expect_true(is.na(result))
})

test_that("summary_Q3_circular removes NAs when na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30, 40), units = "degrees")
  result <- summary_Q3_circular(x, na.rm = TRUE)
  
  # Q3 of [10,30,40] is 35
  expect_equal(result, 35)
})

test_that("summary_Q3_circular works with names = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(5, 15, 25, 35), units = "degrees")
  result <- summary_Q3_circular(x, names = TRUE)
  
  # Should return numeric even if names=TRUE
  expect_type(result, "double")
})

test_that("summary_Q3_circular returns NA when run_na_check fails", {
  skip_if_not_installed("circular")
  library(circular)
  
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- circular(c(10, 20, 30, 40), units = "degrees")
  result <- summary_Q3_circular(x)
  
  expect_true(is.na(result))
})

# File: tests/testthat/test-summary_range_circular.R

test_that("summary_range_circular computes range (first element) for circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, 20, 30, 40), units = "degrees")
  result <- summary_range_circular(x)
  
  expected <- circular::range.circular(x)[[1]]
  expect_equal(result, expected)
})

test_that("summary_range_circular returns NA if all values are NA and na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(NA, NA), units = "degrees")
  result <- summary_range_circular(x, na.rm = TRUE)
  
  expect_true(is.na(result))
})

test_that("summary_range_circular returns NA if NA present and na.rm = FALSE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_range_circular(x, na.rm = FALSE)
  
  expect_true(is.na(result))
})

test_that("summary_range_circular removes NAs when na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30, 40), units = "degrees")
  result <- summary_range_circular(x, na.rm = TRUE)
  
  expected <- circular::range.circular(x, na.rm = TRUE)[[1]]
  expect_equal(result, expected)
})

test_that("summary_range_circular respects finite = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, Inf, 30), units = "degrees")
  result <- summary_range_circular(x, finite = TRUE, na.rm = TRUE)
  
  expected <- circular::range.circular(x, finite = TRUE, na.rm = TRUE)[[1]]
  expect_equal(result, expected)
})

test_that("summary_range_circular returns NA when run_na_check fails", {
  skip_if_not_installed("circular")
  library(circular)
  
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_range_circular(x)
  
  expect_true(is.na(result))
})

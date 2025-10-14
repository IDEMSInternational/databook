# File: tests/testthat/test-summary_median_circular.R

test_that("summary_median_circular computes median for circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_median_circular(x)
  
  # For 10, 20, 30 → median should be 20
  expect_equal(result, 20)
})

test_that("summary_median_circular returns NA if NA present and na.rm = FALSE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_median_circular(x, na.rm = FALSE)
  
  expect_true(is.na(result))
})

test_that("summary_median_circular removes NAs when na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_median_circular(x, na.rm = TRUE)
  
  # Median of (10, 30) = 20
  expect_equal(result, 20)
})

test_that("summary_median_circular returns NA when run_na_check fails", {
  skip_if_not_installed("circular")
  library(circular)
  
  # Mock run_na_check to simulate NA check failure
  with_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA,
    {
      x <- circular(c(10, 20, 30), units = "degrees")
      result <- summary_median_circular(x)
      expect_true(is.na(result))
    }
  )
})

# File: tests/testthat/test-summary_mean.R

test_that("summary_mean computes mean for numeric data", {
  x <- c(1, 2, 3, 4, 5)
  result <- summary_mean(x)
  expect_equal(result, mean(x))
})

test_that("summary_mean computes trimmed mean", {
  x <- c(1, 2, 100, 200, 300)
  result <- summary_mean(x, trim = 0.2)
  expect_equal(result, mean(x, trim = 0.2))
})

test_that("summary_mean returns NA if NA present and na.rm = FALSE", {
  x <- c(1, NA, 3)
  result <- summary_mean(x, na.rm = FALSE)
  expect_true(is.na(result))
})

test_that("summary_mean removes NAs when na.rm = TRUE", {
  x <- c(1, NA, 3)
  result <- summary_mean(x, na.rm = TRUE)
  expect_equal(result, mean(c(1, 3)))
})

test_that("summary_mean computes weighted mean when weights provided", {
  x <- c(1, 2, 3)
  w <- c(0.2, 0.3, 0.5)
  result <- summary_mean(x, weights = w)
  expect_equal(result, weighted.mean(x, w))
})

test_that("summary_mean returns NA when run_na_check fails", {
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- c(1, 2, 3)
  result <- summary_mean(x)
  expect_true(is.na(result))
})

test_that("summary_mean handles empty vector correctly", {
  x <- numeric(0)
  result <- summary_mean(x, na.rm = TRUE)
  expect_true(is.na(result) || length(result) == 0)
})

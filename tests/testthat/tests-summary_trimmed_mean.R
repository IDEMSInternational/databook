# File: tests/testthat/test-summary_trimmed_mean.R

test_that("summary_trimmed_mean computes mean with no trimming", {
  x <- c(1, 2, 3, 4, 5)
  result <- summary_trimmed_mean(x)
  expect_equal(result, mean(x))
})

test_that("summary_trimmed_mean computes trimmed mean correctly", {
  x <- c(1, 2, 100, 200, 300)
  result <- summary_trimmed_mean(x, trimmed = 0.2)
  expect_equal(result, mean(x, trim = 0.2))
})

test_that("summary_trimmed_mean returns NA if NA present and na.rm = FALSE", {
  x <- c(1, NA, 3)
  result <- summary_trimmed_mean(x, na.rm = FALSE)
  expect_true(is.na(result))
})

test_that("summary_trimmed_mean removes NAs when na.rm = TRUE", {
  x <- c(1, NA, 3)
  result <- summary_trimmed_mean(x, na.rm = TRUE)
  expect_equal(result, mean(c(1, 3)))
})

test_that("summary_trimmed_mean returns NA for empty vector", {
  x <- numeric(0)
  result <- summary_trimmed_mean(x, na.rm = TRUE)
  expect_true(is.na(result))
})

test_that("summary_trimmed_mean returns NA if all values are NA and na.rm = TRUE", {
  x <- c(NA, NA)
  result <- summary_trimmed_mean(x, na.rm = TRUE)
  expect_true(is.na(result))
})

test_that("summary_trimmed_mean returns NA when run_na_check fails", {
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- c(1, 2, 3)
  result <- summary_trimmed_mean(x)
  expect_true(is.na(result))
})

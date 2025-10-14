# File: tests/testthat/test-summary_sum.R

test_that("summary_sum computes unweighted sum correctly", {
  x <- c(1, 2, 3, 4, 5)
  result <- summary_sum(x)
  expect_equal(result, sum(x))
})

test_that("summary_sum computes weighted sum correctly", {
  x <- c(1, 2, 3)
  w <- c(2, 2, 2)
  result <- summary_sum(x, weights = w)
  expect_equal(result, sum(x * w))
})

test_that("summary_sum handles NA with na.rm = FALSE", {
  x <- c(1, NA, 3)
  result <- summary_sum(x, na.rm = FALSE)
  expect_true(is.na(result))
})

test_that("summary_sum handles NA with na.rm = TRUE", {
  x <- c(1, NA, 3)
  result <- summary_sum(x, na.rm = TRUE)
  expect_equal(result, sum(c(1, 3)))
})

test_that("summary_sum handles NA in weighted sum with na.rm = TRUE", {
  x <- c(1, NA, 3)
  w <- c(1, 2, 3)
  result <- summary_sum(x, weights = w, na.rm = TRUE)
  expect_equal(result, sum(c(1, 3) * c(1, 3)))
})

test_that("summary_sum returns NA if all values are NA", {
  x <- c(NA, NA)
  result <- summary_sum(x, na.rm = TRUE)
  expect_true(is.na(result))
})

test_that("summary_sum returns NA for empty vector", {
  x <- numeric(0)
  result <- summary_sum(x, na.rm = TRUE)
  expect_true(is.na(result))
})

test_that("summary_sum returns NA when run_na_check fails", {
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- c(1, 2, 3)
  result <- summary_sum(x)
  expect_true(is.na(result))
})

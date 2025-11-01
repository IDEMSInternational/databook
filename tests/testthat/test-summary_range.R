# tests/testthat/test-summary_range.R

test_that("summary_range computes correct range for numeric vectors", {
  x <- c(1, 5, 9, 3)
  expect_equal(summary_range(x), 8)
})

test_that("summary_range handles NA values correctly with na.rm = FALSE", {
  x <- c(2, 4, NA, 10)
  expect_true(is.na(summary_range(x, na.rm = FALSE)))
})

test_that("summary_range removes NAs correctly with na.rm = TRUE", {
  x <- c(2, 4, NA, 10)
  expect_equal(summary_range(x, na.rm = TRUE), 8)
})

test_that("summary_range returns 0 for vectors with identical values", {
  x <- c(5, 5, 5)
  expect_equal(summary_range(x), 0)
})

test_that("summary_range works with negative values", {
  x <- c(-10, -2, -8)
  expect_equal(summary_range(x), 8)
})

test_that("summary_range returns NA if run_na_check returns NA", {
  with_mocked_bindings(
    run_na_check = function(...) NA,
    expect_true(is.na(summary_range(c(1, 2, 3))))
  )
})


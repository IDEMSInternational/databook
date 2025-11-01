# File: tests/testthat/test-summary_count_all.R

test_that("summary_count_all counts elements correctly", {
  x <- c(1, 2, 3, 4, 5)
  expect_equal(summary_count_all(x), 5)
})

test_that("summary_count_all includes NAs in count", {
  x <- c(1, NA, 3)
  expect_equal(summary_count_all(x), 3)
})

test_that("summary_count_all handles empty vector", {
  x <- numeric(0)
  expect_equal(summary_count_all(x), 0)
})

test_that("summary_count_all works with list input", {
  x <- list("a", "b", "c")
  expect_equal(summary_count_all(x), 3)
})

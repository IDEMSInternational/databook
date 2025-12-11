# File: tests/testthat/test-summary_count_miss.R

test_that("summary_count_miss counts missing elements correctly", {
  x <- c(1, 2, NA, 4, NA, 6)
  expect_equal(summary_count_miss(x), 2)
})

test_that("summary_count_miss returns 0 when no missing values", {
  x <- c(1, 2, 3, 4, 5)
  expect_equal(summary_count_miss(x), 0)
})

test_that("summary_count_miss works with all NA values", {
  x <- c(NA, NA, NA)
  expect_equal(summary_count_miss(x), 3)
})

test_that("summary_count_miss works with empty input", {
  x <- c()
  expect_equal(summary_count_miss(x), 0)
})

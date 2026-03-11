# File: tests/testthat/test-summary_count.R

test_that("summary_count counts non-missing elements correctly", {
  x <- c(1, 2, 3, NA, 5)
  expect_equal(summary_count(x), 4)
})

test_that("summary_count returns 0 when all values are missing", {
  x <- c(NA, NA, NA)
  expect_equal(summary_count(x), 0)
})

test_that("summary_count returns length when no missing values", {
  x <- c(10, 20, 30, 40)
  expect_equal(summary_count(x), length(x))
})

test_that("summary_count returns 0 for empty input", {
  x <- c()
  expect_equal(summary_count(x), 0)
})

# 🔍 Cross-check consistency of all three functions
test_that("summary_count + summary_count_miss equals summary_count_all", {
  x <- c(1, 2, NA, 4, NA, 6)
  expect_equal(
    summary_count(x) + summary_count_miss(x),
    summary_count_all(x)
  )
})

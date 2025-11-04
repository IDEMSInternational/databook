# test-summary_nth.R

test_that("summary_nth returns the correct nth element", {
  x <- c(10, 20, 30, 40)
  result <- summary_nth(x, nth_value = 2)
  expect_equal(result, 20)
})

test_that("summary_nth works with order_by argument", {
  x <- c("apple", "banana", "cherry")
  order_by <- c(3, 1, 2)  # banana should come first
  result <- summary_nth(x, nth_value = 2, order_by = order_by)
  expect_equal(result, "cherry")
})

test_that("summary_nth returns NA for out-of-range nth_value", {
  x <- c(1, 2, 3)
  result <- summary_nth(x, nth_value = 10)
  expect_true(is.na(result))
})

test_that("summary_nth returns NA for empty vector", {
  x <- c()
  result <- summary_nth(x, nth_value = 1)
  expect_true(is.na(result))
})

test_that("summary_nth returns NA for NULL input", {
  result <- summary_nth(NULL, nth_value = 1)
  expect_true(is.na(result))
})

test_that("summary_nth returns NA for invalid nth_value (negative or zero)", {
  x <- c(5, 6, 7)
  expect_true(is.na(summary_nth(x, nth_value = 0)))
  expect_true(is.na(summary_nth(x, nth_value = -2)))
})

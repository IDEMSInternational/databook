# test-summary_first.R

test_that("summary_first returns the first element of a vector", {
  x <- c(10, 20, 30, 40)
  result <- summary_first(x)
  expect_equal(result, 10)
})

test_that("summary_first returns the first element when ordered by another vector", {
  x <- c("apple", "banana", "cherry")
  order_by <- c(3, 1, 2)  # reorder indices
  result <- summary_first(x, order_by = order_by)
  expect_equal(result, "banana")  # because order_by sorts as 1,2,3
})

test_that("summary_first returns NA for empty vector", {
  x <- c()
  result <- summary_first(x)
  expect_true(is.na(result))
})

test_that("summary_first handles factor vectors", {
  x <- factor(c("low", "medium", "high"), levels = c("low", "medium", "high"))
  result <- summary_first(x)
  expect_equal(result, factor("low", levels = c("low", "medium", "high")))
})

test_that("summary_first works with numeric ordering", {
  x <- c("a", "b", "c", "d")
  order_by <- c(4, 3, 2, 1)
  result <- summary_first(x, order_by = order_by)
  expect_equal(result, "d")  # smallest order_by value corresponds to "d"
})

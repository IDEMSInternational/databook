# test-summary_where_max.R

test_that("summary_where_max returns corresponding value for maximum x", {
  x <- c(1, 5, 3, 2)
  y <- c("a", "b", "c", "d")
  result <- summary_where_max(x, y)
  expect_equal(result, "b") # max of x = 5 → y[2] = "b"
})

test_that("summary_where_max handles multiple maxima correctly", {
  x <- c(4, 2, 4, 1)
  y <- c("x", "y", "z", "w")
  result <- summary_where_max(x, y)
  expect_equal(result, "x") # which.max returns first occurrence (index 1)
})

test_that("summary_where_max handles NA values when na.rm = TRUE", {
  x <- c(1, NA, 3, 2)
  y <- c("a", "b", NA, "d")
  result <- summary_where_max(x, y, na.rm = TRUE)
  expect_equal(result, "d") # max x = 3, but corresponding y is NA, so next valid is "d"
})

test_that("summary_where_max handles NA values when na.rm = FALSE", {
  x <- c(1, NA, 5)
  y <- c("a", "b", "c")
  result <- summary_where_max(x, y, na.rm = FALSE)
  expect_equal(result, "c") # NA values ignored by which.max, still returns index 3
})

test_that("summary_where_max returns NA for empty vectors", {
  expect_true(is.na(summary_where_max(numeric(0), character(0))))
})

test_that("summary_where_max handles mismatched lengths gracefully", {
  x <- c(1, 2, 3)
  y <- c("a", "b")  # shorter
  expect_error(summary_where_max(x, y))
})

test_that("summary_where_max returns NA when all values are NA and na.rm = TRUE", {
  x <- c(NA, NA, NA)
  y <- c("a", "b", "c")
  result <- summary_where_max(x, y, na.rm = TRUE)
  expect_true(is.na(result))
})

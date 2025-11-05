test_that("summary_where_min returns correct corresponding value", {
  x <- c(10, 3, 7, 1)
  y <- c("a", "b", "c", "d")
  expect_equal(summary_where_min(x, y), "d")
})

test_that("summary_where_min handles NAs correctly with na.rm = TRUE", {
  x <- c(NA, 5, 2, NA, 8)
  y <- c("a", "b", "c", "d", "e")
  expect_equal(summary_where_min(x, y, na.rm = TRUE), "c")
})

test_that("summary_where_min returns NA when all values are NA and na.rm = TRUE", {
  x <- c(NA, NA, NA)
  y <- c("x", "y", "z")
  expect_true(is.na(summary_where_min(x, y, na.rm = TRUE)))
})

test_that("summary_where_min keeps NA if na.rm = FALSE", {
  x <- c(NA, 4, 2)
  y <- c("p", "q", "r")
  # If na.rm = FALSE, function should try to compute min with NA and return NA
  expect_true(is.na(summary_where_min(x, y, na.rm = FALSE)))
})

test_that("summary_where_min handles empty vectors gracefully", {
  x <- numeric(0)
  y <- character(0)
  expect_true(is.na(summary_where_min(x, y)))
})

test_that("summary_where_min handles mismatched vector lengths gracefully", {
  x <- c(1, 2, 3)
  y <- c("a", "b")  # shorter
  expect_error(summary_where_min(x, y))
})

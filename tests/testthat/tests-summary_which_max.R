test_that("summary_which_max returns indices of maximum values", {
  x <- c(1, 3, 5, 5, 2)
  expect_equal(summary_which_max(x), c(3, 4))  # indices of max 5
})

test_that("summary_which_max ignores NA when na.rm = TRUE", {
  x <- c(1, NA, 4, 2)
  expect_equal(summary_which_max(x, na.rm = TRUE), 3)  # max is 4 at index 3
})

test_that("summary_which_max returns NA when na.rm = FALSE and NA present", {
  x <- c(1, NA, 3)
  expect_true(is.na(summary_which_max(x, na.rm = FALSE)))
})

test_that("summary_which_max works with all values equal", {
  x <- c(7, 7, 7)
  expect_equal(summary_which_max(x), c(1, 2, 3))  # all indices since all are max
})

test_that("summary_which_max works with a single value", {
  x <- 42
  expect_equal(summary_which_max(x), 1)
})

test_that("summary_which_max returns NA for empty vector", {
  x <- numeric(0)
  expect_true(is.na(summary_which_max(x)))
})

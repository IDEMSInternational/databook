# test-summary_which_max.R
test_that("summary_which_max returns correct indices for simple numeric vector", {
  x <- c(1, 3, 5, 2, 5)
  result <- summary_which_max(x)
  expect_equal(result, c(3, 5)) # max value 5 occurs at positions 3 and 5
})

test_that("summary_which_max handles NA values properly", {
  x <- c(1, NA, 4, NA, 4)
  
  # na.rm = TRUE should ignore NA
  result <- summary_which_max(x, na.rm = TRUE)
  expect_equal(result, c(3, 5))
  
  # na.rm = FALSE should return NA since max(x) = NA
  expect_true(is.na(summary_which_max(x, na.rm = FALSE)))
})

test_that("summary_which_max returns NA when run_na_check signals NA", {
  mock_run_na_check <- function(x, na.rm, na_type, ...) NA
  with_mocked_bindings(
    run_na_check = mock_run_na_check,
    {
      x <- c(1, 2, 3)
      expect_true(is.na(summary_which_max(x)))
    }
  )
})

test_that("summary_which_max works correctly for negative numbers", {
  x <- c(-5, -2, -10, -2)
  result <- summary_which_max(x)
  expect_equal(result, c(2, 4))
})

test_that("summary_which_max handles single-value vector", {
  x <- 7
  expect_equal(summary_which_max(x), 1)
})

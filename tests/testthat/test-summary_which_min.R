# test-summary_which_min.R
test_that("summary_which_min returns correct indices for simple numeric vector", {
  x <- c(1, 3, 0, 2, 0)
  result <- summary_which_min(x)
  expect_equal(result, c(3, 5)) # min value 0 occurs at positions 3 and 5
})

test_that("summary_which_min handles NA values properly", {
  x <- c(1, NA, 0, NA, 0)
  
  # na.rm = TRUE should ignore NA
  result <- summary_which_min(x, na.rm = TRUE)
  expect_equal(result, c(3, 5))
  
  # na.rm = FALSE should return NA since min(x) = NA
  expect_true(is.na(summary_which_min(x, na.rm = FALSE)))
})

test_that("summary_which_min returns NA when run_na_check signals NA", {
  mock_run_na_check <- function(x, na.rm, na_type, ...) NA
  with_mocked_bindings(
    run_na_check = mock_run_na_check,
    {
      x <- c(1, 2, 3)
      expect_true(is.na(summary_which_min(x)))
    }
  )
})

test_that("summary_which_min works correctly for negative numbers", {
  x <- c(-5, -2, -10, -2)
  result <- summary_which_min(x)
  expect_equal(result, 3) # -10 is the minimum
})

test_that("summary_which_min handles single-value vector", {
  x <- 7
  expect_equal(summary_which_min(x), 1)
})

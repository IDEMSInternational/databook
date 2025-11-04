# test-summary_coef_var.R

test_that("summary_coef_var works correctly for unweighted data", {
  x <- c(1, 2, 3, 4, 5)
  expected <- sd(x) / mean(x)
  
  # Mock summary_mean and summary_sd for dependency isolation
  mock_summary_mean <- function(x) mean(x)
  mock_summary_sd <- function(x) sd(x)
  
  with_mocked_bindings(
    summary_mean = mock_summary_mean,
    summary_sd = mock_summary_sd,
    result <- summary_coef_var(x)
  )
  
  expect_equal(result, expected)
})

test_that("summary_coef_var handles NAs correctly when na.rm = TRUE", {
  x <- c(1, 2, NA, 4, 5)
  expected <- sd(na.omit(x)) / mean(na.omit(x))
  
  mock_summary_mean <- function(x) mean(x, na.rm = TRUE)
  mock_summary_sd <- function(x) sd(x, na.rm = TRUE)
  
  with_mocked_bindings(
    summary_mean = mock_summary_mean,
    summary_sd = mock_summary_sd,
    result <- summary_coef_var(x, na.rm = TRUE)
  )
  
  expect_equal(result, expected)
})

test_that("summary_coef_var returns NA when run_na_check returns NA", {
  mock_run_na_check <- function(...) NA
  with_mocked_bindings(
    run_na_check = mock_run_na_check,
    expect_true(is.na(summary_coef_var(c(1, 2, 3))))
  )
})

test_that("summary_coef_var works correctly for weighted data", {
  x <- c(2, 4, 6, 8)
  w <- c(1, 2, 3, 4)
  
  expected <- Weighted.Desc.Stat::w.cv(x = x, mu = w)
  result <- summary_coef_var(x, weights = w)
  
  expect_equal(result, expected)
})

test_that("summary_coef_var throws error for mismatched weight length", {
  x <- c(1, 2, 3)
  w <- c(1, 2)
  
  expect_error(summary_coef_var(x, weights = w))
})

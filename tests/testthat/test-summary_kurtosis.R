# test-summary_kurtosis.R

test_that("summary_kurtosis works correctly for unweighted data", {
  x <- c(1, 2, 3, 4, 5)
  expected <- e1071::kurtosis(x, type = 2)
  result <- summary_kurtosis(x)
  expect_equal(result, expected)
})

test_that("summary_kurtosis removes NAs when na.rm = TRUE", {
  x <- c(1, 2, NA, 4, 5)
  expected <- e1071::kurtosis(na.omit(x), type = 2)
  result <- summary_kurtosis(x, na.rm = TRUE)
  expect_equal(result, expected)
})

test_that("summary_kurtosis returns NA when run_na_check returns NA", {
  mock_run_na_check <- function(...) NA
  with_mocked_bindings(
    run_na_check = mock_run_na_check,
    expect_true(is.na(summary_kurtosis(c(1, 2, 3))))
  )
})

test_that("summary_kurtosis works correctly for weighted data", {
  x <- c(1, 2, 3, 4, 5)
  w <- c(1, 2, 3, 2, 1)
  
  # Manual weighted kurtosis
  weighted_mean <- Weighted.Desc.Stat::w.mean(x, w)
  weighted_sd <- Weighted.Desc.Stat::w.sd(x, w)
  expected <- ((sum(w * (x - weighted_mean)^4) / sum(w)) / weighted_sd^4) - 3
  
  result <- summary_kurtosis(x, weights = w)
  expect_equal(result, expected)
})

test_that("summary_kurtosis throws error for mismatched weight length", {
  x <- c(1, 2, 3)
  w <- c(1, 2)
  expect_error(summary_kurtosis(x, weights = w))
})

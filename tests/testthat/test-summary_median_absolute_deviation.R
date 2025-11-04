# test-summary_median_absolute_deviation.R

test_that("summary_median_absolute_deviation computes correct unweighted MAD", {
  x <- c(1, 2, 3, 4, 5)
  expected <- stats::mad(x, constant = 1.4826, na.rm = FALSE)
  
  result <- summary_median_absolute_deviation(x)
  
  expect_equal(result, expected)
  expect_type(result, "double")
})

test_that("summary_median_absolute_deviation handles NA values correctly with na.rm = TRUE", {
  x <- c(1, 2, NA, 4, 5)
  expected <- stats::mad(x, constant = 1.4826, na.rm = TRUE)
  
  result <- summary_median_absolute_deviation(x, na.rm = TRUE)
  
  expect_equal(result, expected)
})

test_that("summary_median_absolute_deviation returns NA when na_check fails", {
  mock_na_check <- function(...) FALSE
  
  with_mocked_bindings(
    na_check = mock_na_check,
    result <- summary_median_absolute_deviation(c(1, 2, 3), na.rm = TRUE, na_type = "test")
  )
  
  expect_true(is.na(result))
})

test_that("summary_median_absolute_deviation computes weighted absolute deviation", {
  x <- c(2, 4, 6, 8)
  w <- c(1, 2, 3, 4)
  
  expected <- Weighted.Desc.Stat::w.ad(x = x, mu = w)
  result <- summary_median_absolute_deviation(x, weights = w)
  
  expect_equal(result, expected)
})

test_that("summary_median_absolute_deviation handles low and high parameters", {
  x <- c(1, 2, 3, 4, 5)
  
  result_low <- summary_median_absolute_deviation(x, low = TRUE)
  result_high <- summary_median_absolute_deviation(x, high = TRUE)
  
  expect_true(is.numeric(result_low))
  expect_true(is.numeric(result_high))
})

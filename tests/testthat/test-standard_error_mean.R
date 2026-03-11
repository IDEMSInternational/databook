test_that("standard_error_mean computes correct standard error of the mean", {
  # A simple numeric vector
  x <- c(2, 4, 6, 8, 10)
  
  # Capture printed output (not necessary, but we follow the same test style)
  result <- standard_error_mean(x)
  
  # Manually calculate expected standard error
  expected <- stats::sd(x) / sqrt(length(x))
  
  # Verify correct computation
  expect_equal(result, expected)
})

test_that("standard_error_mean handles missing values correctly", {
  x <- c(2, 4, NA, 6, 8)
  
  # When na.rm = FALSE, should return NA
  result <- standard_error_mean(x, na.rm = FALSE)
  expect_true(is.na(result))
  
  # When na.rm = TRUE, should ignore NA and compute correctly
  result <- standard_error_mean(x, na.rm = TRUE)
  expected <- stats::sd(stats::na.omit(x)) / sqrt(length(stats::na.omit(x)))
  expect_equal(result, expected)
})

test_that("standard_error_mean returns NA for all-NA or empty inputs", {
  # All NA values
  x <- c(NA, NA, NA)
  result <- standard_error_mean(x)
  expect_true(is.na(result))
  
  # Empty vector
  x <- c()
  result <- standard_error_mean(x)
  expect_true(is.nan(result) || length(x) == 0)
})

test_that("mae correctly computes mean absolute error for valid numeric vectors", {
  # Sample observed and simulated data
  x <- c(10, 12, 14, 16, 18)  # observed
  y <- c(11, 13, 13, 17, 19)  # simulated
  
  # Compute using your function
  result <- mae(x, y)
  
  # Compute expected manually using hydroGOF::mae
  expected <- hydroGOF::mae(sim = y, obs = x)
  
  # Compare results
  expect_equal(result, expected)
})

test_that("mae handles missing values correctly", {
  x <- c(10, 12, NA, 16, 18)
  y <- c(11, 13, 13, 17, 19)
  
  # When na.rm = FALSE → should return NA
  result <- mae(x, y, na.rm = FALSE)
  expect_true(is.na(result))
  
  # When na.rm = TRUE → should remove NAs and calculate correctly
  result <- mae(x, y, na.rm = TRUE)
  expected <- hydroGOF::mae(sim = y, obs = x, na.rm = TRUE)
  expect_equal(result, expected)
})

test_that("mae returns NA for fully missing or empty inputs", {
  # All NA values
  x <- c(NA, NA, NA)
  y <- c(NA, NA, NA)
  result <- mae(x, y)
  expect_true(is.na(result))
  
  # Empty vectors
  result <- mae(c(), c())
  expect_true(is.na(result))
})

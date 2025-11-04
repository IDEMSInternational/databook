test_that("ssq computes correct Sum of Squared Residuals", {
  testthat::skip_if_not_installed("hydroGOF")
  
  # Sample observed and simulated values
  x <- c(2, 4, 6, 8, 10)
  y <- c(1.8, 4.5, 5.5, 7.8, 9.9)
  
  # Expected result from hydroGOF directly
  expected <- hydroGOF::ssq(sim = y, obs = x, na.rm = TRUE)
  
  # Run our function
  result <- ssq(x, y, na.rm = TRUE)
  
  # They should match
  expect_equal(result, expected, tolerance = 1e-10)
})

test_that("ssq handles NA values properly", {
  x <- c(2, NA, 6, 8, 10)
  y <- c(1.8, 4.5, 5.5, 7.8, 9.9)
  
  # With na.rm = TRUE → should compute using non-NA values
  result <- ssq(x, y, na.rm = TRUE)
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  
  # With na.rm = FALSE → depends on run_na_check behavior
  # If you intend to return NA when NA present and na.rm = FALSE:
  result_na <- ssq(x, y, na.rm = FALSE)
  expect_true(is.na(result_na))
})

test_that("ssq returns NA when all x or y are NA", {
  x <- c(NA, NA, NA)
  y <- c(1, 2, 3)
  expect_true(is.na(ssq(x, y)))
  
  x <- c(1, 2, 3)
  y <- c(NA, NA, NA)
  expect_true(is.na(ssq(x, y)))
})

test_that("ssq handles empty and mismatched inputs", {
  # Empty vectors
  expect_true(is.na(ssq(numeric(0), numeric(0))))
  
  # Mismatched lengths → hydroGOF::ssq should error
  x <- 1:4
  y <- 1:3
  expect_error(ssq(x, y))
})

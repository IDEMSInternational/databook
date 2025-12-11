test_that("VE computes correct Volumetric Efficiency", {
  testthat::skip_if_not_installed("hydroGOF")
  
  # Example observed and simulated values
  x <- c(3, 5, 7, 9, 11)
  y <- c(2.8, 5.2, 6.8, 9.1, 10.9)
  
  # Expected result from hydroGOF directly
  expected <- hydroGOF::VE(sim = y, obs = x, na.rm = TRUE)
  
  # Run our wrapper function
  result <- VE(x, y, na.rm = TRUE)
  
  # Should match closely
  expect_equal(result, expected, tolerance = 1e-10)
})


test_that("VE handles NA values properly", {
  testthat::skip_if_not_installed("hydroGOF")
  
  x <- c(3, NA, 7, 9, 11)
  y <- c(2.8, 5.2, 6.8, 9.1, 10.9)
  
  # With na.rm = TRUE → should compute ignoring NA
  result <- VE(x, y, na.rm = TRUE)
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  
  # With na.rm = FALSE → should return NA
  result_na <- VE(x, y, na.rm = FALSE)
  expect_true(is.na(result_na))
})


test_that("VE returns NA when all values are missing", {
  testthat::skip_if_not_installed("hydroGOF")
  
  x <- c(NA, NA, NA, NA)
  y <- c(NA, NA, NA, NA)
  
  result <- VE(x, y, na.rm = TRUE)
  expect_true(is.na(result))
})

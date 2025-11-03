test_that("nrmse correctly computes normalized RMSE for valid numeric vectors", {
  # Sample observed and simulated data
  x <- c(10, 12, 14, 16, 18)  # observed
  y <- c(11, 13, 13, 17, 19)  # simulated
  
  # Compute using your function
  result <- nrmse(x, y)
  
  # Expected value using hydroGOF
  expected <- hydroGOF::nrmse(sim = y, obs = x)
  
  # Compare results
  expect_equal(result, expected)
})


test_that("nrmse handles missing values correctly", {
  x <- c(10, 12, NA, 16, 18)
  y <- c(11, 13, 13, 17, 19)
  
  # When na.rm = FALSE → should return NA
  result <- nrmse(x, y, na.rm = FALSE)
  expect_true(is.na(result))
  
  # When na.rm = TRUE → should remove NAs and calculate correctly
  result <- nrmse(x, y, na.rm = TRUE)
  expected <- hydroGOF::nrmse(sim = y, obs = x, na.rm = TRUE)
  expect_equal(result, expected)
})


test_that("nrmse returns NA when all observed or simulated values are missing", {
  x <- c(NA, NA, NA, NA)
  y <- c(1, 2, 3, 4)
  expect_true(is.na(nrmse(x, y)))
  
  x <- c(1, 2, 3, 4)
  y <- c(NA, NA, NA, NA)
  expect_true(is.na(nrmse(x, y)))
})


test_that("nrmse respects run_na_check returning NA", {
  # Mock version of run_na_check that forces NA return
  mock_run_na_check <- function(...) NA
  
  # Temporarily replace in current environment (works safely)
  result <- testthat::with_mocked_bindings(
    nrmse(c(1, 2, 3), c(1, 2, 3)),
    run_na_check = mock_run_na_check
  )
  
  expect_true(is.na(result))
})

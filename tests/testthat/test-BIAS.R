test_that("test_BIAS_returns_correct_bias", {
  # Sample observed and predicted binary values
  observed <- c(1, 0, 1, 1, 0)
  predicted <- c(1, 1, 1, 0, 0)
  
  # Manual bias calculation:
  # Forecast yes = 3 (positions 1, 2, 3)
  # Observed yes = 3 (positions 1, 3, 4)
  # Bias = forecast yes / observed yes = 3/3 = 1.0
  expected_BIAS <- 1.0
  
  # Compute using the function
  result <- BIAS(
    x = observed,
    y = predicted,
    frcst.type = "binary",
    obs.type = "binary"
  )
  
  # Allow small rounding differences
  expect_true(abs(result - expected_BIAS) < 0.01)
})

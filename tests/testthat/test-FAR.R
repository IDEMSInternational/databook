# test-FAR.R
test_that("FAR computes correct False Alarm Ratio", {
  testthat::skip_if_not_installed("verification")
  
  # Example binary observed and predicted data
  obs <- c(1, 0, 1, 0, 0, 1)
  pred <- c(1, 0, 1, 1, 0, 0)
  
  # Expected FAR from verification package
  expected <- verification::verify(
    obs = obs,
    pred = pred,
    frcst.type = "binary",
    obs.type = "binary"
  )$FAR
  
  # Run the wrapper
  result <- FAR(
    x = obs,
    y = pred,
    frcst.type = "binary",
    obs.type = "binary"
  )
  
  # Compare results
  expect_equal(result, expected, tolerance = 1e-10)
})

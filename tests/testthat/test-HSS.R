# test-HSS.R

test_that("HSS computes correct Heidke Skill Score", {
  testthat::skip_if_not_installed("verification")
  
  # Example binary observed and predicted data
  obs <- c(1, 0, 1, 0, 0, 1)
  pred <- c(1, 0, 1, 1, 0, 0)
  
  # Expected result from verification::verify directly
  expected <- verification::verify(
    obs = obs,
    pred = pred,
    frcst.type = "binary",
    obs.type = "binary"
  )$HSS
  
  # Run wrapper
  result <- HSS(
    x = obs,
    y = pred,
    frcst.type = "binary",
    obs.type = "binary"
  )
  
  # Compare results
  expect_equal(result, expected, tolerance = 1e-10)
})

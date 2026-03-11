test_that("pss computes correct Pierce Skill Score", {
  testthat::skip_if_not_installed("verification")
  
  # Example binary observed and predicted data
  obs <- c(1, 0, 1, 0, 1, 1, 0, 0)
  pred <- c(1, 0, 1, 1, 0, 1, 0, 0)
  
  # Expected result directly from verification::verify
  expected <- verification::verify(obs = obs, pred = pred,
                                   frcst.type = "binary",
                                   obs.type = "binary")$pss
  
  # Run our wrapper
  result <- pss(x = obs, y = pred,
                frcst.type = "binary",
                obs.type = "binary")
  
  # Should match exactly
  expect_equal(result, expected, tolerance = 1e-10)
})

test_that("ETS computes correct Equitable Threat Score", {
  testthat::skip_if_not_installed("verification")
  
  obs <- c(1, 0, 1, 1, 0, 1)
  pred <- c(1, 0, 1, 0, 0, 1)
  
  expected <- verification::verify(
    obs = obs,
    pred = pred,
    frcst.type = "binary",
    obs.type = "binary"
  )$ETS
  
  result <- ETS(
    x = obs,
    y = pred,
    frcst.type = "binary",
    obs.type = "binary"
  )
  
  expect_equal(result, expected, tolerance = 1e-10)
})

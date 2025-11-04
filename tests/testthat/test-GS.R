test_that("GS handles NA values or invalid input gracefully", {
  testthat::skip_if_not_installed("verification")
  
  obs <- c(1, 2, NA, 1, 2)
  pred <- c(1, 2, 3, 1, 2)
  
  # Should not throw an unexpected error
  expect_error({
    result <- GS(
      x = obs,
      y = pred,
      frcst.type = "categorical",
      obs.type = "categorical"
    )
  })
})

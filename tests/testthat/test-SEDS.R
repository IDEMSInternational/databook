test_that("test_SEDS_returns_valid_or_NA", {
  testthat::skip_if_not_installed("verification")
  
  observed <- c(1, 0, 1, 1, 0)
  predicted <- c(1, 0, 1, 0, 0)
  
  # Try computing SEDS safely
  expect_warning(
    SEDS(
      x = observed,
      y = predicted,
      frcst.type = "categorical",
      obs.type = "categorical"
    ),
    "SEDS not supported for this forecast/observation combination. Returning NA."
  )
})

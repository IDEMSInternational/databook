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
  
  # If the function works, result should be numeric or NA
  expect_true(is.numeric(result) || is.na(result))
  
  # If numeric, should fall within the valid range [-1, 1]
  if (!is.na(result)) {
    expect_true(result >= -1 && result <= 1)
  }
})

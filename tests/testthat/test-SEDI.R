test_that("test_SEDI_returns_valid_or_NA", {
  testthat::skip_if_not_installed("verification")
  
  # Example observed and predicted categorical data
  observed <- c(1, 0, 1, 1, 0)
  predicted <- c(1, 0, 1, 0, 0)
  
  # Suppress warnings from unsupported combinations
  result <- suppressWarnings(
    SEDI(
      x = observed,
      y = predicted,
      frcst.type = "categorical",
      obs.type = "categorical"
    )
  )
  
  # Ensure output is numeric or NA
  expect_true(is.numeric(result) || is.na(result))
  
  # If numeric, should be in valid range [-1, 1]
  if (!is.na(result)) {
    expect_true(result >= -1 && result <= 1)
  }
})

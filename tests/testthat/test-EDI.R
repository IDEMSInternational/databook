test_that("test_EDI_returns_valid_or_NA", {
  testthat::skip_if_not_installed("verification")
  
  observed <- c(1, 0, 1, 1, 0)
  predicted <- c(1, 0, 1, 0, 0)
  
  result <- suppressWarnings(
    EDI(
      x = observed,
      y = predicted,
      frcst.type = "categorical",
      obs.type = "categorical"
    )
  )
  
  expect_true(is.numeric(result) || is.na(result))
  
  if (!is.na(result)) {
    expect_true(result >= -1 && result <= 1)
  }
})

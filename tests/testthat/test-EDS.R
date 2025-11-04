test_that("test_EDS_returns_NA_when_unsupported", {
  observed <- c(1, 0, 1, 1, 0)
  predicted <- c(1, 0, 1, 0, 0)
  
  result <- EDS(
    x = observed,
    y = predicted,
    frcst.type = "categorical",
    obs.type = "categorical"
  )
  
  # EDS is likely unsupported for categorical forecasts
  expect_true(is.numeric(result))
  expect_true(is.na(result))
})

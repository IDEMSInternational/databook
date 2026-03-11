test_that("test_EDS_returns_NA_when_unsupported", {
  observed <- c(1, 0, 1, 1, 0)
  predicted <- c(1, 0, 1, 0, 0)
  
  expect_warning(
    EDS(
    x = observed,
    y = predicted,
    frcst.type = "categorical",
    obs.type = "categorical"
  ), "EDS not supported for this forecast/observation combination. Returning NA.")
  
})

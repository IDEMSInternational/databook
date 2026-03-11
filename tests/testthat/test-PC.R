test_that("test_PC_returns_correct_percent_correct", {
  observed <- c(1, 0, 1, 1, 0)
  predicted <- c(1, 0, 1, 0, 0)
  
  result <- PC(
    x = observed,
    y = predicted,
    frcst.type = "binary",
    obs.type = "binary"
  )
  
  # Expected to be around 0.8
  expect_true(abs(result - 0.8) < 0.01)
})

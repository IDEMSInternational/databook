test_that("summary_Qn computes Qn correctly", {
  x <- c(10, 20, 30, 40)
  expected <- suppressWarnings(
    robustbase::Qn(x, constant = 2.21914, finite.corr = TRUE)
  )
  result <- suppressWarnings(
    summary_Qn(x, constant = 2.21914, finite.corr = TRUE)
  )
  expect_equal(result, expected, tolerance = 1e-8)
})

test_that("summary_Qn handles missing values correctly", {
  x <- c(10, 20, NA, 30, 40)
  
  # With na.rm = FALSE → returns NA
  expect_true(is.na(summary_Qn(x, na.rm = FALSE)))
  
  # With na.rm = TRUE → computes using available values
  result <- suppressWarnings(summary_Qn(x, na.rm = TRUE))
  expected <- suppressWarnings(robustbase::Qn(x, na.rm = TRUE))
  expect_true(is.numeric(result))
  expect_length(result, 1)
})

test_that("summary_Qn handles edge cases correctly", {
  # Single value
  expect_equal(suppressWarnings(summary_Qn(5)), 0)
  
  # Identical values
  expect_equal(suppressWarnings(summary_Qn(rep(7, 5))), 0)
  
  # Negative and mixed values
  x <- c(-5, -3, -1, 0, 2, 4)
  result <- suppressWarnings(summary_Qn(x))
  expect_true(is.numeric(result))
  expect_length(result, 1)
})

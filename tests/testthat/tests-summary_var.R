test_that("summary_var computes variance correctly", {
  x <- c(1, 2, 3, 4, 5)
  
  # unweighted
  expect_equal(summary_var(x, na.rm = TRUE), stats::var(x), tolerance = 1e-8)
  
  # with NAs, na.rm = FALSE should return NA
  x_na <- c(1, 2, NA, 4, 5)
  expect_true(is.na(summary_var(x_na, na.rm = FALSE)))
  
  # with NAs, na.rm = TRUE should match stats::var
  expect_equal(summary_var(x_na, na.rm = TRUE), stats::var(x_na, na.rm = TRUE), tolerance = 1e-8)
})

test_that("summary_var computes weighted variance correctly", {
  x <- c(1, 2, 3, 4, 5)
  w <- c(1, 1, 1, 1, 2)
  
  # manual weighted variance (same method Hmisc uses)
  w_mean <- sum(x * w) / sum(w)
  expected_wvar <- sum(w * (x - w_mean)^2) / (sum(w) - 1)
  
  expect_equal(summary_var(x, weights = w, na.rm = TRUE), expected_wvar, tolerance = 1e-8)
})

test_that("summary_var returns NA for empty or all-NA input", {
  expect_true(is.na(summary_var(numeric(0), na.rm = TRUE)))
  expect_true(is.na(summary_var(c(NA, NA, NA), na.rm = TRUE)))
})

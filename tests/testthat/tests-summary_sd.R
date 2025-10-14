test_that("summary_sd computes standard deviation correctly", {
  x <- c(1, 2, 3, 4, 5)
  
  # unweighted
  expect_equal(summary_sd(x, na.rm = TRUE), stats::sd(x), tolerance = 1e-8)
  
  # with NAs, na.rm = FALSE should return NA
  x_na <- c(1, 2, NA, 4, 5)
  expect_true(is.na(summary_sd(x_na, na.rm = FALSE)))
  
  # with NAs, na.rm = TRUE should match stats::sd
  expect_equal(summary_sd(x_na, na.rm = TRUE), stats::sd(x_na, na.rm = TRUE), tolerance = 1e-8)
})

test_that("summary_sd computes weighted standard deviation correctly", {
  x <- c(1, 2, 3, 4, 5)
  w <- c(1, 1, 1, 1, 2)
  
  # manually compute weighted variance/SD
  w_mean <- sum(x * w) / sum(w)
  w_var <- sum(w * (x - w_mean)^2) / (sum(w) - 1)
  expected_wsd <- sqrt(w_var)
  
  expect_equal(summary_sd(x, weights = w, na.rm = TRUE), expected_wsd, tolerance = 1e-8)
})

test_that("summary_sd returns NA for empty or all-NA input", {
  expect_true(is.na(summary_sd(numeric(0), na.rm = TRUE)))
  expect_true(is.na(summary_sd(c(NA, NA, NA), na.rm = TRUE)))
})

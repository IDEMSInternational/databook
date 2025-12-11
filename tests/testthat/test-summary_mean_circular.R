# test-summary_mean_circular.R
test_that("summary_mean_circular computes correct mean for simple circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  # Simple example: circular angles (in radians)
  x <- circular(c(0, pi/2, pi, 3*pi/2))
  result <- summary_mean_circular(x)
  expected <- circular::mean.circular(x)[[1]]
  expect_equal(result, expected)
})

test_that("summary_mean_circular handles NA values correctly", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(0, pi/2, NA, pi))
  
  # When na.rm = FALSE, NA should propagate
  expect_true(is.na(summary_mean_circular(x, na.rm = FALSE)))
  
  # When na.rm = TRUE, should compute mean of non-NA values
  result <- summary_mean_circular(x, na.rm = TRUE)
  expected <- circular::mean.circular(x, na.rm = TRUE)[[1]]
  expect_equal(result, expected)
})

test_that("summary_mean_circular returns NA if run_na_check signals NA", {
  mock_run_na_check <- function(x, na.rm, na_type, ...) NA
  with_mocked_bindings(
    run_na_check = mock_run_na_check,
    {
      x <- circular::circular(c(0, pi/4, pi/2))
      expect_true(is.na(summary_mean_circular(x)))
    }
  )
})

test_that("summary_mean_circular passes control.circular arguments properly", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(0, pi/2, pi))
  control <- list(units = "degrees")
  result <- summary_mean_circular(x, control.circular = control)
  expect_true(is.numeric(result))
})

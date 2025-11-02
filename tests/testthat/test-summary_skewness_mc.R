options(mc_doScale_quiet = TRUE)

test_that("summary_skewness_mc computes correct medcouple skewness for numeric data", {
  x <- c(1, 2, 3, 4, 5)
  
  expected <- robustbase::mc(x, na.rm = TRUE)
  result <- summary_skewness_mc(x, na.rm = TRUE)
  
  expect_equal(result, expected)
  expect_type(result, "double")
})

test_that("summary_skewness_mc handles NA values correctly", {
  x <- c(1, 2, NA, 4, 5)
  
  # Should return NA when na.rm = FALSE
  expect_true(is.na(summary_skewness_mc(x, na.rm = FALSE)))
  
  # Should work properly when na.rm = TRUE
  result <- summary_skewness_mc(x, na.rm = TRUE)
  expected <- robustbase::mc(x, na.rm = TRUE)
  expect_equal(result, expected)
})

test_that("summary_skewness_mc handles symmetric data properly", {
  # A symmetric vector should yield approximately 0 skewness
  x <- c(-3, -2, -1, 0, 1, 2, 3)
  result <- summary_skewness_mc(x)
  expect_true(abs(result) < 1e-6)
})

test_that("summary_skewness_mc returns NA if run_na_check returns NA", {
  mock_run_na_check <- function(...) NA
  
  with_mocked_bindings(
    run_na_check = mock_run_na_check,
    {
      x <- 1:10
      expect_true(is.na(summary_skewness_mc(x)))
    }
  )
})

test_that("summary_skewness_mc handles small vectors gracefully", {
  x <- c(1, 2)
  result <- summary_skewness_mc(x, na.rm = TRUE)
  expect_true(is.numeric(result) || is.na(result))
})

test_that("summary_skewness_mc returns numeric output for random input", {
  set.seed(123)
  x <- rnorm(100)
  result <- summary_skewness_mc(x, na.rm = TRUE)
  expect_type(result, "double")
  expect_length(result, 1)
})

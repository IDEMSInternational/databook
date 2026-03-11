options(mc_doScale_quiet = TRUE)

test_that("summary_outlier_limit computes correct upper limit (without skewness)", {
  x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
  quant <- unname(stats::quantile(x, c(0.25, 0.75)))
  Q1 <- quant[1]
  Q3 <- quant[2]
  IQR <- Q3 - Q1
  expected <- Q3 + 1.5 * IQR
  
  result <- summary_outlier_limit(x, coef = 1.5, bupperlimit = TRUE, bskewedcalc = FALSE)
  expect_equal(result, expected)
  expect_type(result, "double")
})

test_that("summary_outlier_limit computes correct lower limit (without skewness)", {
  x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
  quant <- unname(stats::quantile(x, c(0.25, 0.75)))
  Q1 <- quant[1]
  Q3 <- quant[2]
  IQR <- Q3 - Q1
  expected <- Q1 - 1.5 * IQR
  
  result <- summary_outlier_limit(x, coef = 1.5, bupperlimit = FALSE, bskewedcalc = FALSE)
  expect_equal(result, expected)
  expect_type(result, "double")
})

test_that("summary_outlier_limit respects omit parameter correctly", {
  x <- c(-2, -1, 0, 1, 2, 3, 4, 5)
  result <- summary_outlier_limit(x, omit = TRUE, value = 0)
  expected <- summary_outlier_limit(x[x > 0])
  expect_equal(result, expected)
})

test_that("summary_outlier_limit includes skewness when bskewedcalc = TRUE", {
  x <- c(1, 2, 3, 4, 100)
  quant <- unname(stats::quantile(x, c(0.25, 0.75)))
  Q1 <- quant[1]
  Q3 <- quant[2]
  IQR <- Q3 - Q1
  MC <- robustbase::mc(x, na.rm = TRUE)
  expected <- Q3 + 1.5 * exp(4 * MC) * IQR
  
  result <- summary_outlier_limit(x, coef = 1.5, bupperlimit = TRUE, bskewedcalc = TRUE)
  expect_equal(result, expected)
})

test_that("summary_outlier_limit returns NA when run_na_check returns NA", {
  mock_run_na_check <- function(...) NA
  
  with_mocked_bindings(
    run_na_check = mock_run_na_check,
    {
      x <- 1:10
      expect_true(is.na(summary_outlier_limit(x)))
    }
  )
})

test_that("summary_outlier_limit returns numeric output type", {
  x <- rnorm(100)
  result <- summary_outlier_limit(x)
  expect_type(result, "double")
  expect_length(result, 1)
})

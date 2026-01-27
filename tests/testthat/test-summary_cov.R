test_that("summary_cov computes covariance correctly for numeric vectors", {
  x <- c(1, 2, 3, 4, 5)
  y <- c(2, 4, 6, 8, 10)
  
  # Explicitly provide single values for method and use to avoid length > 1 error
  result <- suppressWarnings(summary_cov(x, y, method = "pearson", use = "everything"))
  expected <- suppressWarnings(stats::cov(x, y, method = "pearson", use = "everything"))
  expect_equal(result, expected)
})

test_that("summary_cov handles missing values when na.rm = TRUE", {
  x <- c(1, 2, NA, 4, 5)
  y <- c(2, 4, 6, 8, 10)
  
  result <- suppressWarnings(summary_cov(x, y, na.rm = TRUE, method = "pearson", use = "complete.obs"))
  expected <- suppressWarnings(stats::cov(x, y, use = "complete.obs", method = "pearson"))
  expect_equal(result, expected)
})

# test_that("summary_cov returns NA when run_na_check indicates missingness", {
#   x <- c(1, 2, 3)
#   y <- c(4, 5, 6)
#   
#   mock_run_na_check <- function(...) NA
#   
#   result <- suppressWarnings(
#     with_mocked_bindings(
#       `databook::run_na_check` = mock_run_na_check,
#       summary_cov(x, y, method = "pearson", use = "everything")
#     )
#   )
#   
#   expect_true(is.na(result))
# })

test_that("summary_cov computes weighted covariance correctly", {
  x <- c(1, 2, 3)
  y <- c(2, 4, 6)
  weights <- c(0.2, 0.3, 0.5)
  
  result <- suppressWarnings(summary_cov(x, y, weights = weights, method = "pearson", use = "everything"))
  
  expected <- (sum(weights * x * y) / sum(weights)) - 
    (Weighted.Desc.Stat::w.mean(x, mu = weights) * 
       Weighted.Desc.Stat::w.mean(y, mu = weights))
  
  expect_equal(result, expected)
})

test_that("summary_cov throws error if weights and x lengths differ", {
  x <- c(1, 2, 3)
  y <- c(4, 5, 6)
  weights <- c(0.5, 0.5)  # wrong length
  
  expect_error(suppressWarnings(summary_cov(x, y, weights = weights)))
})

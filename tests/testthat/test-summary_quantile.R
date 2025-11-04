# tests/testthat/test-summary_quantile.R

test_that("summary_quantile computes correct numeric quantiles", {
  x <- 1:9
  expect_equal(summary_quantile(x, probs = 0.5), 5)
  expect_equal(summary_quantile(x, probs = 0.25), 3)
  expect_equal(summary_quantile(x, probs = 0.75), 7)
})

test_that("summary_quantile removes NAs correctly when na.rm = TRUE", {
  x <- c(1, 2, NA, 4, 5)
  expect_equal(summary_quantile(x, na.rm = TRUE, probs = 0.5), 3)
})

test_that("summary_quantile returns NA when na.rm = FALSE and NAs present", {
  x <- c(1, 2, NA, 4, 5)
  expect_true(is.na(summary_quantile(x, na.rm = FALSE, probs = 0.5)))
})

test_that("summary_quantile handles ordered factors correctly", {
  x <- ordered(c("low", "medium", "high"), levels = c("low", "medium", "high"))
  result <- summary_quantile(x, probs = 0.5)
  expect_equal(as.character(result), "medium")
  expect_s3_class(result, "ordered")
})

test_that("summary_quantile handles Date objects correctly", {
  x <- as.Date(c("2024-01-01", "2024-01-03", "2024-01-05", "2024-01-07"))
  expect_equal(summary_quantile(x, probs = 0.25), as.Date("2024-01-01"))
  expect_equal(summary_quantile(x, probs = 0.75), as.Date("2024-01-05"))
})

test_that("summary_quantile computes weighted quantiles correctly", {
  x <- c(1, 2, 10)
  w <- c(1, 1, 8)
  expect_equal(
    summary_quantile(x, weights = w, probs = 0.5, na.rm = TRUE),
    Hmisc::wtd.quantile(x, weights = w, probs = 0.5, na.rm = TRUE)
  )
})

test_that("summary_quantile returns NA if run_na_check returns NA", {
  with_mocked_bindings(
    run_na_check = function(...) NA,
    expect_true(is.na(summary_quantile(c(1, 2, 3), probs = 0.5)))
  )
})

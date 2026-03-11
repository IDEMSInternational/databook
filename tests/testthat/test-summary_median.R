# tests/testthat/test-summary_median.R

test_that("summary_median computes correct median for numeric data", {
  x <- c(1, 3, 5, 7, 9)
  expect_equal(summary_median(x), 5)
})

test_that("summary_median removes NAs correctly when na.rm = TRUE", {
  x <- c(2, NA, 8, 4)
  expect_equal(summary_median(x, na.rm = TRUE), 4)
})

test_that("summary_median returns NA when na.rm = FALSE and NAs present", {
  x <- c(1, 2, NA, 3)
  expect_true(is.na(summary_median(x, na.rm = FALSE)))
})

test_that("summary_median handles ordered factors correctly", {
  x <- ordered(c("low", "medium", "high"), levels = c("low", "medium", "high"))
  result <- summary_median(x)
  expect_equal(as.character(result), "medium")
  expect_s3_class(result, "ordered")
})

test_that("summary_median handles Date objects correctly", {
  x <- as.Date(c("2024-01-01", "2024-01-03", "2024-01-05"))
  expect_equal(summary_median(x), as.Date("2024-01-03"))
})

test_that("summary_median computes weighted median correctly", {
  x <- c(1, 2, 10)
  w <- c(1, 1, 8)
  expect_equal(
    summary_median(x, weights = w, na.rm = TRUE),
    Hmisc::wtd.quantile(x, weights = w, probs = 0.5, na.rm = TRUE)
  )
})

test_that("summary_median returns NA if run_na_check returns NA", {
  with_mocked_bindings(
    run_na_check = function(...) NA,
    expect_true(is.na(summary_median(c(1, 2, 3))))
  )
})

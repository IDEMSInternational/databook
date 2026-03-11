test_that("percentile functions compute correct quantiles", {
  x <- 1:100
  
  expect_equal(p10(x), quantile(x, 0.1, names = FALSE))
  expect_equal(p20(x), quantile(x, 0.2, names = FALSE))
  expect_equal(p25(x), quantile(x, 0.25, names = FALSE))
  expect_equal(p30(x), quantile(x, 0.3, names = FALSE))
  expect_equal(p33(x), quantile(x, 0.33, names = FALSE))
  expect_equal(p40(x), quantile(x, 0.4, names = FALSE))
  expect_equal(p60(x), quantile(x, 0.6, names = FALSE))
  expect_equal(p67(x), quantile(x, 0.67, names = FALSE))
  expect_equal(p70(x), quantile(x, 0.7, names = FALSE))
  expect_equal(p75(x), quantile(x, 0.75, names = FALSE))
  expect_equal(p80(x), quantile(x, 0.8, names = FALSE))
  expect_equal(p90(x), quantile(x, 0.9, names = FALSE))
})

test_that("percentile functions handle missing values correctly", {
  x <- c(1:10, NA, NA)
  
  expect_true(is.na(p10(x, na.rm = FALSE)))
  expect_equal(p10(x, na.rm = TRUE), quantile(1:10, 0.1, names = FALSE))
  
  expect_equal(p20(x, na.rm = TRUE), quantile(1:10, 0.2, names = FALSE))
  expect_equal(p75(x, na.rm = TRUE), quantile(1:10, 0.75, names = FALSE))
  expect_equal(p90(x, na.rm = TRUE), quantile(1:10, 0.9, names = FALSE))
})

test_that("percentile functions handle constant and empty vectors gracefully", {
  expect_equal(p10(rep(5, 10)), 5)
  expect_equal(p90(rep(5, 10)), 5)
  
  expect_true(is.na(p10(numeric(0))))
  expect_true(is.na(p20(numeric(0))))
})

test_that("percentile functions respect weights if supported", {
  skip_if_not(exists("summary_quantile"), "summary_quantile not defined")
  
  x <- c(10, 20, 30, 40)
  w <- c(1, 2, 3, 4)
  
  expect_silent(p10(x, weights = w))
  expect_silent(p20(x, weights = w))
  expect_silent(p25(x, weights = w))
  expect_silent(p30(x, weights = w))
  expect_silent(p33(x, weights = w))
  expect_silent(p40(x, weights = w))
  expect_silent(p60(x, weights = w))
  expect_silent(p67(x, weights = w))
  expect_silent(p70(x, weights = w))
  expect_silent(p75(x, weights = w))
  expect_silent(p80(x, weights = w))
  expect_silent(p90(x, weights = w))
})

test_that("percentile functions handle na_max_prop parameter gracefully", {
  x <- c(1:10, NA, NA, NA, NA, NA)
  
  # Should return NA if NA proportion exceeds allowed limit
  expect_true(is.na(p10(x, na_max_prop = 0.1)))
  
  # Should compute normally if within allowed limit
  expect_equal(p10(x, na_max_prop = 0.6, na.rm = TRUE), quantile(1:10, 0.1, names = FALSE))
})

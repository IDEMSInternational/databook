# test-summary_Sn.R

test_that("summary_Sn computes correct Sn for numeric vector", {
  x <- c(1, 2, 3, 4, 5)
  result <- suppressWarnings(summary_Sn(x))
  expected <- suppressWarnings(robustbase::Qn(x, constant = 1.1926, finite.corr = TRUE))
  expect_equal(result, expected)
})

test_that("summary_Sn removes NAs if na.rm = TRUE", {
  x <- c(1, 2, NA, 4, 5)
  result <- suppressWarnings(summary_Sn(x, na.rm = TRUE))
  expected <- suppressWarnings(robustbase::Qn(c(1, 2, 4, 5), constant = 1.1926, finite.corr = TRUE))
  expect_equal(result, expected)
})

test_that("summary_Sn respects constant and finite.corr arguments", {
  x <- c(2, 4, 6, 8, 10)
  result1 <- suppressWarnings(summary_Sn(x, constant = 1))
  result2 <- suppressWarnings(summary_Sn(x, constant = 2))
  expect_false(result1 == result2)
})

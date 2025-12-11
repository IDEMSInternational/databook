# test-rmse.R
test_that("rmse computes correct root mean square error", {
  x <- c(1, 2, 3, 4, 5)
  y <- c(1.1, 1.9, 3.2, 3.8, 5.1)
  
  result <- rmse(x, y)
  expected <- sqrt(mean((x - y)^2))
  
  expect_equal(result, expected)
})

test_that("rmse handles NA values correctly", {
  x <- c(1, 2, NA, 4, 5)
  y <- c(1.1, 2.2, 3.1, 3.9, 5.2)
  
  # When na.rm = FALSE, should return NA
  expect_true(is.na(rmse(x, y, na.rm = FALSE)))
  
  # When na.rm = TRUE, should ignore NAs
  result <- rmse(x, y, na.rm = TRUE)
  expected <- sqrt(mean((x[!is.na(x)] - y[!is.na(x)])^2))
  expect_equal(result, expected)
})

test_that("rmse returns NA when all values are missing", {
  x <- c(NA, NA, NA)
  y <- c(NA, NA, NA)
  expect_true(is.na(rmse(x, y)))
})

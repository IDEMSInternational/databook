test_that("rd returns correct value for perfect agreement", {
  x <- c(10, 20, 30, 40)
  y <- c(10, 20, 30, 40)
  
  result <- rd(x, y)
  expect_equal(result, 1)  # Perfect agreement should yield 1
})

test_that("rd handles disagreement properly", {
  x <- c(10, 20, 30, 40)
  y <- c(12, 18, 33, 37)
  
  result <- rd(x, y)
  expect_true(result < 1 && result > 0)
})

test_that("rd returns NA when all x values are NA", {
  x <- c(NA, NA, NA)
  y <- c(10, 20, 30)
  
  result <- rd(x, y)
  expect_true(is.na(result))
})

test_that("rd returns NA when all y values are NA", {
  x <- c(10, 20, 30)
  y <- c(NA, NA, NA)
  
  result <- rd(x, y)
  expect_true(is.na(result))
})

test_that("rd handles missing values correctly with na.rm = TRUE", {
  x <- c(10, NA, 30, 40)
  y <- c(11, 19, 29, NA)
  
  result <- rd(x, y, na.rm = TRUE)
  expect_false(is.na(result))
})

test_that("rd handles missing values correctly with na.rm = FALSE", {
  x <- c(10, NA, 30, 40)
  y <- c(11, 19, 29, NA)
  
  result <- rd(x, y, na.rm = FALSE)
  expect_true(is.na(result))
})

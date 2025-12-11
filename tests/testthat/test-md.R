test_that("md returns correct value for perfect agreement", {
  x <- c(10, 20, 30, 40)
  y <- c(10, 20, 30, 40)
  
  result <- md(x, y)
  expect_equal(result, 1)  # Perfect match should give 1
})

test_that("md handles partial disagreement correctly", {
  x <- c(10, 20, 30, 40)
  y <- c(12, 18, 33, 37)
  
  result <- md(x, y)
  expect_true(result < 1 && result > 0)  # Between 0 and 1
})

test_that("md returns NA when all x values are NA", {
  x <- c(NA, NA, NA)
  y <- c(10, 20, 30)
  
  result <- md(x, y)
  expect_true(is.na(result))
})

test_that("md returns NA when all y values are NA", {
  x <- c(10, 20, 30)
  y <- c(NA, NA, NA)
  
  result <- md(x, y)
  expect_true(is.na(result))
})

test_that("md respects j parameter", {
  x <- c(10, 20, 30, 40)
  y <- c(11, 19, 29, 41)
  
  result_j1 <- md(x, y, j = 1)
  result_j2 <- md(x, y, j = 2)
  
  expect_false(is.na(result_j1))
  expect_false(is.na(result_j2))
  expect_true(result_j1 != result_j2)  # Should differ when j changes
})

test_that("md handles missing values when na.rm = TRUE", {
  x <- c(10, NA, 30, 40)
  y <- c(11, 19, 29, NA)
  
  result <- md(x, y, na.rm = TRUE)
  expect_false(is.na(result))
})

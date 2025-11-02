test_that("summary_cor computes Pearson correlation correctly", {
  x <- c(1, 2, 3, 4, 5)
  y <- c(2, 4, 6, 8, 10)
  result <- summary_cor(x, y)
  expect_equal(result, 1, tolerance = 1e-8)
})

test_that("summary_cor handles NA correctly when na.rm = TRUE", {
  x <- c(1, 2, NA, 4)
  y <- c(2, 4, 6, 8)
  result <- summary_cor(x, y, na.rm = TRUE, cor_use = "complete.obs")
  expected <- cor(x, y, use = "complete.obs")
  expect_equal(result, expected, tolerance = 1e-8)
})

test_that("summary_cor computes weighted correlation", {
  x <- c(1, 2, 3)
  y <- c(2, 4.1, 6)
  w <- c(1, 2, 3)
  result <- summary_cor(x, y, weights = w)
  expect_true(is.numeric(result))
  expect_length(result, 1)
})

test_that("summary_cor throws error for mismatched lengths", {
  expect_error(summary_cor(1:3, 1:4))
})

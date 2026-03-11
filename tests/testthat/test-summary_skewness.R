test_that("summary_skewness computes correct skewness for unweighted data", {
  x <- c(1, 2, 3, 4, 5)
  
  # Expected skewness from e1071::skewness
  expected <- e1071::skewness(x, na.rm = TRUE, type = 2)
  
  result <- summary_skewness(x, na.rm = TRUE)
  expect_equal(result, expected)
})

test_that("summary_skewness handles NA values properly", {
  x <- c(1, 2, NA, 4, 5)
  
  # Without na.rm = TRUE, should return NA
  expect_true(is.na(summary_skewness(x, na.rm = FALSE)))
  
  # With na.rm = TRUE, should match e1071::skewness of non-NA values
  expected <- e1071::skewness(x, na.rm = TRUE, type = 2)
  result <- summary_skewness(x, na.rm = TRUE)
  expect_equal(result, expected)
})

test_that("summary_skewness handles weights correctly", {
  x <- c(1, 2, 3, 4, 5)
  w <- c(1, 2, 3, 4, 5)
  
  unweighted <- e1071::skewness(x, na.rm = TRUE, type = 2)
  weighted <- summary_skewness(x, weights = w)
  
  expect_false(is.na(weighted))
  expect_type(weighted, "double")
  expect_true(is.numeric(weighted))
  expect_true(weighted != unweighted)
})

test_that("summary_skewness throws error when weights and x differ in length", {
  x <- 1:5
  w <- c(1, 2, 3)
  expect_error(summary_skewness(x, weights = w), "'x' and 'weights' must have the same length")
})

test_that("summary_skewness handles constant vector correctly", {
  x <- rep(5, 10)
  result <- summary_skewness(x)
  expect_true(is.nan(result) || result == 0) # e1071 may return NaN for constant vectors
})

test_that("summary_skewness respects type argument", {
  x <- c(1, 2, 3, 4, 5)
  s1 <- summary_skewness(x, type = 1)
  s2 <- summary_skewness(x, type = 2)
  expect_false(is.na(s1))
  expect_false(is.na(s2))
  expect_true(is.numeric(s1))
  expect_true(is.numeric(s2))
})

test_that("summary_skewness returns NA if run_na_check returns NA", {
  mock_run_na_check <- function(...) NA
  with_mocked_bindings(
    run_na_check = mock_run_na_check,
    {
      x <- 1:10
      expect_true(is.na(summary_skewness(x)))
    }
  )
})

test_that("me correctly computes mean error for valid numeric vectors", {
  # Sample observed and simulated data
  x <- c(10, 12, 14, 16, 18)  # observed
  y <- c(11, 13, 13, 17, 19)  # simulated
  
  # Compute using your function
  result <- me(x, y)
  
  # Compute expected manually using hydroGOF::me
  expected <- hydroGOF::me(sim = y, obs = x)
  
  # Compare results
  expect_equal(result, expected)
})

test_that("me handles missing values correctly", {
  x <- c(10, 12, NA, 16, 18)
  y <- c(11, 13, 13, 17, 19)
  
  # When na.rm = FALSE → should return NA
  result <- me(x, y, na.rm = FALSE)
  expect_true(is.na(result))
  
  # When na.rm = TRUE → should remove NAs and calculate correctly
  result <- me(x, y, na.rm = TRUE)
  expected <- hydroGOF::me(sim = y, obs = x, na.rm = TRUE)
  expect_equal(result, expected)
})

test_that("me returns NA for all-NA or empty input vectors", {
  # All-NA observed
  x <- c(NA, NA, NA)
  y <- c(1, 2, 3)
  result <- me(x, y)
  expect_true(is.na(result))
  
  # All-NA simulated
  x <- c(1, 2, 3)
  y <- c(NA, NA, NA)
  result <- me(x, y)
  expect_true(is.na(result))
  
  # Empty vectors
  result <- me(c(), c())
  expect_true(is.na(result) || length(result) == 0)
})

test_that("me fails gracefully with mismatched vector lengths", {
  x <- c(10, 12, 14)
  y <- c(11, 13)  # shorter vector
  
  # Should throw an error due to unequal lengths
  expect_error(me(x, y))
})

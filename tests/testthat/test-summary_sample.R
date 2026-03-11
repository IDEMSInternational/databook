test_that("summary_sample returns a single randomly sampled element", {
  x <- c(1, 2, 3, 4, 5)
  
  # Test that it returns one element from x
  result <- summary_sample(x)
  expect_true(result %in% x)
  expect_length(result, 1)
})

test_that("summary_sample works with a fixed seed for reproducibility", {
  x <- c("a", "b", "c", "d", "e")
  
  # With the same seed, results should be identical
  result1 <- summary_sample(x, seed = 123)
  result2 <- summary_sample(x, seed = 123)
  expect_identical(result1, result2)
  
  # With a different seed, results should differ
  result3 <- summary_sample(x, seed = 456)
  expect_false(identical(result1, result3))
})

test_that("summary_sample works with replacement", {
  x <- c(10, 20, 30)
  result <- summary_sample(x, replace = TRUE, seed = 1)
  expect_true(result %in% x)
})

test_that("summary_sample handles edge cases", {
  # Single element vector
  expect_equal(summary_sample(c(100), seed = 1), 100)
  
  # Empty vector returns NA (and warns)
  expect_warning(
    result <- summary_sample(c()),
    "Cannot sample from an empty vector"
  )
  expect_true(is.na(result))
})


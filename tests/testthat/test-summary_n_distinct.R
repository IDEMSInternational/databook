test_that("summary_n_distinct correctly counts distinct elements", {
  # Basic test
  x <- c(1, 2, 2, 3, 3, 3)
  expect_equal(summary_n_distinct(x), 3)
  
  # With NA values, na.rm = FALSE (should count NA as distinct)
  y <- c(1, 2, NA, NA)
  expect_equal(summary_n_distinct(y, na.rm = FALSE), 3)
  
  # With NA values, na.rm = TRUE (should ignore NA)
  expect_equal(summary_n_distinct(y, na.rm = TRUE), 2)
  
  # Character vector
  z <- c("apple", "banana", "apple", "cherry")
  expect_equal(summary_n_distinct(z), 3)
  
  # Logical vector
  l <- c(TRUE, FALSE, TRUE)
  expect_equal(summary_n_distinct(l), 2)
  
  # Empty vector
  expect_equal(summary_n_distinct(c()), 0)
  
  # All elements are the same
  expect_equal(summary_n_distinct(rep(5, 10)), 1)
})

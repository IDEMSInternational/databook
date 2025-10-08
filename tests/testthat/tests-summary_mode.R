test_that("summary_mode works with numeric vectors", {
  x <- c(1, 2, 2, 3, 3, 3, 4)
  expect_equal(summary_mode(x), 3)
})

test_that("summary_mode works with character vectors", {
  x <- c("apple", "banana", "apple", "cherry")
  expect_equal(summary_mode(x), "apple")
})

test_that("summary_mode works with factors", {
  x <- factor(c("red", "blue", "red", "green"))
  expect_equal(summary_mode(x), "red") # coerced to character
})

test_that("summary_mode returns first mode when tie occurs", {
  x <- c(1, 1, 2, 2)
  expect_equal(summary_mode(x), 1) # first mode wins
})

test_that("summary_mode returns NA for NULL input", {
  expect_true(is.na(summary_mode(NULL)))
})

test_that("summary_mode ignores NA values when possible", {
  x <- c(1, 2, 2, NA, NA, 2)
  expect_equal(summary_mode(x), 2)
})

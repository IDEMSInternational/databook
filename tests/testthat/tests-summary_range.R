test_that("summary_range correctly computes range of numeric vector", {
  x <- c(1, 5, 9, 3)
  expect_equal(summary_range(x), 8)  # 9 - 1 = 8
})

test_that("summary_range returns 0 when all elements are equal", {
  x <- c(4, 4, 4, 4)
  expect_equal(summary_range(x), 0)
})

test_that("summary_range handles negative numbers correctly", {
  x <- c(-5, -2, -10, 0)
  expect_equal(summary_range(x), 10)  # 0 - (-10) = 10
})

test_that("summary_range ignores NA when na.rm = TRUE", {
  x <- c(1, NA, 4, 2)
  expect_equal(summary_range(x, na.rm = TRUE), 3)  # 4 - 1 = 3
})

test_that("summary_range returns NA when na.rm = FALSE and NA present", {
  x <- c(1, NA, 3)
  result <- tryCatch(summary_range(x, na.rm = FALSE), error = function(e) NA)
  expect_true(is.na(result))
})

test_that("summary_range returns NA for empty vector", {
  x <- numeric(0)
  result <- tryCatch(summary_range(x, na.rm = TRUE), error = function(e) NA)
  expect_true(is.na(result))
})

test_that("summary_range gracefully handles run_na_check returning logical", {
  # Mock behavior: run_na_check returns TRUE/FALSE instead of NA
  mock_run_na_check <- function(...) TRUE
  unlockBinding("run_na_check", asNamespace("base")) # if needed, only in test env
  assign("run_na_check", mock_run_na_check, envir = globalenv())
  
  x <- c(1, 2, 3)
  expect_equal(summary_range(x), 2)
})

test_that("summary_range throws an error or returns NA for non-numeric input", {
  x <- c("a", "b", "c")
  expect_error(summary_range(x), "non-numeric", fixed = FALSE)
})

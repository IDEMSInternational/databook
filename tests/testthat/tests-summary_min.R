test_that("summary_min computes minimum correctly", {
  x <- c(5, 3, 9, 1, 8)
  expect_equal(summary_min(x), 1)
})

test_that("summary_min removes NAs when na.rm = TRUE", {
  x <- c(5, NA, 3, 9, 1, NA)
  expect_equal(summary_min(x, na.rm = TRUE), 1)
})

test_that("summary_min returns NA when na.rm = FALSE and NA present", {
  x <- c(2, NA, 4)
  expect_true(is.na(summary_min(x, na.rm = FALSE)))
})

test_that("summary_min returns NA when run_na_check fails", {
  local_mocked_bindings(
    run_na_check = function(...) NA
  )
  x <- c(1, 2, 3)
  expect_true(is.na(summary_min(x)))
})

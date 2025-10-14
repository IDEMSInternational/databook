test_that("summary_max computes maximum correctly", {
  x <- c(1, 5, 3, 2, 4)
  expect_equal(summary_max(x), 5)
})

test_that("summary_max handles NA values correctly", {
  x <- c(1, 5, NA, 3)
  
  # with na.rm = FALSE should return NA
  expect_true(is.na(summary_max(x, na.rm = FALSE)))
  
  # with na.rm = TRUE should ignore NA
  expect_equal(summary_max(x, na.rm = TRUE), 5)
})

test_that("summary_max returns NA for empty or all-NA input", {
  expect_true(is.na(summary_max(numeric(0), na.rm = TRUE)))
  expect_true(is.na(summary_max(c(NA, NA), na.rm = TRUE)))
})

test_that("summary_max respects run_na_check returning NA", {
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  x <- c(1, 2, 3)
  expect_true(is.na(summary_max(x)))
})

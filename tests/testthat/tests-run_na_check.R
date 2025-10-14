# File: tests/testthat/test-run_na_check.R

test_that("run_na_check returns NA for empty vector", {
  result <- run_na_check(numeric(0), na.rm = TRUE, na_type = "")
  expect_true(is.na(result))
})

test_that("run_na_check returns NA if all values are NA and na.rm = TRUE", {
  result <- run_na_check(c(NA, NA), na.rm = TRUE, na_type = "")
  expect_true(is.na(result))
})

test_that("run_na_check returns 1 for non-NA values when na.rm = FALSE", {
  result <- run_na_check(c(1, 2, 3), na.rm = FALSE, na_type = "")
  expect_equal(result, 1)
})

test_that("run_na_check returns NA if all NA checks fail", {
  # Here we mock na_check to always return FALSE
  local_mocked_bindings(
    na_check = function(x, na_type, ...) FALSE
  )
  
  result <- run_na_check(c(1, 2, 3), na.rm = TRUE, na_type = "dummy")
  expect_true(is.na(result))
})

test_that("run_na_check returns 1 if at least one NA check passes", {
  # Here we mock na_check to return TRUE for one check
  local_mocked_bindings(
    na_check = function(x, na_type, ...) na_type == "pass"
  )
  
  result <- run_na_check(c(1, 2, 3), na.rm = TRUE, na_type = c("fail", "pass"))
  expect_equal(result, 1)
})

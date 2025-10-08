# File: tests/testthat/test-summary_medianHL_circular.R

test_that("summary_medianHL_circular computes HL median for circular data", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_medianHL_circular(x, method = "HL1")
  
  expect_type(result, "double")
  expect_false(is.na(result))
})

test_that("summary_medianHL_circular supports different HL methods", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(5, 15, 25, 35), units = "degrees")
  res1 <- summary_medianHL_circular(x, method = "HL1")
  res2 <- summary_medianHL_circular(x, method = "HL2")
  res3 <- summary_medianHL_circular(x, method = "HL3")
  
  expect_true(is.numeric(res1))
  expect_true(is.numeric(res2))
  expect_true(is.numeric(res3))
})

test_that("summary_medianHL_circular returns NA if NA present and na.rm = FALSE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_medianHL_circular(x, na.rm = FALSE)
  
  expect_true(is.na(result))
})

test_that("summary_medianHL_circular removes NAs when na.rm = TRUE", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, NA, 30), units = "degrees")
  result <- summary_medianHL_circular(x, na.rm = TRUE, method = "HL1")
  
  expect_true(is.numeric(result))
  expect_false(is.na(result))
})

test_that("summary_medianHL_circular returns NA when run_na_check fails", {
  skip_if_not_installed("circular")
  library(circular)
  
  local_mocked_bindings(
    run_na_check = function(x, na.rm, na_type, ...) NA
  )
  
  x <- circular(c(10, 20, 30), units = "degrees")
  result <- summary_medianHL_circular(x)
  
  expect_true(is.na(result))
})

test_that("summary_medianHL_circular accepts prop argument", {
  skip_if_not_installed("circular")
  library(circular)
  
  x <- circular(c(10, 20, 30, 40), units = "degrees")
  result <- summary_medianHL_circular(x, prop = 0.5, method = "HL1")
  
  expect_true(is.numeric(result))
})

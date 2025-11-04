test_that("R2 returns correct value for perfect linear agreement", {
  x <- c(5, 10, 15, 20)
  y <- c(5, 10, 15, 20)
  
  result <- R2(x, y)
  expect_equal(result, 1)  # Perfect match should yield R² = 1
})

test_that("R2 decreases with increasing deviation between observed and simulated", {
  x <- c(5, 10, 15, 20)
  y <- c(6, 11, 13, 19)
  
  result <- R2(x, y)
  expect_true(result < 1 && result > 0)
})

test_that("R2 returns NA when all observed values are NA", {
  x <- c(NA, NA, NA)
  y <- c(10, 20, 30)
  
  result <- R2(x, y)
  expect_true(is.na(result))
})

test_that("R2 returns NA when all simulated values are NA", {
  x <- c(10, 20, 30)
  y <- c(NA, NA, NA)
  
  result <- R2(x, y)
  expect_true(is.na(result))
})

test_that("R2 handles missing values correctly when na.rm = TRUE", {
  x <- c(10, NA, 30, 40)
  y <- c(11, 19, 29, NA)
  
  result <- R2(x, y, na.rm = TRUE)
  expect_false(is.na(result))
})

test_that("R2 handles missing values correctly when na.rm = FALSE", {
  x <- c(10, NA, 30, 40)
  y <- c(11, 19, 29, NA)
  
  result <- R2(x, y, na.rm = FALSE)
  expect_true(is.na(result))
})

test_that("R2 returns NA when run_na_check explicitly returns NA", {
  if (bindingIsLocked("run_na_check", environment(R2))) {
    skip("Cannot mock run_na_check — binding locked in this environment")
  } else {
    mock_run_na_check <- function(...) NA
    original <- get("run_na_check", envir = environment(R2))
    assign("run_na_check", mock_run_na_check, envir = environment(R2))
    
    result <- R2(c(1, 2, 3), c(1, 2, 3))
    expect_true(is.na(result))
    
    assign("run_na_check", original, envir = environment(R2))
  }
})

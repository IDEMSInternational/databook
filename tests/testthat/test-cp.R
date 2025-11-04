# test-cp.R

test_that("cp lifecycle: compute, handle NA, and respect parameters", {
  x <- c(10, 12, 14, 16, 18)  # observed
  y <- c(11, 13, 13, 17, 19)  # simulated
  
  # --- Normal computation ---
  result <- cp(x, y)
  expected <- hydroGOF::cp(sim = y, obs = x)
  expect_equal(result, expected)
  
  # --- Perfect match should yield high cp ---
  result_perfect <- cp(x, x)
  expect_true(abs(result_perfect - 1) < 1e-10)
  
  # --- Handle NA values ---
  x_na <- c(10, 12, NA, 16, 18)
  y_na <- c(11, 13, 13, 17, 19)
  
  # When na.rm = FALSE → should still compute (hydroGOF auto-handles NA)
  result_na_false <- cp(x_na, y_na, na.rm = FALSE)
  expected_na_false <- hydroGOF::cp(sim = y_na, obs = x_na, na.rm = FALSE)
  expect_equal(result_na_false, expected_na_false)
  
  
  # When na.rm = TRUE → compute correctly
  result_na_true <- cp(x_na, y_na, na.rm = TRUE)
  expected_na_true <- hydroGOF::cp(sim = y_na, obs = x_na, na.rm = TRUE)
  expect_equal(result_na_true, expected_na_true)
  
  # --- Edge case: all NAs ---
  x_all_na <- c(NA, NA, NA)
  y_all_na <- c(NA, NA, NA)
  result_all_na <- cp(x_all_na, y_all_na)
  expect_true(is.na(result_all_na))
  
  # --- Edge case: y has only one unique value ---
  y_constant <- rep(5, 5)
  result_constant_y <- cp(x, y_constant)
  expect_true(is.na(result_constant_y))
  
  # --- Skip mock test if binding locked ---
  if (bindingIsLocked("run_na_check", environment(cp))) {
    skip("Cannot mock run_na_check — binding locked in this environment")
  } else {
    mock_run_na_check <- function(...) NA
    original <- get("run_na_check", envir = environment(cp))
    assign("run_na_check", mock_run_na_check, envir = environment(cp))
    
    result_mock <- cp(x, y)
    expect_true(is.na(result_mock))
    
    assign("run_na_check", original, envir = environment(cp))
  }
})

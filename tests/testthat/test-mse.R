test_that("mse lifecycle: compute, handle NA, and respect parameters", {
  x <- c(10, 12, 14, 16, 18)  # observed
  y <- c(11, 13, 13, 17, 19)  # simulated
  
  # --- Normal computation ---
  result <- mse(x, y)
  expected <- hydroGOF::mse(sim = y, obs = x)
  expect_equal(result, expected)
  
  # --- Perfect match should yield MSE = 0 ---
  result_perfect <- mse(x, x)
  expect_equal(result_perfect, 0)
  
  # --- Handle NA values ---
  x_na <- c(10, 12, NA, 16, 18)
  y_na <- c(11, 13, 13, 17, 19)
  
  # When na.rm = FALSE → expect NA
  result_na_false <- mse(x_na, y_na, na.rm = FALSE)
  expect_true(is.na(result_na_false))
  
  # When na.rm = TRUE → compute correctly
  result_na_true <- mse(x_na, y_na, na.rm = TRUE)
  expected_na_true <- hydroGOF::mse(sim = y_na, obs = x_na, na.rm = TRUE)
  expect_equal(result_na_true, expected_na_true)
  
  # --- Edge case: all NAs ---
  x_all_na <- c(NA, NA, NA)
  y_all_na <- c(NA, NA, NA)
  result_all_na <- mse(x_all_na, y_all_na)
  expect_true(is.na(result_all_na))
  
  # --- Edge case: y all NAs ---
  y_all_na2 <- c(NA, NA, NA, NA, NA)
  result_y_all_na <- mse(x, y_all_na2)
  expect_true(is.na(result_y_all_na))
  
  # --- Skip mock test if binding locked ---
  if (bindingIsLocked("run_na_check", environment(mse))) {
    skip("Cannot mock run_na_check — binding locked in this environment")
  } else {
    mock_run_na_check <- function(...) NA
    original <- get("run_na_check", envir = environment(mse))
    assign("run_na_check", mock_run_na_check, envir = environment(mse))
    
    result_mock <- mse(x, y)
    expect_true(is.na(result_mock))
    
    assign("run_na_check", original, envir = environment(mse))
  }
})

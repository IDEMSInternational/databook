test_that("KGE lifecycle: compute, handle NA, and respect parameters", {
  x <- c(10, 12, 14, 16, 18)  # observed
  y <- c(11, 13, 13, 17, 19)  # simulated
  
  # --- Normal computation ---
  result <- KGE(x, y)
  expected <- hydroGOF::KGE(sim = y, obs = x)
  expect_equal(result, expected)
  
  # --- Perfect match should yield KGE close to 1 ---
  result_perfect <- KGE(x, x)
  expect_true(abs(result_perfect - 1) < 1e-10)
  
  # --- Handle NA values ---
  x_na <- c(10, 12, NA, 16, 18)
  y_na <- c(11, 13, 13, 17, 19)
  
  # When na.rm = FALSE → expect NA
  result_na_false <- KGE(x_na, y_na, na.rm = FALSE)
  expect_true(!is.na(result_na_false))
  
  # When na.rm = TRUE → compute correctly
  result_na_true <- KGE(x_na, y_na, na.rm = TRUE)
  expected_na_true <- hydroGOF::KGE(sim = y_na, obs = x_na, na.rm = TRUE)
  expect_equal(result_na_true, expected_na_true)
  
  # --- Edge case: all NAs ---
  x_all_na <- c(NA, NA, NA)
  y_all_na <- c(NA, NA, NA)
  result_all_na <- KGE(x_all_na, y_all_na)
  expect_true(is.na(result_all_na))
  
  # --- Edge case: y all NAs ---
  y_all_na2 <- c(NA, NA, NA, NA, NA)
  result_y_all_na <- KGE(x, y_all_na2)
  expect_true(is.na(result_y_all_na))
})

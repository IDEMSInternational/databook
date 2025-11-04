test_that("mNSE lifecycle: compute, handle NA, and respect parameters", {
  db <- DataBook$new()
  x <- c(10, 12, 14, 16, 18)  # observed
  y <- c(11, 13, 13, 17, 19)  # simulated
  
  # --- 1️⃣ Normal computation ---
  result <- mNSE(x, y)
  expected <- hydroGOF::mNSE(sim = y, obs = x)
  expect_equal(result, expected)
  
  # --- 2️⃣ Computation with different exponent j ---
  result_j2 <- mNSE(x, y, j = 2)
  expected_j2 <- hydroGOF::mNSE(sim = y, obs = x, j = 2)
  expect_equal(result_j2, expected_j2)
  
  # --- 3️⃣ Handle NA values ---
  x_na <- c(10, 12, NA, 16, 18)
  y_na <- c(11, 13, 13, 17, 19)
  
  # When na.rm = FALSE → expect NA
  result_na_false <- mNSE(x_na, y_na, na.rm = FALSE)
  expect_true(is.na(result_na_false))
  
  # When na.rm = TRUE → compute correctly
  result_na_true <- mNSE(x_na, y_na, na.rm = TRUE)
  expected_na_true <- hydroGOF::mNSE(sim = y_na, obs = x_na, na.rm = TRUE)
  expect_equal(result_na_true, expected_na_true)
  
  # --- 4️⃣ Edge case: all NAs ---
  x_all_na <- c(NA, NA, NA)
  y_all_na <- c(NA, NA, NA)
  result_all_na <- mNSE(x_all_na, y_all_na)
  expect_true(is.na(result_all_na))
})

test_that("d lifecycle: compute, handle NA, and respect parameters", {
  db <- DataBook$new()
  x <- c(10, 12, 14, 16, 18)  # observed
  y <- c(11, 13, 13, 17, 19)  # simulated
  
  # --- 1️⃣ Normal computation ---
  result <- d(x, y)
  expected <- hydroGOF::d(sim = y, obs = x)
  expect_equal(result, expected)
  
  # --- 2️⃣ Handle NA values ---
  x_na <- c(10, 12, NA, 16, 18)
  y_na <- c(11, 13, 13, 17, 19)
  
  # When na.rm = FALSE → expect NA
  result_na_false <- d(x_na, y_na, na.rm = FALSE)
  expect_true(is.na(result_na_false))
  
  # When na.rm = TRUE → compute correctly
  result_na_true <- d(x_na, y_na, na.rm = TRUE)
  expected_na_true <- hydroGOF::d(sim = y_na, obs = x_na, na.rm = TRUE)
  expect_equal(result_na_true, expected_na_true)
  
  # --- 3️⃣ Edge case: all NAs ---
  x_all_na <- c(NA, NA, NA)
  y_all_na <- c(NA, NA, NA)
  result_all_na <- d(x_all_na, y_all_na)
  expect_true(is.na(result_all_na))
  
  # --- 4️⃣ Skip mock test if locked binding (safe for CRAN/CI) ---
  if (bindingIsLocked("run_na_check", environment(d))) {
    skip("Cannot mock run_na_check — binding locked in this environment")
  } else {
    mock_run_na_check <- function(...) NA
    original <- get("run_na_check", envir = environment(d))
    assign("run_na_check", mock_run_na_check, envir = environment(d))
    
    result_mock <- d(x, y)
    expect_true(is.na(result_mock))
    
    assign("run_na_check", original, envir = environment(d))
  }
})

test_that("na_check: handles empty na_type (no checks) -> TRUE", {
  x <- c(1, 2, NA)
  expect_true(na_check(x, na_type = character()))
})

test_that("na_check: 'n' / \"'n'\" works (max missing count)", {
  x <- c(1, NA, 2, NA, NA, 3, 4, NA)  # 4 NAs
  expect_true(na_check(x, na_type = "n",   na_max_n = 4))
  expect_false(na_check(x, na_type = "n",  na_max_n = 3))
  expect_true(na_check(x, na_type = "'n'", na_max_n = 4))  # quoted variant
})

test_that("na_check: 'prop' / \"'prop'\" works (max missing proportion, percent)", {
  x <- c(1, NA, 2, NA, NA, 3, 4, NA)  # 4 given, 4 missing, so max missing proportion is 100%
  # (I think this is confusing. Shouldn't it be 50%?)
  expect_false(na_check(x, na_type = "prop",   na_max_prop = 20))
  expect_false(na_check(x, na_type = "prop",  na_max_prop = 40))
  expect_true(na_check(x, na_type = "'prop'", na_max_prop = 100))  # quoted
})

test_that("na_check: 'n_non_miss' / \"'n_non_miss'\" works (min non-missing count)", {
  x <- c(1, NA, 2, NA, NA, 3, 4, NA)  # 4 non-missing
  expect_true(na_check(x, na_type = "n_non_miss",   na_min_n = 4))
  expect_true(na_check(x, na_type = "n_non_miss",   na_min_n = 3))
  expect_false(na_check(x, na_type = "n_non_miss",  na_min_n = 5))
  expect_true(na_check(x, na_type = "'n_non_miss'", na_min_n = 4))  # quoted
})

test_that("na_check: 'con' / \"'con'\" works (max consecutive NAs)", {
  x <- c(1, NA, 2, NA, NA, 3, 4, NA)  # max run of NAs is 2 (at positions 4-5)
  expect_true(na_check(x, na_type = "con",   na_consecutive_n = 2))
  expect_false(na_check(x, na_type = "con",  na_consecutive_n = 1))
  expect_true(na_check(x, na_type = "'con'", na_consecutive_n = 2))  # quoted
})

test_that("na_check: 'FUN' / \"'FUN'\" works (custom predicate)", {
  x <- c(1, NA, 2, 10, NA)
  # Example: mean > 3 (NA removed)
  expect_true(na_check(x, na_type = "FUN",   na_FUN = function(z, ...) mean(z, na.rm = TRUE) > 3))
  expect_false(na_check(x, na_type = "FUN",  na_FUN = function(z, ...) mean(z, na.rm = TRUE) > 10))
  expect_true(na_check(x, na_type = "'FUN'", na_FUN = function(z, ...) mean(z, na.rm = TRUE) > 3))  # quoted
})

test_that("na_check: combined conditions short-circuit correctly", {
  x <- c(1, NA, 2, NA, NA, 3, 4, NA)  # 4 NAs, prop = 50%, max run = 2
  # All pass
  expect_true(
    na_check(
      x,
      na_type = c("n", "prop", "con"),
      na_max_n = 4, na_max_prop = 100, na_consecutive_n = 2
    )
  )
  # First fails (n=3), should return FALSE (short-circuit)
  expect_false(
    na_check(
      x,
      na_type = c("n", "prop", "con"),
      na_max_n = 3, na_max_prop = 50, na_consecutive_n = 2
    )
  )
  # First passes, second fails
  expect_false(
    na_check(
      x,
      na_type = c("n", "prop", "con"),
      na_max_n = 4, na_max_prop = 40, na_consecutive_n = 2
    )
  )
})

test_that("na_check: invalid type errors clearly", {
  x <- c(1, NA, 2)
  expect_error(
    na_check(x, na_type = "not_a_type"),
    regexp = "Invalid na_type"
  )
})

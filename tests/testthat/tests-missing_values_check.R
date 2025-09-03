test_that("missing_values_check always returns FALSE", {
  # Different types of inputs
  expect_false(missing_values_check(c(1, 2, 3)))
  expect_false(missing_values_check(c(NA, 2, 3)))
  expect_false(missing_values_check(NULL))
  expect_false(missing_values_check(character()))
  expect_false(missing_values_check(logical()))
  expect_false(missing_values_check(c(TRUE, FALSE, NA)))
})

test_that("check_filter sets missing parameters to defaults and preserves existing", {
  # missing parameters -> defaults applied
  f <- list(parameters = list())
  out <- check_filter(f)
  expect_equal(out$parameters$and_or, "&")
  expect_false(out$parameters$outer_not)
  expect_false(out$parameters$inner_not)

  # existing values preserved
  f2 <- list(parameters = list(and_or = "|", outer_not = TRUE, inner_not = TRUE))
  out2 <- check_filter(f2)
  expect_equal(out2$parameters$and_or, "|")
  expect_true(out2$parameters$outer_not)
  expect_true(out2$parameters$inner_not)
})

test_that("find_df_from_calc_from finds the first matching data name or returns empty string", {
  x <- list(df1 = c("a", "b"), df2 = c("c", "d"))
  expect_equal(find_df_from_calc_from(x, "b"), "df1")
  expect_equal(find_df_from_calc_from(x, "d"), "df2")
  expect_equal(find_df_from_calc_from(x, "z"), "")

  # if multiple data frames contain the column, the first name is returned
  x2 <- list(first = c("x","y"), second = c("y","z"))
  expect_equal(find_df_from_calc_from(x2, "y"), "first")
})

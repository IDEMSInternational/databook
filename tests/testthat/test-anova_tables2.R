test_that("anova_tables2 prints ANOVA table and optional total row", {
  db <- DataBook$new()
  # import iris as a named data frame
  db$import_data(list(iris = iris))

  # capture printed output
  out <- capture.output(db$anova_tables2(data_name = "iris", x_col_names = "Species", y_col_name = "Sepal.Length", total = TRUE))
  txt <- paste(out, collapse = "\n")

  expect_true(grepl("ANOVA of Sepal.Length", txt))
  # when total = TRUE the printed table should include a Total row
  expect_true(grepl("Total", txt))
})

test_that("calculate_summary returns grouped mean (summary_mean)", {
  skip_if_not_installed("instatCalculations")

  db <- DataBook$new()
  db$import_data(list(iris = iris))

  # Request mean of Sepal.Length grouped by Species and return the output
  out <- db$calculate_summary(data_name = "iris",
                              columns_to_summarise = c("Sepal.Length"),
                              summaries = c("summary_mean"),
                              factors = c("Species"),
                              return_output = TRUE)

  # Basic structure checks
  expect_true("Species" %in% names(out))
  mean_col <- names(out)[grepl("^mean", names(out))][1]
  expect_true(!is.na(mean_col) && nzchar(mean_col))

  # numeric check: compare to base R aggregated means
  expected <- tapply(iris$Sepal.Length, iris$Species, mean)
  species <- as.character(out$Species)
  expect_equal(as.numeric(round(out[[mean_col]], 6)), as.numeric(round(unname(expected[species]), 6)))
})

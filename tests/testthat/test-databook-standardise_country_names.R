library(testthat)

test_that("standardise_country_names_errors_when_variables_metadata_is_missing", { # nolint

  df <- data.frame(
    country = c("Kenya", "U.S.A.", "United Kingdom"),
    stringsAsFactors = FALSE
  )

  db <- DataBook$new(
    data_tables = list(test_data = df)
  )

  expect_error(
    db$standardise_country_names(
      data_name = "test_data",
      country_columns = "country"
    ),
    "not found in variables metadata"
  )
})

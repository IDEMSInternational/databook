test_that("frequency_tables prints headers for each x column", {
  db <- DataBook$new()
  db$import_data(list(diamonds = ggplot2::diamonds))

  out <- capture.output(
    suppressWarnings(
      db$frequency_tables(
        data_name = "diamonds",
        x_col_names = c("cut", "clarity"),
        y_col_name = "color",
        store_results = FALSE,
        as_html = FALSE,
        additional_filter = NULL
      )
    )
  )

  expect_true(any(grepl("^cut by color", out)))
  expect_true(any(grepl("^clarity by color", out)))
})

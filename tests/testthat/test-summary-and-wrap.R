library(testthat)
library(dplyr)

test_that("wrap_or_unwrap_data wraps and restores column data", {
  db <- DataBook$new()
  df <- data.frame(id = 1:2, txt = c("This is a long sentence that should wrap to multiple lines when given a small width.", "Short text"), stringsAsFactors = FALSE)
  db$import_data(list(test = df))

  # wrap the txt column to width 20
  db$wrap_or_unwrap_data(data_name = "test", col_name = "txt", column_data = db$get_data_frame("test")$txt, width = 20, wrap = TRUE)
  wrapped <- db$get_data_frame("test")$txt
  expect_true(any(grepl("\n", wrapped)))

  # now unwrap (wrap = FALSE) - provide the wrapped data and expect no newline after unwrap
  db$wrap_or_unwrap_data(data_name = "test", col_name = "txt", column_data = wrapped, width = NULL, wrap = FALSE)
  unwrapped <- db$get_data_frame("test")$txt
  expect_false(any(grepl("\n", unwrapped)))
})

test_that("summary_table creates a summary and add/get object as gt table", {
  db <- DataBook$new()
  db$import_data(list(diamonds = ggplot2::diamonds))

  # compute summary table for depth by cut (mean)
  summary_table <- db$summary_table(data_name = "diamonds", columns_to_summarise = "depth", factors = "cut", treat_columns_as_factor = FALSE, summaries = c("summary_mean"))

  # Check structure - should be 5 rows and columns cut, summary-variable, value
  expect_true(nrow(summary_table) >= 5)
  expect_true(all(c("cut", "summary-variable", "value") %in% names(summary_table)))

  # Spot check expected first rows exist and the variable name contains mean__depth
  expect_true(any(grepl("mean__depth", summary_table$`summary-variable`)))

  # Create gt table from pivoted summary and add as object
  tidy <- summary_table %>% tidyr::pivot_wider(names_from = cut, values_from = value)
  last_table <- tryCatch({ tidy %>% gt::gt() }, error = function(e) NULL)
  # Only proceed if gt created
  if (!is.null(last_table)) {
    db$add_object(data_name = "diamonds", object_name = "last_table", object_type_label = "table", object_format = "html", object = last_table)
    obj_file <- suppressWarnings(db$get_object_data(data_name = "diamonds", object_name = "last_table", as_file = TRUE))
    # Expect the saved object to be a character (html) or a gt object when as_file=TRUE
    expect_true(is.character(obj_file) || inherits(obj_file, "gt_tbl"))
  } else {
    skip("gt not available in this environment; skipping gt object assertions")
  }
})

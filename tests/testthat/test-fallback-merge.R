library(testthat)

test_that("incompatible key types produce a fallback and it's reused", {
  db <- DataBook$new()

  # import diamonds dataset
  db$import_data(list(diamonds = ggplot2::diamonds))

  # initial summary: creates diamonds_by_cut with count and sum
  db$calculate_summary(data_name = "diamonds",
                       columns_to_summarise = "price",
                       factors = "cut",
                       store_results = TRUE,
                       return_output = FALSE,
                       summaries = c("summary_count", "summary_sum"),
                       silent = TRUE)

  # convert the grouping column in the summary to numeric (to simulate type mismatch)
  db$convert_column_to_type(data_name = "diamonds_by_cut",
                            col_names = "cut",
                            to_type = "numeric")

  # sanity checks on first summary
  names_after_first <- db$get_data_names()
  expect_true("diamonds_by_cut" %in% names_after_first)
  df_base <- db$get_data_frame("diamonds_by_cut")
  expect_true(all(c("count_price", "sum_price") %in% names(df_base)))

  # run two further summaries which should merge into a single fallback
  suppressWarnings(db$calculate_summary(data_name = "diamonds",
                       columns_to_summarise = "carat",
                       factors = "cut",
                       store_results = TRUE,
                       return_output = FALSE,
                       j = 1,
                       summaries = c("summary_mean"),
                       silent = TRUE))

  suppressWarnings(db$calculate_summary(data_name = "diamonds",
                       columns_to_summarise = "price",
                       factors = "cut",
                       store_results = TRUE,
                       return_output = FALSE,
                       j = 1,
                       summaries = c("summary_mean"),
                       silent = TRUE))

  names_final <- db$get_data_names()
  # Expect base and one fallback
  expect_true("diamonds_by_cut" %in% names_final)
  expect_true("diamonds_by_cut1" %in% names_final)
  # There should not be a second numbered fallback
  expect_false("diamonds_by_cut2" %in% names_final)

  # Links should include a link from diamonds -> diamonds_by_cut and diamonds -> diamonds_by_cut1
  links <- db$get_links()
  froms <- sapply(links, function(x) tryCatch(x$from_data_frame, error = function(e) NA))
  tos <- sapply(links, function(x) tryCatch(x$to_data_frame, error = function(e) NA))
  expect_true(any(froms == "diamonds" & tos == "diamonds_by_cut"))
  expect_true(any(froms == "diamonds" & tos == "diamonds_by_cut1"))

  # Check that the fallback has the expected mean columns
  df_fallback <- db$get_data_frame("diamonds_by_cut1")
  expect_true(all(c("mean_carat", "mean_price") %in% names(df_fallback)))
})

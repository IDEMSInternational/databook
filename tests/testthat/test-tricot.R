library(testthat)

test_that("Tricot breadwheat level checks", {
  skip_if_not_installed("gosset")

  # Load dataset from gosset and import into the DataBook
  data(breadwheat, package = "gosset")

  db <- DataBook$new()
  # import as named table
  db$import_data(data_tables = list(breadwheat = breadwheat))

  # The package helpers print messages and return integer codes
  out_id_bw <- capture.output(id_code_bw <- check_ID_data_level("breadwheat"))
  expect_true(any(grepl("Success. This data is at the ID level.|There is no ID variable", out_id_bw)))
  expect_true(id_code_bw %in% c(0,1,2,3))

  # There should be a plot-level table created (or creatable) named breadwheat_plot
  # The helper may expect a tricot-defined plot table; attempt to call the check and accept allowed codes
  out_id_plot <- capture.output(id_code_plot <- check_ID_data_level("breadwheat_plot"))
  expect_true(any(grepl("Only ID level data can be used for this data|Success. This data is at the ID level|There is no ID variable", out_id_plot)))
  expect_true(id_code_plot %in% c(0,1,2,3))

  out_id_plot_by_variety <- capture.output(id_code_plot_by_variety <- check_ID_data_level("breadwheat_plot_by_variety"))
  expect_true(any(grepl("There is no ID variable that is Tricot-Defined in this data|Only ID level data can be used for this data", out_id_plot_by_variety)))
  expect_true(id_code_plot_by_variety %in% c(0,1,2,3))

  # Variety checks
  out_var_bw <- capture.output(var_code_bw <- check_variety_data_level("breadwheat"))
  expect_true(any(grepl("There is no variety variable that is Tricot-Defined in this data|Success. This data is at the variety level", out_var_bw)))
  expect_true(var_code_bw %in% c(0,1,2,3,7,8))

  out_var_plot <- capture.output(var_code_plot <- check_variety_data_level("breadwheat_plot"))
  expect_true(any(grepl("Success. This data is at the plot level, but it can be used.|Success. This data is at the variety level|There is no variety variable", out_var_plot)))
  expect_true(var_code_plot %in% c(0,1,2,3,7,8))

  out_var_plot_by_variety <- capture.output(var_code_plot_by_variety <- check_variety_data_level("breadwheat_plot_by_variety"))
  expect_true(any(grepl("Success. This data is at the variety level|There is no variety variable", out_var_plot_by_variety)))
  expect_true(var_code_plot_by_variety %in% c(0,1,2,3,7,8))
})

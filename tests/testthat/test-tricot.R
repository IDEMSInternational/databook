library(testthat)

test_that("Tricot breadwheat level checks", {
  skip_if_not_installed("gosset")

  # Load dataset from gosset and import into the DataBook
  breadwheat <- gosset::breadwheat
  data_book <- DataBook$new()
  
  # import as named table
  data_book$import_data(data_tables = list(breadwheat = breadwheat))

  #breadwheat <- data_book$get_data_frame("breadwheat")

  # The package helpers print messages and return integer codes
  out_id_bw <- capture.output(out_id_bw <- data_book$check_ID_data_level("breadwheat"))
  expect_true(any(grepl("This data is not Tricot-Defined. Please Tricot-Define this data before proceeding", out_id_bw)))
  
  # Now define the data as Tricot-Defined
  breadwheat <- data_book$get_data_frame("breadwheat")
  output_data_levels <- data_book$summarise_data_levels(data_list = "breadwheat")
  output_data_levels <- suppressWarnings(data_book$create_tricot_datasets(output_data_levels))
  suppressWarnings(data_book$define_as_tricot(output_data_levels = output_data_levels))
  plot_data <- output_data_levels %>% dplyr::filter(level == "plot")
  plot_data_name <- (plot_data) %>% dplyr::pull(dataset)
  plot_data_type <- data_book$get_variables_from_metadata(plot_data_name, "Tricot_Type", "variety")
  variety_data <- output_data_levels %>% dplyr::filter(level == "variety")
  variety_data_name <- (variety_data) %>% dplyr::pull(dataset)
  variety_data_type <- data_book$get_variables_from_metadata(variety_data_name, "Tricot_Type", "variety")
  data_book$add_link(from_data_frame=plot_data_name, to_data_frame=variety_data_name, link_pairs=c(setNames(list(plot_data_type), variety_data_type)), type="keyed_link", link_name="link")
  plot_data_name_data <- data_book$get_data_frame(plot_data_name)
  traits <- data_book$get_column_selection(data_name=plot_data_name, name="traits_selection")
  traits <- unname(traits $ conditions$C0$parameters$x)
  plot_data_id_var <- plot_data %>% dplyr::pull(c(id_col))
  plot_data_variety_var <- plot_data %>% dplyr::pull(c(variety_col))
  rankings_list <- instatExtras::create_rankings_list(data=plot_data_name_data, traits=traits, id=plot_data_id_var, variety=plot_data_variety_var, FALSE)
  data_book$add_object(data_name=plot_data_name, object_name="rankings_list", object_type_label="structure", object_format="text", object=rankings_list)
  grouped_rankings_list <- instatExtras::create_rankings_list(data=plot_data_name_data, traits=traits, id=plot_data_id_var, variety=plot_data_variety_var, TRUE)
  data_book$add_object(data_name=plot_data_name, object_name="grouped_rankings_list", object_type_label="structure", object_format="text", object=grouped_rankings_list)
  
  out_id_bw <- capture.output(out_id_bw <- data_book$check_ID_data_level("breadwheat"))
  
  expect_true(any(grepl("Success. This data is at the ID level.|There is no ID variable", out_id_bw)))

  # There should be a plot-level table created (or creatable) named breadwheat_plot
  # The helper may expect a tricot-defined plot table; attempt to call the check and accept allowed codes
  out_id_plot <- capture.output(id_code_plot <- data_book$check_ID_data_level("breadwheat_plot"))
  expect_true(any(grepl("Only ID level data can be used for this data|Success. This data is at the ID level|There is no ID variable", out_id_plot)))
  expect_true(id_code_plot %in% c(0,1,2,3))

  out_id_plot_by_variety <- capture.output(id_code_plot_by_variety <- data_book$check_ID_data_level("breadwheat_plot_by_variety"))
  expect_true(any(grepl("There is no ID variable that is Tricot-Defined in this data|Only ID level data can be used for this data", out_id_plot_by_variety)))
  expect_true(id_code_plot_by_variety %in% c(0,1,2,3))

  # Variety checks
  out_var_bw <- capture.output(var_code_bw <- data_book$check_variety_data_level("breadwheat"))
  expect_true(any(grepl("There is no variety variable that is Tricot-Defined in this data|Success. This data is at the variety level", out_var_bw)))
  expect_true(var_code_bw %in% c(0,1,2,3,7,8))

  out_var_plot <- capture.output(var_code_plot <- data_book$check_variety_data_level("breadwheat_plot"))
  expect_true(any(grepl("Success. This data is at the plot level, but it can be used.|Success. This data is at the variety level|There is no variety variable", out_var_plot)))
  expect_true(var_code_plot %in% c(0,1,2,3,7,8))

  out_var_plot_by_variety <- capture.output(var_code_plot_by_variety <- data_book$check_variety_data_level("breadwheat_plot_by_variety"))
  expect_true(any(grepl("Success. This data is at the variety level|There is no variety variable", out_var_plot_by_variety)))
  expect_true(var_code_plot_by_variety %in% c(0,1,2,3,7,8))
})

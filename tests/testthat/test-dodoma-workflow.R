library(dplyr)

test_that("Dodoma workflow using instat_calculation produces summary via run_instat_calculation", {
  skip_if_not_installed("instatCalculations")

  data(dodoma, package = "databook")

  # to run on load due to issues with old RDS files
  calculation <- instatCalculations::calculation
  get_data_book_output_object_names <- databook:::get_data_book_output_object_names
  get_data_book_scalar_names <- databook:::get_data_book_scalar_names
  overall_label="[Overall]"

  data_book <- DataBook$new()
  suppressWarnings(data_book$import_RDS(data_RDS = dodoma))

  # Enable undo (exercise API)
  try(data_book$set_enable_disable_undo(data_name = "dodoma", disable_undo = FALSE), silent = TRUE)

  # Add filter year < 1940
  data_book$add_filter(filter = list(C0 = list(column = "year", operation = "<", value = 1940)), data_name = "dodoma", filter_name = "filter")

  # Copy subset using filter
  data_book$copy_data_object(data_name = "dodoma", new_name = "dodoma_subset", filter_name = "filter")

  ### Testing Calculation System (Start Rains) ##############################################
  # Ensure year type is captured and conversions can be run
  year_type <- data_book$get_column_data_types(data_name = "dodoma_subset", columns = "year")
  data_book$convert_column_to_type(data_name = "dodoma_subset", col_names = "year", to_type = "factor")

  # Build instat_calculation objects similar to the snippet
  roll_sum_rain <- instatCalculations::instat_calculation$new(type = "calculation", function_exp = "RcppRoll::roll_sumr(x=rain, n=2, fill=NA, na.rm=FALSE)", result_name = "roll_sum_rain", calculated_from = list("dodoma_subset" = "rain"))

  conditions_filter <- instatCalculations::instat_calculation$new(type = "filter", function_exp = "((rain >= 0.85) & roll_sum_rain > 20) | is.na(x=rain) | is.na(x=roll_sum_rain)", sub_calculations = list(roll_sum_rain))

  grouping_by_year <- instatCalculations::instat_calculation$new(type = "by", calculated_from = list("dodoma_subset" = "year"))

  doy_filter <- instatCalculations::instat_calculation$new(type = "filter", function_exp = "doy_366 >= 1 & doy_366 <= 366", calculated_from = calc_from_convert(x = list(dodoma_subset = "doy_366")))

  start_of_rains_doy <- instatCalculations::instat_calculation$new(type = "summary", function_exp = "ifelse(test=is.na(x=dplyr::first(x=rain)) | is.na(x=dplyr::first(x=roll_sum_rain)), yes=NA, no=dplyr::first(x=doy_366, default=NA))", result_name = "start_rain", save = 2)

  start_rain_date <- instatCalculations::instat_calculation$new(type = "summary", function_exp = "dplyr::if_else(condition=is.na(x=dplyr::first(x=rain)) | is.na(x=dplyr::first(x=roll_sum_rain)), true=as.Date(NA), false=dplyr::first(date, default=NA))", result_name = "start_rain_date", save = 2)

  start_of_rains_status <- instatCalculations::instat_calculation$new(type = "summary", function_exp = "ifelse(n() > 0, ifelse(dplyr::first(is.na(roll_sum_rain)), NA, TRUE), FALSE)", result_name = "start_rain_status", save = 2)

  start_of_rains_combined <- instatCalculations::instat_calculation$new(type = "combination", manipulations = list(conditions_filter, grouping_by_year, doy_filter), sub_calculations = list(start_of_rains_doy, start_rain_date, start_of_rains_status))

  # Run calculation; will save results into DataBook via save=2
  data_book$run_instat_calculation(calc = start_of_rains_combined, display = FALSE, param_list = list(drop = FALSE))

  # Re-enable undo on subset
  data_book$set_enable_disable_undo(data_name = "dodoma_subset", disable_undo = FALSE)

  # Find linked data and attempt to convert type back to original
  linked_data_name <- data_book$get_linked_to_data_name("dodoma_subset", link_cols = c("year"))
  data_book$convert_column_to_type(data_name = "dodoma_subset", col_names = "year", to_type = year_type)
  if (!is.null(linked_data_name) && linked_data_name != "") data_book$convert_column_to_type(data_name = linked_data_name, col_names = "year", to_type = year_type)

  # The output should have created a dataframe; check for dodoma_subset_by_year or similar
  out_names <- data_book$get_data_names()
  possible_name <- grep("dodoma_subset.*by.*year|dodoma_subset_by_year", out_names, value = TRUE, ignore.case = TRUE)
  expect_true(length(possible_name) > 0)

  # Pull the summary data frame and check expected columns exist
  summary_df <- data_book$get_data_frame(possible_name[1])
  expect_true(all(c("year", "start_rain", "start_rain_date", "start_rain_status") %in% names(summary_df)))

  # Basic spot checks on types
  expect_true(is.integer(as.integer(summary_df$year)) || is.numeric(summary_df$year))
  expect_true("Date" %in% class(summary_df$start_rain_date) || all(is.na(summary_df$start_rain_date)))

  expect_equal(as.integer(summary_df$start_rain), c(NA, 6, 1, 22, 21))

  ### Testing Linking System ########################################################
  # Add link between dodoma_subset and dodoma_subset_by_year
  data_book$add_link(from_data_frame = "dodoma_subset", to_data_frame = "dodoma_subset_by_year", link_pairs = c(year = "year"), type = "keyed_link", link_name = "link3")

  # Check link exists in names
  link_names <- data_book$get_link_names("dodoma_subset")
  expect_true("link1" %in% link_names)

  # get_link_between returns the link object
  link_obj <- data_book$get_link_between("dodoma_subset", "dodoma_subset_by_year")
  expect_equal(link_obj$from_data_frame, "dodoma_subset")
  expect_equal(link_obj$to_data_frame, "dodoma_subset_by_year")

  # view_link prints; capture output and verify content
  out <- capture.output(data_book$view_link(link_name = "link1"))
  expect_true(any(grepl("From data frame: dodoma_subset", out)))
  expect_true(any(grepl("To data frame: dodoma_subset_by_year", out)))

  # Remove the link
  data_book$remove_link(link_name = "link1")
  expect_false("link1" %in% data_book$get_link_names("dodoma_subset"))
})

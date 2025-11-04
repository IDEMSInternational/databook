test_that("EPICSA Functions are NULL when NULL is given (for SOR/EOR functions)", {
  data_book <- DataBook$new()
  epicsa_testing_data <- readRDS("testdata/epicsa_testing_data.RDS")
  data_book$import_RDS(data_RDS=epicsa_testing_data)
  rm(epicsa_testing_data)
  
  # Run our epicsa_functions.R functions.
  calculations_data <- data_book$get_calculations("daily_niger_by_station_name_year")
  variables_metadata <- data_book$get_variables_metadata("daily_niger")
  daily_data_calculation <- data_book$get_calculations("daily_niger")
  
  # The variables and definitions
  summary_data <- data_book$get_data_frame("daily_niger_by_station_name_year")
  definitions_offset <- data_book$get_offset_term("daily_niger")
  
  start_rains <- get_start_rains_definition(summary_data = summary_data,
                                            calculations_data = calculations_data,
                                            start_rain = NULL,
                                            start_rain_date = NULL,
                                            start_rain_status = NULL,
                                            definitions_offset = definitions_offset)
  
  end_rains <- get_end_rains_definition(summary_data,
                                        calculations_data = calculations_data,
                                        end_rains = NULL,
                                        end_rains_date = NULL,
                                        end_rains_status = NULL,
                                        definitions_offset = definitions_offset)
  
  end_season <- get_end_season_definition(summary_data = summary_data,
                                          calculations_data = calculations_data,
                                          end_season = NULL,
                                          end_season_date = NULL,
                                          end_season_status = NULL,
                                          definitions_offset = definitions_offset)
  
  start_rains <- unlist(start_rains)
  end_rains <- unlist(end_rains)
  end_season <- unlist(end_season)
  expect_true(all(is.na(start_rains)))
  expect_true(all(is.na(end_rains)))
  expect_true(all(is.na(end_season)))
})

test_that("The EPICSA functions for creating definitions without extremes/nrain work successfully", {
  data_book <- DataBook$new()
  epicsa_testing_data <- readRDS("testdata/epicsa_testing_data.RDS")
  data_book$import_RDS(data_RDS=epicsa_testing_data)
  rm(epicsa_testing_data)
  
  # Seasonal Rain
  # day_filter <- instatCalculations::instat_calculation$new(
  #   type="filter",
  #   function_exp="doy >= start_rain & doy <= end_rains",
  #   calculated_from=databook::calc_from_convert(x=list(daily_niger="doy", daily_niger_by_station_name_year=c("start_rain", "end_rains"))))
  # data_book$calculate_summary(columns_to_summarise=c("rain","count"), data_name="daily_niger", factors=c("station_name", "year"), additional_filter=day_filter, na.rm=TRUE, na_type=c("'n'", "'n_non_miss'", "'prop'", "'con'"), na_max_prop=3, j=1, na_max_n=1, na_consecutive_n=4, na_min_n=2, summaries=c("summary_sum"), silent=TRUE)
  # rm(day_filter)
  
  # Run our epicsa_functions.R functions.
  calculations_data <- data_book$get_calculations("daily_niger_by_station_name_year")
  variables_metadata <- data_book$get_variables_metadata("daily_niger")
  daily_data_calculation <- data_book$get_calculations("daily_niger")
  
  variables_metadata <- variables_metadata %>%
    dplyr::mutate(
      Climatic_Type = dplyr::case_when(
        Name == "high_temp"  ~ "count",
        Name == "low_temp"   ~ "count",
        Name == "high_rain"  ~ "count",
        Name == "rain_day"   ~ "count",
        TRUE ~ Climatic_Type
      )
    )
  
  # The variables and definitions
  summary_data <- data_book$get_data_frame("daily_niger_by_station_name_year")
  definitions_offset <- data_book$get_offset_term("daily_niger")
  
  start_rains <- get_start_rains_definition(summary_data = summary_data,
                                            calculations_data = calculations_data,
                                            start_rain = "start_rain",
                                            start_rain_date = "start_rain_date",
                                            start_rain_status = "start_rain_status",
                                            definitions_offset = definitions_offset)
  
  end_rains <- get_end_rains_definition(summary_data,
                                        calculations_data = calculations_data,
                                        end_rains = "end_rains",
                                        end_rains_date = "end_rains_date",
                                        end_rains_status = "end_rains_status",
                                        definitions_offset = definitions_offset)
  
  end_season <- get_end_season_definition(summary_data = summary_data,
                                          calculations_data = calculations_data,
                                          end_season = "end_season",
                                          end_season_date = "end_season_date",
                                          end_season_status = "end_season_status",
                                          definitions_offset = definitions_offset)
  
  seasonal_length <- get_seasonal_length_definition(calculations_data,
                                                    seasonal_length = "variable name")
  
  
  # #by_data <- data_book$get_data_frame("daily_niger_by_station_name_year")
  # extreme_summaries = c("sum_high_temp", "sum_low_temp", "sum_high_rain")
  annual_rainfall_summaries = c("sum_rain") #sum_rain_day"
  temperature_summaries = c("mean_tmin", "min_tmin", "max_tmin",
                            "mean_tmax", "min_tmax", "max_tmax")
  # extremes_temps <- get_climatic_summaries_definition(calculations_data,
  #                                                     variables_metadata,
  #                                                     summary_variables = extreme_summaries,
  #                                                     daily_data_calculation)
  
  expect_error(get_climatic_summaries_definition(calculations_data,
                                                 variables_metadata,
                                                 summary_variables = c("sum_extreme_rainfall", "sum_rain_day"),
                                                 daily_data_calculation)
  )
  
  # We can get seasonal vs annual by just naming conventions, so no needed to make any changes here
  # but we might want to call in this fn the days from and days to.
  rain_day <- get_climatic_summaries_definition(calculations_data,
                                                variables_metadata,
                                                summary_variables = annual_rainfall_summaries,
                                                daily_data_calculation)
  annual_temperature <- get_climatic_summaries_definition(calculations_data,
                                                          variables_metadata,
                                                          summary_variables =  temperature_summaries,
                                                          daily_data_calculation)
  # 
  # # monthly_temperature <- get_climatic_summaries_definition(calculations_data,
  # #                                                         variables_metadata,
  # #                                                         summary_variables =  temperature_summaries, 
  # #                                                         daily_data_calculation)
  
  longest_spell <- get_longest_spell_definition(calculations_data, "spells_ex", definitions_offset)
  
  # Crops
  crop_def <- data_book$get_data_frame("crop_def")
  crop_success <- get_crop_definition(crop_def, definitions_offset = definitions_offset)
  
  # Season Start Probabilities
  crop_prop <- data_book$get_data_frame("crop_prop")
  season_start_probabilities <- get_crop_definition(crop_prop, definitions_offset = definitions_offset)
  
  extremes_temps <- NULL
  new <- collate_definitions(start_rains = start_rains,
                             end_rains = end_rains,
                             end_season = end_season,
                             seasonal_length = seasonal_length,
                             annual_rain = rain_day,
                             extreme_tmin = extremes_temps,
                             extreme_tmax = extremes_temps,
                             extreme_rain = extremes_temps,
                             longest_rain_spell = longest_spell, # they define which spell it is
                             annual_temperature = annual_temperature,
                             crop_success = crop_success,
                             season_start_probabilities = season_start_probabilities)
  expected <- readRDS("testdata/full_definitions_expected.rds")
  suppressWarnings(expect_equal(new, expected))
  
  #saveRDS(new, "testdata/full_definitions_expected.rds")
})

# test_that("The EPICSA functions for creating definitions work successfully", {
#   data_book <- DataBook$new()
#   epicsa_testing_data <- readRDS("testdata/epicsa_testing_data.RDS")
#   data_book$import_RDS(data_RDS=epicsa_testing_data)
#   rm(epicsa_testing_data)
#   
#   # Seasonal Rain
#   # day_filter <- instatCalculations::instat_calculation$new(
#   #   type="filter",
#   #   function_exp="doy >= start_rain & doy <= end_rains",
#   #   calculated_from=databook::calc_from_convert(x=list(daily_niger="doy", daily_niger_by_station_name_year=c("start_rain", "end_rains"))))
#   # data_book$calculate_summary(columns_to_summarise=c("rain","count"), data_name="daily_niger", factors=c("station_name", "year"), additional_filter=day_filter, na.rm=TRUE, na_type=c("'n'", "'n_non_miss'", "'prop'", "'con'"), na_max_prop=3, j=1, na_max_n=1, na_consecutive_n=4, na_min_n=2, summaries=c("summary_sum"), silent=TRUE)
#   # rm(day_filter)
#   
#   # Run our epicsa_functions.R functions.
#   calculations_data <- data_book$get_calculations("daily_niger_by_station_name_year")
#   variables_metadata <- data_book$get_variables_metadata("daily_niger")
#   daily_data_calculation <- data_book$get_calculations("daily_niger")
#   
#   variables_metadata <- variables_metadata %>%
#     dplyr::mutate(
#       Climatic_Type = dplyr::case_when(
#         Name == "high_temp"  ~ "count",
#         Name == "low_temp"   ~ "count",
#         Name == "high_rain"  ~ "count",
#         Name == "rain_day"   ~ "count",
#         TRUE ~ Climatic_Type
#       )
#     )
#   
#   # The variables and definitions
#   summary_data <- data_book$get_data_frame("daily_niger_by_station_name_year")
#   definitions_offset <- data_book$get_offset_term("daily_niger")
#   
#   start_rains <- get_start_rains_definition(summary_data = summary_data,
#                                             calculations_data = calculations_data,
#                                             start_rain = "start_rain",
#                                             start_rain_date = "start_rain_date",
#                                             start_rain_status = "start_rain_status",
#                                             definitions_offset = definitions_offset)
#   
#   end_rains <- get_end_rains_definition(summary_data,
#                                         calculations_data = calculations_data,
#                                         end_rains = "end_rains",
#                                         end_rains_date = "end_rains_date",
#                                         end_rains_status = "end_rains_status",
#                                         definitions_offset = definitions_offset)
#   
#   end_season <- get_end_season_definition(summary_data = summary_data,
#                                           calculations_data = calculations_data,
#                                           end_season = NULL,
#                                           end_season_date = NULL,
#                                           end_season_status = NULL,
#                                           definitions_offset = definitions_offset)
#   
#   seasonal_length <- get_seasonal_length_definition(calculations_data,
#                                                     seasonal_length = "variable name")
#   
#   
#   # #by_data <- data_book$get_data_frame("daily_niger_by_station_name_year")
#   extreme_summaries = c("sum_high_temp", "sum_low_temp", "sum_high_rain")
#   annual_rainfall_summaries = c("sum_rain_day", "sum_rain")
#   temperature_summaries = c("mean_tmin", "min_tmin", "max_tmin",
#                             "mean_tmax", "min_tmax", "max_tmax")
#   extremes_temps <- get_climatic_summaries_definition(calculations_data,
#                                                       variables_metadata,
#                                                       summary_variables = extreme_summaries,
#                                                       daily_data_calculation)
#   
#   # TODO: add in an error if we have two rain types for count.
#   # extremes_rain <- get_climatic_summaries_definition(calculations_data,
#   #                                                      variables_metadata,
#   #                                                      summary_variables = c("sum_extreme_rainfall", "sum_rain_day"),
#   #                                                      daily_data_calculation)
#   
#   # We can get seasonal vs annual by just naming conventions, so no needed to make any changes here
#   # but we might want to call in this fn the days from and days to.
#   rain_day <- get_climatic_summaries_definition(calculations_data,
#                                                 variables_metadata,
#                                                 summary_variables = annual_rainfall_summaries,
#                                                 daily_data_calculation)
#   annual_temperature <- get_climatic_summaries_definition(calculations_data,
#                                                           variables_metadata,
#                                                           summary_variables =  temperature_summaries,
#                                                           daily_data_calculation)
#   # 
#   # # monthly_temperature <- get_climatic_summaries_definition(calculations_data,
#   # #                                                         variables_metadata,
#   # #                                                         summary_variables =  temperature_summaries, 
#   # #                                                         daily_data_calculation)
#   
#   longest_spell <- get_longest_spell_definition(calculations_data, "spells_ex", definitions_offset)
#   
#   # Crops
#   crop_def <- data_book$get_data_frame("crop_def")
#   crop_success <- get_crop_definition(crop_def, definitions_offset = definitions_offset)
#   
#   # Season Start Probabilities
#   crop_prop <- data_book$get_data_frame("crop_prop")
#   season_start_probabilities <- get_crop_definition(crop_prop, definitions_offset = definitions_offset)
#   
#   new <- collate_definitions(start_rains = start_rains,
#                              end_rains = end_rains,
#                              end_season = end_season,
#                              seasonal_length = seasonal_length,
#                              annual_rain = rain_day,
#                              extreme_tmin = extremes_temps,
#                              extreme_tmax = extremes_temps,
#                              extreme_rain = extremes_temps,
#                              longest_rain_spell = longest_spell, # they define which spell it is
#                              annual_temperature = annual_temperature,
#                              crop_success = crop_success,
#                              season_start_probabilities = season_start_probabilities)
#   expected <- readRDS("testdata/full_definitions_expected.rds")
#   suppressWarnings(expect_equal(new, expected))
#   
#   #saveRDS(new, "testdata/full_definitions_expected.rds")
# })

test_that("get_transform_column_info handles null/empty safely", {
  expect_equal(
    get_transform_column_info(NULL),
    list(direction = NA_character_, value = NA_real_, value_lb = NA_real_)
  )
  expect_equal(
    get_transform_column_info(NA_character_),
    list(direction = NA_character_, value = NA_real_, value_lb = NA_real_)
  )
  expect_equal(
    get_transform_column_info(""),
    list(direction = NA_character_, value = NA_real_, value_lb = NA_real_)
  )
})

test_that("get_transform_column_info parses single-sided inequalities", {
  # greater / >=
  expect_equal(
    get_transform_column_info("x >= 10"),
    list(direction = "greater", value_lb = NA_real_, value = 10)
  )
  expect_equal(
    get_transform_column_info("x > 3.5"),
    list(direction = "greater", value_lb = NA_real_, value = 3.5)
  )
  
  # less / <=
  expect_equal(
    get_transform_column_info("y <= 7"),
    list(direction = "less", value_lb = NA_real_, value = 7)
  )
  expect_equal(
    get_transform_column_info("(y < 0.75)"),
    list(direction = "less", value_lb = NA_real_, value = 0.75)
  )
})

test_that("get_transform_column_info parses between windows (>= & <=)", {
  # canonical "between": lower inclusive, upper inclusive
  expect_equal(
    get_transform_column_info("z >= 1 & z <= 5"),
    list(direction = "between", value_lb = 1, value = 5)
  )
  
  # order-insensitive with extra whitespace/noise
  expect_equal(
    get_transform_column_info("  z >= 2  &   z <=  9  "),
    list(direction = "between", value_lb = 2, value = 9)
  )
})

test_that("get_transform_column_info parses outer windows (> & <)", {
  # "outer": less-than AND greater-than present (strict), return lo/hi as per function mapping
  # Here ops are: "< 2" then "> 9" → hi_val=2, lo_val=9 → value_lb=2, value=9
  expect_equal(
    get_transform_column_info("(z<2) | (z>9)"),
    list(direction = "outer",  value_lb = 2, value = 9)
  )
  
  # Another order: first '>' then '<'
  expect_equal(
    get_transform_column_info("z > 100 | z < 4"),
    list(direction = "outer", value_lb = 4, value = 100)
  )
})

test_that("get_transform_column_info ignores unrelated trailing numbers", {
  # Extra numbers after the main constraints should be ignored for window picking
  out <- get_transform_column_info("foo >= 5 & foo <= 10 & k == 123")
  expect_equal(out$direction, "between")
  expect_equal(out$value_lb, 5)
  expect_equal(out$value, 10)
})

test_that("get_transform_column_info returns NA when no recognized operators", {
  expect_equal(
    get_transform_column_info("no operators or numbers here"),
    list(direction = NA_character_, value = NA_real_, value_lb = NA_real_)
  )
})

# Start Rains - Testing other bits - 
test_that("EPICSA Functions are NULL when NULL is given (for SOR/EOR functions)", {
  data_book <- DataBook$new()
  epicsa_testing_data <- readRDS("testdata/epicsa_sor_data.RDS")
  data_book$import_RDS(data_RDS=epicsa_testing_data)
  rm(epicsa_testing_data)
  
  # Run our epicsa_functions.R functions.
  calculations_data <- data_book$get_calculations("daily_niger_by_station_name_year")
  variables_metadata <- data_book$get_variables_metadata("daily_niger")
  daily_data_calculation <- data_book$get_calculations("daily_niger")
  
  # The variables and definitions
  summary_data <- data_book$get_data_frame("daily_niger_by_station_name_year")
  definitions_offset <- data_book$get_offset_term("daily_niger")
  
  start_rains <- get_start_rains_definition(summary_data = summary_data,
                                            calculations_data = calculations_data,
                                            start_rain = "start_rain",
                                            start_rain_date = "start_rain_date",
                                            start_rain_status = "start_rain_status",
                                            definitions_offset = definitions_offset)
  
  expect_equal(
    start_rains,
    list(
      start_day              = 153,
      end_day                = 274,
      threshold              = 0.85,
      total_rainfall         = TRUE,
      over_days              = 2,
      amount_rain            = 20,
      proportion             = FALSE,
      prob_rain_day          = NA,
      evaporation            = FALSE,
      evaporation_fraction   = NA,
      number_rain_days       = FALSE,
      min_rain_days          = NA,
      rain_day_interval      = NA,
      dry_spell              = TRUE,
      spell_max_dry_days     = 9,
      spell_interval         = 21,
      dry_period             = FALSE,
      max_rain               = NA,
      period_interval        = NA,
      period_max_dry_days    = NA,
      include_status         = TRUE,
      output                 = c("doy","date","status"),
      s_start_doy            = 1
    )
  )
})

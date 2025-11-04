test_that("The EPICSA functions for creating definitions work successfully", {
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
  
  variables_metadata[8, 5] <- "count"
  variables_metadata[10, 5] <- "count"
  variables_metadata[12, 5] <- "count"
  variables_metadata[13, 5] <- "count"
  
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
                                          end_season = NULL,
                                          end_season_date = NULL,
                                          end_season_status = NULL,
                                          definitions_offset = definitions_offset)
  
  seasonal_length <- get_seasonal_length_definition(calculations_data,
                                                    seasonal_length = "variable name")
  

  #by_data <- data_book$get_data_frame("daily_niger_by_station_name_year")
  extreme_summaries = c("sum_high_temp", "sum_low_temp", "sum_high_rain")
  annual_rainfall_summaries = c("sum_rain_day", "sum_rain")
  temperature_summaries = c("mean_tmin", "min_tmin", "max_tmin",
                            "mean_tmax", "min_tmax", "max_tmax")
  extremes_temps <- get_climatic_summaries_definition(calculations_data,
                                                      variables_metadata,
                                                      summary_variables = extreme_summaries,
                                                      daily_data_calculation)
  # TODO: add in an error if we have two rain types for count. 
  # extremes_rain <- get_climatic_summaries_definition(calculations_data,
  #                                                      variables_metadata,
  #                                                      summary_variables = c("sum_extreme_rainfall", "sum_count"),
  #                                                      daily_data_calculation) 
  
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
  
  # monthly_temperature <- get_climatic_summaries_definition(calculations_data,
  #                                                         variables_metadata,
  #                                                         summary_variables =  temperature_summaries, 
  #                                                         daily_data_calculation)
  
  longest_spell <- get_longest_spell_definition(calculations_data, "spells_ex", definitions_offset)
  
  # Crops
  crop_def <- data_book$get_data_frame("crop_def")
  crop_success <- get_crop_definition(crop_def, definitions_offset = definitions_offset)
  
  # Season Start Probabilities
  crop_prop <- data_book$get_data_frame("crop_prop")
  season_start_probabilities <- get_crop_definition(crop_prop, definitions_offset = definitions_offset)
  
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

  # saveRDS(new, "testdata/full_definitions_expected.rds")
})

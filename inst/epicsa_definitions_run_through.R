
data_book <- DataBook$new()
new_RDS <- readRDS(file="C:/Users/lclem/OneDrive/Documents/Zambia_data_all.RDS")
data_book$import_RDS(data_RDS=new_RDS)
rm(new_RDS)

# Seasonal Rain
day_filter <- instatCalculations::instat_calculation$new(type="filter", function_exp="s_doy >= start_rain & s_doy <= end_season", calculated_from=databook::calc_from_convert(x=list(observations_unstacked_data="s_doy", observations_unstacked_data_by_station_id_s_year=c("start_rain", "end_season"))))
data_book$calculate_summary(columns_to_summarise=c("PRECIP","count"), data_name="observations_unstacked_data", factors=c("station_id", "s_year"), additional_filter=day_filter, na.rm=TRUE, na_type=c("'n'", "'n_non_miss'", "'prop'", "'con'"), na_max_prop=3, j=1, na_max_n=1, na_consecutive_n=4, na_min_n=2, summaries=c("summary_sum"), silent=TRUE)
rm(day_filter)

# Annual Rain
data_book$calculate_summary(columns_to_summarise=c("PRECIP","count"), data_name="observations_unstacked_data", factors=c("station_id", "s_year"), na.rm=TRUE, na_type=c("'n'", "'n_non_miss'", "'prop'", "'con'"), na_max_prop=3, j=1, na_max_n=1, na_consecutive_n=4, na_min_n=2, summaries=c("summary_sum"), silent=TRUE)

# Monthly Temperatures
data_book$calculate_summary(columns_to_summarise=c("TMPMAX","TMPMIN"), data_name="observations_unstacked_data", factors=c("station_id", "month_val"), na.rm=TRUE, na_type=c("'n'", "'n_non_miss'", "'prop'", "'con'"), na_max_prop=3, j=1, na_max_n=1, na_consecutive_n=4, na_min_n=2, summaries=c("summary_mean", "summary_min", "summary_max"), silent=TRUE)

# Annual Temperatures
data_book$calculate_summary(columns_to_summarise=c("TMPMAX","TMPMIN"), data_name="observations_unstacked_data", factors=c("station_id", "s_year"), na.rm=TRUE, na_type=c("'n'", "'n_non_miss'", "'prop'", "'con'"), na_max_prop=3, j=1, na_max_n=1, na_consecutive_n=4, na_min_n=2, summaries=c("summary_mean", "summary_min", "summary_max"), silent=TRUE)


# Dialog: Spells -- Excluding between (with doy)

spell_day <- instatCalculations::instat_calculation$new(calculated_from= list("observations_unstacked_data"="PRECIP"), type="calculation", function_exp="(PRECIP < 0) | PRECIP > 0.85", result_name="spell_day", save=0)
spell_length <- instatCalculations::instat_calculation$new(type="calculation", result_name="spell_length", sub_calculations=list(spell_day), save=0, function_exp="instatClimatic::spells(x=spell_day)")
grouping <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="s_year","observations_unstacked_data"="station_id"))
day_from_and_to <- instatCalculations::instat_calculation$new(type="filter", function_exp="s_doy >= 1 & s_doy <= 183", calculated_from=databook::calc_from_convert(x=list(observations_unstacked_data="s_doy")))
spells <- instatCalculations::instat_calculation$new(type="summary", function_exp="max(x=spell_length)", result_name="spells_ex", manipulations=list(spell_length, grouping, day_from_and_to), save=2)
data_book$run_instat_calculation(calc=spells, display=FALSE)
rm(list=c("spells", "spell_length", "spell_day", "grouping", "day_from_and_to"))


data_book$calculate_summary(data_name="observations_unstacked_data", columns_to_summarise="extreme_rainfall", factors=c("station_id","s_year"), store_results=TRUE, return_output=FALSE, j=1, summaries=c("summary_sum"), silent=TRUE)

# Dialog: Transform
rain_day <- instatCalculations::instat_calculation$new(type="calculation", function_exp="(TMPMIN <= 30)", result_name="rain_day", calculated_from= list("observations_unstacked_data"="TMPMIN"))
group_by_station <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="station_id"))
transform_calculation <- instatCalculations::instat_calculation$new(type="calculation", function_exp="zoo::rollapply(data=rain_day, width=1, FUN=sum, align='right', fill=NA)", result_name="extreme_min_temp", sub_calculations=list(rain_day), manipulations=list(group_by_station), save=2, before=FALSE, adjacent_column="TMPMIN")
data_book$run_instat_calculation(calc=transform_calculation, display=FALSE)
rm(list=c("transform_calculation", "rain_day", "group_by_station"))

# Dialog: Transform
rain_day <- instatCalculations::instat_calculation$new(type="calculation", function_exp="(TMPMAX >= 30)", result_name="rain_day", calculated_from= list("observations_unstacked_data"="TMPMAX"))
group_by_station <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="station_id"))
transform_calculation <- instatCalculations::instat_calculation$new(type="calculation", function_exp="zoo::rollapply(data=rain_day, width=1, FUN=sum, align='right', fill=NA)", result_name="extreme_max_temp", sub_calculations=list(rain_day), manipulations=list(group_by_station), save=2, before=FALSE, adjacent_column="TMPMAX")
data_book$run_instat_calculation(calc=transform_calculation, display=FALSE)
rm(list=c("transform_calculation", "rain_day", "group_by_station"))

# Count extreme temperatures
data_book$calculate_summary(columns_to_summarise=c("extreme_max_temp","extreme_min_temp"), data_name="observations_unstacked_data", factors=c("station_id", "s_year"), na.rm=TRUE, na_type=c("'n'", "'n_non_miss'", "'prop'", "'con'"), na_max_prop=3, j=1, na_max_n=1, na_consecutive_n=4, na_min_n=2, summaries=c("summary_sum"), silent=TRUE)


calculations_data <- data_book$get_calculations("observations_unstacked_data_by_station_id_s_year")
variables_metadata <- data_book$get_variables_metadata("observations_unstacked_data")
daily_data_calculation <- data_book$get_calculations("observations_unstacked_data")


variables_metadata[9, 5] <- "count"
variables_metadata[11, 5] <- "count"
variables_metadata[14, 5] <- "count"
variables_metadata[13, 5] <- "count"

######
#saveRDS("C:/Users/lclem/OneDrive/Documents/Zambia_data_all.RDS", object = data_book)


# If you click to save:
# These should be stored in the databook R package because of get_offset_term
summary_data <- data_book$get_data_frame("observations_unstacked_data_by_station_id_s_year")
calculations_data <- data_book$get_calculations("observations_unstacked_data_by_station_id_s_year")
definitions_offset <- data_book$get_offset_term("observations_unstacked_data")

start_rains <- get_start_rains_definition(summary_data = summary_data,
                                          calculations_data = calculations_data,
                                          start_rain = "start_PRECIP",
                                          start_rain_date = "start_PRECIP_date",
                                          start_rain_status = "start_PRECIP_status",
                                          definitions_offset = definitions_offset)

summary_data <- data_book$get_data_frame("observations_unstacked_data_by_station_id_s_year")
calculations_data <- data_book$get_calculations("observations_unstacked_data_by_station_id_s_year")
definitions_offset <- data_book$get_offset_term("observations_unstacked_data")
end_rains <- get_end_rains_definition(summary_data,
                                      calculations_data = calculations_data,
                                      end_rains = NULL,
                                      end_rains_date = NULL,
                                      end_rains_status = NULL,
                                      definitions_offset = definitions_offset)

summary_data <- data_book$get_data_frame("observations_unstacked_data_by_station_id_s_year")
calculations_data <- data_book$get_calculations("observations_unstacked_data_by_station_id_s_year")
definitions_offset <- data_book$get_offset_term("observations_unstacked_data")
end_season <- get_end_season_definition(summary_data = summary_data,
                                        calculations_data = calculations_data,
                                        end_season = "end_season",
                                        end_season_date = "end_season_date",
                                        end_season_status = "end_season_status",
                                        definitions_offset = definitions_offset)

summary_data <- data_book$get_data_frame("observations_unstacked_data_by_station_id_s_year")
calculations_data <- data_book$get_calculations("observations_unstacked_data_by_station_id_s_year")
daily_data_calculation <- data_book$get_calculations("observations_unstacked_data")

calculations_data <- data_book$get_calculations("observations_unstacked_data_by_station_id_s_year")
seasonal_length <- get_seasonal_length_definition(calculations_data, seasonal_length = "variable name")

summary_variables = c("sum_extreme_max_temp", "sum_extreme_min_temp")
extremes_temps <- get_climatic_summaries_definition(calculations_data,
                                                  variables_metadata,
                                                  summary_variables = summary_variables,
                                                  daily_data_calculation)

extremes_PRECIP <- get_climatic_summaries_definition(calculations_data,
                                                    variables_metadata,
                                                    summary_variables = "sum_extreme_rainfall",
                                                    daily_data_calculation) 

# TODO: add in an error if we have two rain types for count. 
# extremes_PRECIP <- get_climatic_summaries_definition(calculations_data,
#                                                      variables_metadata,
#                                                      summary_variables = c("sum_extreme_rainfall", "sum_count"),
#                                                      daily_data_calculation) 


summary_variables = c("sum_PRECIP", "sum_count")
# TODO: we can get seasonal vs annual by just naming conventions, so no needed to make any changes here
# but we might want to call in here the days from and days to. 
rain_day <- get_climatic_summaries_definition(calculations_data,
                                                  variables_metadata,
                                                  summary_variables = summary_variables,
                                                  daily_data_calculation)

summary_variables = c("max_TMPMAX", "mean_TMPMAX")
annual_temperature <- get_climatic_summaries_definition(calculations_data,
                                                        variables_metadata,
                                                        summary_variables =  c("mean_TMPMAX", "mean_TMPMIN", "max_TMPMIN", "min_TMPMAX"), 
                                                        daily_data_calculation)

definitions_offset <- data_book$get_offset_term("observations_unstacked_data")
calculations_data <- data_book$get_calculations("observations_unstacked_data_by_station_id_s_year")
longest_spell <- get_longest_spell_definition(calculations_data, "spells_ex", definitions_offset)

# Crops
definitions_offset <- data_book$get_offset_term("observations_unstacked_data")
crop_def <- data_book$get_data_frame("crop_def")
crop_success <- get_crop_definition(crop_def, definitions_offset = definitions_offset)

# Season Start Probabilities
crop_prop <- data_book$get_data_frame("crop_prop")
season_start_probabilities <- get_crop_definition(crop_prop, definitions_offset = definitions_offset)
season_start_probabilities <- get_season_start_definition(crop_prop)

collate_definitions(start_rains = start_rains,
                    end_rains = end_rains,
                    end_season = end_season,
                    seasonal_length = seasonal_length,
                    annual_rain = rain_day,
                    extreme_tmin = extremes_temps,
                    extreme_tmax = extremes_temps,
                    extreme_rain = extremes_PRECIP,
                    longest_rain_spell = longest_spell, # they define which spell it is
                    annual_temperature = annual_temperature,
                    crop_success = crop_success,
                    season_start_probabilities = season_start_probabilities)

# 
# 

# 

# Dialog: PICSA Crops
data_book$crops_definitions(data_name="observations_unstacked_data", year="s_year", station="station_id", rain="PRECIP", day="s_doy", plant_days=c(160), plant_lengths=c(120), start_day="start_rain", season_data_name="observations_unstacked_data_by_station_id_s_year", end_day="end_season", start_check="both", return_crops_table=TRUE, definition_props=TRUE, rain_totals=seq(500, 800, 100))

data_book$get_data_names()



# UPDATE the documentation
# DO testing on this
# 
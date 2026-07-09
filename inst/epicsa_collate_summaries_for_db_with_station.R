print("hi")
# Initialising R (e.g Loading R packages)
devtools::load_all()

data_book <- DataBook$new()

# Dialog: Import Dataset
new_RDS <- readRDS(file="C:/Users/lclem/OneDrive/Documents/zambia_epicsa_with_metadata.RDS")
data_book$import_RDS(data_RDS=new_RDS)

rm(new_RDS)

# Dialog: Climatic Summary
data_book$calculate_summary(data_name="observations_unstacked_data", columns_to_summarise=c("TMPMAX","TMPMIN"), factors=c("station_id", "month_val"), j=1, na_min_n=10, summaries=c("summary_min", "summary_max"), silent=TRUE)

linked_data_name <- data_book$get_linked_to_data_name(from_data_frame="observations_unstacked_data", link_cols=c(station="station_id", within_variable="month_val"))
summary_variables <- data_book$preview_summary_names(data_name="observations_unstacked_data", columns_to_summarise=c("TMPMAX","TMPMIN"), summaries=c("summary_min", "summary_max"), factors=c("station_id", "month_val"))
types <- data_book$build_climatic_types_from_summary(data_name="observations_unstacked_data", columns_to_summarise=c("TMPMAX","TMPMIN"), base_types=c(station="station_id", within_variable="month_val"), summary_variables=summary_variables)
data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c(station="station_id", within_variable="month_val"), types=types, overwrite=FALSE)

summary_variables <- data_book$preview_summary_names(data_name="observations_unstacked_data", columns_to_summarise=c("TMPMAX","TMPMIN"), summaries=c("summary_min", "summary_max"), factors=c("station_id", "month_val"))
Within_Year_Definitions <- data_book$get_climatic_summaries_definition(data_name="observations_unstacked_data", summary_data=linked_data_name, summary_variables=summary_variables, definition_name="Within_Year_Definitions")
data_book$add_object(data_name=linked_data_name, object_name="Within_Year_Definitions", object_type_label="structure", object_format="text", object=Within_Year_Definitions)

data_book$delete_dataframes(c("crop_def", "crop_prop"))

# Dialog: PICSA Crops

existing_dfs <- data_book$get_data_names()

data_book$crops_definitions(data_name="observations_unstacked_data",
                            year="s_year",
                            station="station_id",
                            rain="PRECIP",
                            day="s_doy",
                            plant_days=c(80, 160, 200),
                            plant_lengths=c(120),
                            rain_totals=c(600, 800),
                            start_day="start",
                            season_data_name="observations_unstacked_data_by_station_id_s_year",
                            start_check="both",
                            end_day="end_rains")
new_df_name <- setdiff(data_book$get_data_names(), existing_dfs)

new_crop_def <- new_df_name[startsWith(new_df_name, "crop_def")]
crop_def <- data_book$get_data_frame(new_crop_def)
crops_data_definition <- get_crop_definition(crop_def)
data_book$add_object(data_name=new_crop_def, object_name="crops_data_definition", object_type_label="structure", object_format="text", object=crops_data_definition)

new_crop_prop <- new_df_name[startsWith(new_df_name, "crop_prop")]
crop_prop <- data_book$get_data_frame(new_crop_prop)
crops_proportion_definition <- get_crop_definition(crop_prop)
data_book$add_object(data_name=new_crop_prop, object_name="crops_proportion_definition", object_type_label="structure", object_format="text", object=crops_proportion_definition)

rm(list=c("existing_dfs", "new_df_name", "crops_data_definition", "crop_def", "new_crop_def", "crops_proportion_definition", "crop_prop", "new_crop_prop"))


## Building for export
# COLLATING THEM ########################################
annual_rain <- "observations_unstacked_data_by_station_id_s_year"
monthly_temp <- "observations_unstacked_data_by_station_id_month_val"
crops <- "crop_def"

# Annual rainfall
annual_rain_longer <- data_book$build_summary_long(
  data_name = annual_rain,
  
  time_type = "annual",
  summary_type = "Rain",
  definitions = c("start_rains_definition", "end_rain_definition",
                  "length_definition", "Annual_Definitions")
)

# Monthly Temperature 
monthly_temp_longer <- data_book$build_summary_long(
  data = monthly_temp,
  
  time_type = "monthly",
  summary_type = "Temperature",
  
  definitions = "Within_Year_Definitions"
)

# Crops 
crop_longer <- data_book$build_crop_longer(
  crop_data_name = crops,
  crop_definition = "crop_def"
)

# Collate them
summary_data_binded <- data_book$collate_summary_definitions(
  annual_rain_summary = annual_rain_longer,
  monthly_temp_summary = monthly_temp_longer,
  crop_summary = crop_longer
)

data_book$get_variables_metadata(crops)
# 
# [1] "C:/Users/lclem/OneDrive/Documents/GitHub/databook_master"
# saveRDS(summary_data_binded, "data/summary_data_binded.RDS")



  
  # Building products ###################################################################
  # # Dialog: Import Dataset
  # new_RDS <- readRDS(file="C:/Users/lclem/OneDrive/Documents/Zambia_data_all.RDS")
  # data_book$import_RDS(data_RDS=new_RDS)
  
  # # Dialog: Delete Data Frames
  # data_book$delete_dataframes(data_names=c("observations_unstacked_data_by_station_id_s_year","crop_prop","crop_def"))
  # 
  # # Right click menu: Delete Column(s)
  # data_book$remove_columns_in_data(data_name="observations_unstacked_data", cols=c("extreme_rainfall","count"))
  # 
  # # Dialog: Climatic Transform
  # rain_day <- instatCalculations::instat_calculation$new(type="calculation", function_exp="(PRECIP >= 0.85)", result_name="rain_day", calculated_from= list("observations_unstacked_data"="PRECIP"))
  # group_by_station <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="station_id"))
  # transform_calculation <- instatCalculations::instat_calculation$new(type="calculation", function_exp="zoo::rollapply(data=rain_day, width=1, FUN=sum, align='right', fill=NA)", result_name="rain_day", sub_calculations=list(rain_day), manipulations=list(group_by_station), save=2, before=FALSE, adjacent_column="PRECIP")
  # data_book$run_instat_calculation(calc=transform_calculation, display=FALSE)
  # 
  # data_book$define_as_climatic(data_name="observations_unstacked_data", key_col_names=NULL, types=c(count="rain_day"), overwrite=FALSE)
  # 
  # rm(list=c("transform_calculation", "rain_day", "group_by_station"))
  # 
  # # Dialog: Climatic Summary
  # data_book$calculate_summary(data_name="observations_unstacked_data", columns_to_summarise=c("PRECIP","rain_day"), factors=c("station_id", "s_year"), na.rm=TRUE, na_type=c("'n_non_miss'"), j=1, na_min_n=10, summaries=c("summary_sum"), silent=TRUE)
  # 
  # linked_data_name <- data_book$get_linked_to_data_name(from_data_frame="observations_unstacked_data", link_cols=c(station="station_id", year="s_year"))
  # summary_variables <- data_book$preview_summary_names(data_name="observations_unstacked_data", summaries=c("summary_sum"), columns_to_summarise=c("PRECIP","rain_day"), factors=c("station_id", "s_year"))
  # types <- data_book$build_climatic_types_from_summary(data_name="observations_unstacked_data",
  #                                                      base_types=c(station="station_id", year="s_year"),
  #                                                      columns_to_summarise=c("PRECIP","rain_day"),
  #                                                      summary_variables=summary_variables)
  # data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c(station="station_id", year="s_year"), types=types, overwrite=FALSE)
  # 
  # summary_variables <- data_book$preview_summary_names(data_name="observations_unstacked_data", summaries=c("summary_sum"), columns_to_summarise=c("PRECIP","rain_day"), factors=c("station_id", "s_year"))
  # Annual_Definitions <- data_book$get_climatic_summaries_definition(data_name="observations_unstacked_data", summary_data=linked_data_name, summary_variables=summary_variables, definition_name="Annual_Definitions")
  # data_book$add_object(data_name=linked_data_name, object_name="Annual_Definitions", object_type_label="structure", object_format="text", object=Annual_Definitions)
  # 
  # 
  # rm(list=c("linked_data_name", "types", "summary_variables", "Annual_Definitions"))
  # 
  # # Dialog: Start of Rains
  # year_type <- data_book$get_column_data_types(data_name="observations_unstacked_data", columns="s_year")
  # 
  # 
  # data_book$convert_column_to_type(data_name="observations_unstacked_data", col_names="s_year", to_type="factor")
  # 
  # station_type <- data_book$get_column_data_types(data_name="observations_unstacked_data", columns="station_id")
  # 
  # 
  # data_book$convert_column_to_type(data_name="observations_unstacked_data", col_names="station_id", to_type="factor")
  # 
  # data_book$convert_linked_variable(from_data_frame="observations_unstacked_data", link_cols=c("s_year", "station_id"))
  # 
  # grouping_by_station <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="station_id"))
  # grouping_by_station <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="station_id"))
  # roll_sum_rain <- instatCalculations::instat_calculation$new(type="calculation", function_exp="RcppRoll::roll_sumr(x=PRECIP, n=3, fill=NA, na.rm=FALSE)", result_name="roll_sum_rain", calculated_from=list("observations_unstacked_data"="PRECIP"), manipulations=list(grouping_by_station))
  # conditions_filter <- instatCalculations::instat_calculation$new(type="filter", function_exp="((PRECIP >= 0.85) & roll_sum_rain > 20) | is.na(x=PRECIP) | is.na(x=roll_sum_rain)", sub_calculations=list(roll_sum_rain))
  # grouping_by_year <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="s_year"))
  # doy_filter <- instatCalculations::instat_calculation$new(type="filter", function_exp="s_doy >= 93 & s_doy <= 214", calculated_from=databook::calc_from_convert(x=list(observations_unstacked_data="s_doy")))
  # start_of_rains_doy <- instatCalculations::instat_calculation$new(type="summary", function_exp="ifelse(test=is.na(x=dplyr::first(x=PRECIP)) | is.na(x=dplyr::first(x=roll_sum_rain)), yes=NA, no=dplyr::first(x=s_doy, default=NA))", result_name="start", save=2)
  # start_rain_date <- instatCalculations::instat_calculation$new(type="summary", function_exp="dplyr::if_else(condition=is.na(x=dplyr::first(x=PRECIP)) | is.na(x=dplyr::first(x=roll_sum_rain)), true=as.Date(NA), false=dplyr::first(date, default=NA))", result_name="start_d", save=2)
  # start_of_rains_status <- instatCalculations::instat_calculation$new(type="summary", function_exp="ifelse(n() > 0, ifelse(dplyr::first(is.na(roll_sum_rain)), NA, TRUE), FALSE)", result_name="start_s", save=2)
  # start_of_rains_combined <- instatCalculations::instat_calculation$new(type="combination", manipulations=list(grouping_by_station, conditions_filter, grouping_by_year, doy_filter), sub_calculation=list(start_of_rains_doy, start_rain_date, start_of_rains_status))
  # data_book$run_instat_calculation(calc=start_of_rains_combined, display=FALSE, param_list=list(drop=FALSE))
  # 
  # linked_data_name <- data_book$get_linked_to_data_name("observations_unstacked_data", link_cols=c("s_year", "station_id"))
  # 
  # 
  # calculated_from_list <- c(setNames("start_s", linked_data_name), setNames("start", linked_data_name))
  # 
  # 
  # start_rain_status2 <- instatCalculations::instat_calculation$new(type="calculation", function_exp="ifelse(!is.na(start), TRUE, ifelse(start_s == TRUE, NA, start_s))", calculated_from=calculated_from_list, result_name="start_s", save=2)
  # 
  # 
  # start_rain_combined_status_2 <- instat_calculation$new(type="combination", sub_calculations=list(start_rain_status2))
  # 
  # 
  # data_book$run_instat_calculation(calc=start_rain_combined_status_2, display=FALSE, param_list=list(drop=FALSE))
  # 
  # linked_data_name <- data_book$get_linked_to_data_name("observations_unstacked_data", link_cols=c("s_year", "station_id"))
  # data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c("s_year", "station_id"), types=c(station="station_id", year="s_year", start_rain="start", start_rain_date="start_d", start_rain_status="start_s"), overwrite=FALSE)
  # 
  # data_book$convert_column_to_type(data_name="observations_unstacked_data", col_names="s_year", to_type=year_type)
  # 
  # data_book$convert_linked_variable(from_data_frame="observations_unstacked_data", link_cols=c("s_year", "station_id"))
  # 
  # data_book$remove_unused_station_year_combinations(data_name="observations_unstacked_data", year="s_year", station="station_id")
  # 
  # definitions_offset <- data_book$get_offset_term(data_name="observations_unstacked_data")
  # start_rains_definition <- data_book$get_start_rains_definition(data_name=linked_data_name, definition_name="start_rains_definition", start_rain="start", start_rain_date="start_d", start_rain_status="start_s", definitions_offset=definitions_offset)
  # data_book$add_object(data_name=linked_data_name, object_name="start_rains_definition", object_type_label="structure", object_format="text", object=start_rains_definition)
  # 
  # 
  # rm(list=c("start_of_rains_combined", "start_rain_combined_status_2", "start_rain_status2", "calculated_from_list", "linked_data_name", "station_type", "year_type", "start_rains_definition", "start_of_rains_status", "start_of_rains_doy", "doy_filter", "grouping_by_year", "roll_sum_rain", "conditions_filter", "grouping_by_station", "start_rain_date", "definitions_offset"))
  # 
  # # Dialog: End of Rains/Season
  # year_type <- data_book$get_column_data_types(data_name="observations_unstacked_data", columns="s_year")
  # 
  # 
  # data_book$convert_column_to_type(data_name="observations_unstacked_data", col_names="s_year", to_type="factor")
  # 
  # station_type <- data_book$get_column_data_types(data_name="observations_unstacked_data", columns="station_id")
  # 
  # 
  # data_book$convert_column_to_type(data_name="observations_unstacked_data", col_names="station_id", to_type="factor")
  # 
  # data_book$convert_linked_variable(from_data_frame="observations_unstacked_data", link_cols=c("s_year", "station_id"))
  # 
  # roll_sum_rain <- instatCalculations::instat_calculation$new(type="calculation", function_exp="RcppRoll::roll_sumr(x=PRECIP, n=2, fill=NA, na.rm=FALSE)", result_name="roll_sum_rain", calculated_from=list("observations_unstacked_data"="PRECIP"))
  # conditions_filter <- instatCalculations::instat_calculation$new(type="filter", function_exp="(roll_sum_rain > 10) | is.na(x=roll_sum_rain)", sub_calculations=list(roll_sum_rain))
  # grouping_by_station_year <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="station_id","observations_unstacked_data"="s_year"))
  # doy_filter <- instatCalculations::instat_calculation$new(type="filter", function_exp="s_doy >= 1 & s_doy <= 366", calculated_from=databook::calc_from_convert(x=list(observations_unstacked_data="s_doy")))
  # end_rains <- instatCalculations::instat_calculation$new(type="summary", function_exp="ifelse(test=is.na(x=dplyr::last(x=roll_sum_rain)), yes=NA, no=dplyr::last(x=s_doy))", result_name="end_rains", calculated_from=list("observations_unstacked_data"="s_doy"), save=2)
  # end_rains_date <- instatCalculations::instat_calculation$new(type="summary", function_exp="dplyr::if_else(condition=is.na(x=dplyr::last(x=roll_sum_rain)), true=as.Date(NA), false=dplyr::last(x=date))", result_name="end_rains_date", calculated_from=list("observations_unstacked_data"="date"), save=2)
  # end_rains_status <- instatCalculations::instat_calculation$new(type="summary", function_exp="ifelse(n() > 0, yes=ifelse(is.na(x=dplyr::last(x=roll_sum_rain)), yes=NA, no=TRUE), no=FALSE)", result_name="end_rains_status", save=2)
  # end_of_rains_combined <- instatCalculations::instat_calculation$new(type="combination", manipulations=list(conditions_filter, grouping_by_station_year, doy_filter), sub_calculations=list(end_rains, end_rains_date, end_rains_status))
  # data_book$run_instat_calculation(display=FALSE, param_list=list(drop=FALSE), calc=end_of_rains_combined)
  # 
  # linked_data_name <- data_book$get_linked_to_data_name("observations_unstacked_data", link_cols=c("s_year", "station_id"))
  # data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c("s_year", "station_id"), types=c(station="station_id", year="s_year", end_rain="end_rains", end_rain_date="end_rains_date", end_rain_status="end_rains_status"), overwrite=FALSE)
  # 
  # data_book$convert_column_to_type(data_name="observations_unstacked_data", col_names="s_year", to_type=year_type)
  # 
  # data_book$convert_column_to_type(data_name=linked_data_name, col_names="s_year", to_type=year_type)
  # 
  # data_book$remove_unused_station_year_combinations(data_name="observations_unstacked_data", year="s_year", station="station_id")
  # 
  # definitions_offset <- data_book$get_offset_term("observations_unstacked_data")
  # end_rain_definition <- data_book$get_end_rains_definition(data_name=linked_data_name, definition_name="end_rain_definition", end_rains_date="end_rains_date", end_rains="end_rains", end_rains_status="end_rains_status", definitions_offset)
  # data_book$add_object(data_name=linked_data_name, object_name="end_rain_definition", object_type_label="structure", object_format="text", object=end_rain_definition)
  # 
  # 
  # rm(list=c("end_of_rains_combined", "conditions_filter", "roll_sum_rain", "grouping_by_station_year", "doy_filter", "end_rains", "end_rains_date", "end_rains_status", "year_type", "station_type", "linked_data_name", "end_rain_definition", "definitions_offset"))
  # 
  # # Dialog: Length of Season
  # length_of_season <- instatCalculations::instat_calculation$new(type="calculation", function_exp="end_rains - start", result_name="length", calculated_from=list("observations_unstacked_data_by_station_id_s_year"="start","observations_unstacked_data_by_station_id_s_year"="end_rains"), save=2)
  # start_end_status <- instatCalculations::instat_calculation$new(type="calculation", function_exp="dplyr::case_when(is.na(start_s) | is.na(end_rains_status) ~ NA_character_, start_s == end_rains_status ~ as.character(start_s), start_s == FALSE & end_rains_status == TRUE ~ 'NONE', start_s == TRUE & end_rains_status == FALSE ~ 'MORE')", result_name="length_status", calculated_from=list("observations_unstacked_data_by_station_id_s_year"="start_s","observations_unstacked_data_by_station_id_s_year"="end_rains_status"), save=2)
  # length_rains_combined <- instatCalculations::instat_calculation$new(type="combination", sub_calculation=list(length_of_season, start_end_status))
  # data_book$run_instat_calculation(calc=length_rains_combined, display=FALSE)
  # 
  # data_book$convert_column_to_type(data_name="observations_unstacked_data_by_station_id_s_year", col_names="length_status", to_type="factor")
  # 
  # data_book$define_as_climatic(data_name="observations_unstacked_data_by_station_id_s_year", key_col_names=NULL, types=c(season_length="length", season_length_status="length_status"), overwrite=FALSE)
  # 
  # length_definition <- data_book$get_seasonal_length_definition(data_name="observations_unstacked_data_by_station_id_s_year", seasonal_length="length", definition_name="length_definition")
  # data_book$add_object(data_name="observations_unstacked_data_by_station_id_s_year", object_name="length_definition", object_type_label="structure", object_format="text", object=length_definition)
  # 
  # 
  # rm(list=c("length_rains_combined", "length_of_season", "start_end_status", "length_definition"))
  # 
  # # Dialog: Spells
  # spell_day <- instatCalculations::instat_calculation$new(calculated_from= list("observations_unstacked_data"="PRECIP"), type="calculation", function_exp="(PRECIP >= 0) & PRECIP <= 0.85", result_name="spell_day", save=0)
  # spell_length <- instatCalculations::instat_calculation$new(type="calculation", result_name="spell_length", sub_calculations=list(spell_day), save=0, function_exp="instatClimatic::spells(x=spell_day)")
  # grouping <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("observations_unstacked_data"="s_year","observations_unstacked_data"="station_id"))
  # spells <- instatCalculations::instat_calculation$new(type="summary", function_exp="max(x=spell_length)", result_name="spells", manipulations=list(spell_length, grouping), save=2)
  # data_book$run_instat_calculation(calc=spells, display=FALSE)
  # 
  # linked_data_name <- data_book$get_linked_to_data_name("observations_unstacked_data", link_cols=c("s_year", "station_id"))
  # data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c("s_year", "station_id"), types=c(station="station_id", year="s_year", dry_spell="spells"), overwrite=FALSE)
  # 
  # Longest_Spells_Definition <- data_book$get_longest_spell_definition(linked_data_name, "spells", definition_name="Longest_Spells_Definition")
  # data_book$add_object(data_name=linked_data_name, object_name="Longest_Spells_Definition", object_type_label="structure", object_format="text", object=Longest_Spells_Definition)
  # 
  # 
  # rm(list=c("spells", "spell_length", "spell_day", "grouping", "linked_data_name", "Longest_Spells_Definition"))
  # 
  # # Dialog: PICSA Crops
  # existing_dfs <- data_book$get_data_names()
  # 
  # 
  # data_book$crops_definitions(data_name="observations_unstacked_data", year="s_year", station="station_id", rain="PRECIP", day="s_doy", plant_days=c(80, 160, 200), plant_lengths=c(120), rain_totals=c(600, 800), start_day="start", season_data_name="observations_unstacked_data_by_station_id_s_year", end_day="end_rains", start_check="both")
  # 
  # new_df_name <- setdiff(data_book$get_data_names(), existing_dfs)
  # 
  # 
  # new_crop_def <- new_df_name[startsWith(new_df_name, "crop_def")]
  # crop_def <- data_book$get_data_frame(new_crop_def)
  # crops_data_definition <- get_crop_definition(crop_def)
  # data_book$add_object(data_name=new_crop_def, object_name="crops_data_definition", object_type_label="structure", object_format="text", object=crops_data_definition)
  # 
  # 
  # new_crop_prop <- new_df_name[startsWith(new_df_name, "crop_prop")]
  # crop_prop <- data_book$get_data_frame(new_crop_prop)
  # crops_proportion_definition <- get_crop_definition(crop_prop)
  # data_book$add_object(data_name=new_crop_prop, object_name="crops_proportion_definition", object_type_label="structure", object_format="text", object=crops_proportion_definition)
  # 
  # 
  # rm(list=c("existing_dfs", "new_df_name", "crops_data_definition", "crop_def", "new_crop_def", "crops_proportion_definition", "crop_prop", "new_crop_prop"))
  # 
  
  
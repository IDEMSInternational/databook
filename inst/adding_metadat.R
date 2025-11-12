devtools::load_all()
data_book <- DataBook$new()

# Dialog: Import Dataset
new_RDS <- readRDS(file="C:/Users/lclem/OneDrive/Documents/data_for_testing_epicsa.RDS")
data_book$import_RDS(data_RDS=new_RDS)

rm(new_RDS)

data_book$get_data_names()

# Right click menu: Delete Row(s)
data_book$remove_rows_in_data(data_name="daily_niger_by_station_name_year", row_names=c("25","26","27","28","29","30","31","32","33"))


data_book$define_as_climatic(data_name = "daily_niger",
                             key_col_names = c("date", "station_name"),
                             types=c(station = "station_name", 
                                     date = "date",
                                     year = "year"))

data_book$define_as_climatic(data_name = "daily_niger_by_station_name_year",
                              key_col_names = c("year", "station_name"),
                              types=c(station = "station_name", 
                                      year = "year",
                                      end_rain = "end_rains",
                                      end_rain_date = "end_rains_date",
                                      end_rain_status = "end_rains_status"),
                             overwrite = FALSE)

data_book$get_variables_metadata("daily_niger_by_station_name_year")

# For SEASONAL LENGTH ##########################################################


# Dialog: Length of Season
length_of_season <- instatCalculations::instat_calculation$new(type="calculation", function_exp="end_rains - start_rain", result_name="length", calculated_from=list("daily_niger_by_station_name_year"="start_rain","daily_niger_by_station_name_year"="end_rains"), save=2)
start_end_status <- instatCalculations::instat_calculation$new(type="calculation", function_exp="dplyr::case_when(is.na(start_rain_status) | is.na(end_rains_status) ~ NA_character_, start_rain_status == end_rains_status ~ as.character(start_rain_status), start_rain_status == FALSE & end_rains_status == TRUE ~ 'NONE', start_rain_status == TRUE & end_rains_status == FALSE ~ 'MORE')", result_name="length_status", calculated_from=list("daily_niger_by_station_name_year"="start_rain_status","daily_niger_by_station_name_year"="end_rains_status"), save=2)
length_rains_combined <- instatCalculations::instat_calculation$new(type="combination", sub_calculation=list(length_of_season, start_end_status))
data_book$run_instat_calculation(calc=length_rains_combined, display=FALSE)
data_book$convert_column_to_type(data_name="daily_niger_by_station_name_year", col_names="length_status", to_type="factor")
rm(list=c("length_rains_combined", "length_of_season", "start_end_status"))

data_book$get_variables_metadata("daily_niger_by_station_name_year")


data_book$define_as_climatic(data_name = "daily_niger_by_station_name_year",
                             key_col_names = NULL,
                             types=c(season_length = "length",
                                     season_length_status = "length_status"),
                             overwrite = FALSE)




#9             length                     integer            <NA>               start_rain,end_rains
#10     length_status                      factor            <NA> start_rain_status,end_rains_status


################################################################################
# 
# 
# # So let's look at running something that creates the new data frame
# # We want to investigate if we can just read the metadata across to the new data frame
# 
# # Dialog: Column Summaries
# data_book$calculate_summary(data_name="daily_niger", columns_to_summarise="day",
#                             factors=c("station_name","year","month"), store_results=TRUE,
#                             return_output=FALSE, summaries=c("summary_count", "summary_sum"), silent=TRUE)
# 
# # We want to add in there like, idk. Something that also reads the variable metadata from one through to the other. 
# # So like, our metadata for our variables in the first data frame get read into that of the new data frame
# # for the columns which are in both
# # e.g.,
# 
# data_book$get_variables_metadata("daily_niger")$Climatic_Type
# data_book$get_variables_metadata("daily_niger_by_station_name_year_month")$Climatic_Type
# 
# # Oh wow, it reads through already here. Ok, neat. Why????  Is that something in data_book$calculate_summary?
# 
# # OK, so it does that for our start rains???
# 
# # Dialog: Start of Rains
# 
# year_type <- data_book$get_column_data_types(data_name="daily_niger_subset", columns="year")
# 
# data_book$convert_column_to_type(data_name="daily_niger_subset", col_names="year", to_type="factor")
# station_type <- data_book$get_column_data_types(data_name="daily_niger_subset", columns="station_name")
# 
# data_book$convert_column_to_type(data_name="daily_niger_subset", col_names="station_name", to_type="factor")
# data_book$convert_linked_variable(from_data_frame="daily_niger_subset", link_cols=c("year", "station_name"))
# grouping_by_station <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("daily_niger_subset"="station_name"))
# roll_sum_rain <- instatCalculations::instat_calculation$new(type="calculation", function_exp="RcppRoll::roll_sumr(x=rain, n=2, fill=NA, na.rm=FALSE)", result_name="roll_sum_rain", calculated_from=list("daily_niger_subset"="rain"), manipulations=list(grouping_by_station))
# conditions_filter <- instatCalculations::instat_calculation$new(type="filter", function_exp="((rain >= 0.85) & roll_sum_rain > 20) | is.na(x=rain) | is.na(x=roll_sum_rain)", sub_calculations=list(roll_sum_rain))
# grouping_by_year <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("daily_niger_subset"="year"))
# doy_filter <- instatCalculations::instat_calculation$new(type="filter", function_exp="doy >= 1 & doy <= 366", calculated_from=databook::calc_from_convert(x=list(daily_niger_subset="doy")))
# start_of_rains_doy <- instatCalculations::instat_calculation$new(type="summary", function_exp="ifelse(test=is.na(x=dplyr::first(x=rain)) | is.na(x=dplyr::first(x=roll_sum_rain)), yes=NA, no=dplyr::first(x=doy, default=NA))", result_name="start_rain", save=2)
# start_rain_date <- instatCalculations::instat_calculation$new(type="summary", function_exp="dplyr::if_else(condition=is.na(x=dplyr::first(x=rain)) | is.na(x=dplyr::first(x=roll_sum_rain)), true=as.Date(NA), false=dplyr::first(date, default=NA))", result_name="start_rain_date", save=2)
# start_of_rains_status <- instatCalculations::instat_calculation$new(type="summary", function_exp="ifelse(n() > 0, ifelse(dplyr::first(is.na(roll_sum_rain)), NA, TRUE), FALSE)", result_name="start_rain_status", save=2)
# start_of_rains_combined <- instatCalculations::instat_calculation$new(type="combination", manipulations=list(grouping_by_station, conditions_filter, grouping_by_year, doy_filter), sub_calculation=list(start_of_rains_doy, start_rain_date, start_of_rains_status))
# data_book$run_instat_calculation(calc=start_of_rains_combined, display=FALSE, param_list=list(drop=FALSE))
# linked_data_name <- data_book$get_linked_to_data_name("daily_niger_subset", link_cols=c("year", "station_name"))
# 
# calculated_from_list <- c(setNames("start_rain_status", linked_data_name), setNames("start_rain", linked_data_name))
# 
# start_rain_status2 <- instatCalculations::instat_calculation$new(type="calculation", function_exp="ifelse(!is.na(start_rain), TRUE, start_rain_status)", calculated_from=calculated_from_list, result_name="start_rain_status", save=2)
# 
# start_rain_combined_status_2 <- instatCalculations::instat_calculation$new(type="combination", sub_calculations=list(start_rain_status2))
# 
# data_book$run_instat_calculation(calc=start_rain_combined_status_2, display=FALSE, param_list=list(drop=FALSE))
# data_book$convert_column_to_type(data_name="daily_niger_subset", col_names="year", to_type=year_type)
# data_book$remove_unused_station_year_combinations(data_name="daily_niger_subset", year="year", station="station_name")
# data_book$convert_linked_variable(from_data_frame="daily_niger_subset", link_cols=c("year", "station_name"))
# rm(list=c("start_of_rains_combined", "grouping_by_station", "conditions_filter", "roll_sum_rain", "grouping_by_year", "doy_filter", "start_of_rains_doy", "start_rain_date", "start_of_rains_status", "year_type", "station_type", "linked_data_name", "calculated_from_list", "start_rain_status2", "start_rain_combined_status_2"))
# 
# data_book$get_variables_metadata("daily_niger")$Climatic_Type
# data_book$get_variables_metadata("daily_niger_subset_by_station_name_year")$Climatic_Type

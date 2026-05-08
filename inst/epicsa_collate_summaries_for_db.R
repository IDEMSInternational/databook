# Collate Summaries
devtools::load_all()
data_book <- DataBook$new()

# Code run from Script Window (selected text)
# Dialog: Import Dataset
new_RDS <- readRDS(file="C:/Users/lclem/OneDrive/Documents/guinea_2_test.RDS")
data_book$import_RDS(data_RDS=new_RDS)

# Dialog: Climatic Transform: Adding "count" variable type.
rain_day <- instatCalculations::instat_calculation$new(type="calculation", function_exp="(rain >= 0.85)", result_name="rain_day", calculated_from= list("guinea_2"="rain"))
group_by_station <- instatCalculations::instat_calculation$new(type="by", calculated_from=list("guinea_2"="station"))
transform_calculation <- instatCalculations::instat_calculation$new(type="calculation", function_exp="zoo::rollapply(data=rain_day, width=1, FUN=sum, align='right', fill=NA)", result_name="count", sub_calculations=list(rain_day), manipulations=list(group_by_station), save=2, before=FALSE, adjacent_column="rain")
data_book$run_instat_calculation(calc=transform_calculation, display=FALSE)

data_book$define_as_climatic(data_name = "guinea_2",
                             key_col_names = NULL,
                             types=c(count = "count"),
                             overwrite = FALSE)
rm(list=c("transform_calculation", "rain_day", "group_by_station"))

# Dialog: Climatic Summary: ANNUAL: Check with sum_rain (total_rain)
data_book$calculate_summary(data_name="guinea_2", columns_to_summarise=c("rain", "count"), factors=c("station", "year"), j=1, summaries=c("summary_count", "summary_sum"), silent=TRUE)
linked_data_name <- data_book$get_linked_to_data_name(from_data_frame="guinea_2", link_cols=c(station="station", year="year"))
summary_variables <- data_book$preview_summary_names(data_name="guinea_2", summaries=c("summary_count", "summary_sum"), columns_to_summarise=c("rain", "count"), factors=c("station", "year"))
types <- data_book$build_climatic_types_from_summary(data_name="guinea_2", base_types=c(station="station", year="year"), columns_to_summarise=c("rain", "count"), summary_variables=summary_variables)
data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c(station="station", year="year"), types=types, overwrite=FALSE)
summary_variables <- data_book$preview_summary_names(data_name="guinea_2", summaries=c("summary_count", "summary_sum"), columns_to_summarise=c("rain", "count"), factors=c("station", "year"))
Annual_Definitions1 <- data_book$get_climatic_summaries_definition(data_name="guinea_2", summary_data=linked_data_name, summary_variables=summary_variables, definition_name="Annual_Definitions1")
data_book$add_object(data_name="guinea_2", object_name="Annual_Definitions1", object_type_label="structure", object_format="text", object=Annual_Definitions1)
rm(list=c("linked_data_name", "types", "summary_variables", "Annual_Definitions1"))

# Dialog: Climatic Summary: MONTHLY: Check with sum_rain (total_rain), sum_count (rain_days)
data_book$calculate_summary(data_name="guinea_2", columns_to_summarise=c("rain","count"), factors=c("station", "month_abbr"), j=1, summaries=c("summary_count", "summary_sum"), silent=TRUE)
linked_data_name <- data_book$get_linked_to_data_name(from_data_frame="guinea_2", link_cols=c(station="station", within_variable="month_abbr"))
summary_variables <- data_book$preview_summary_names(data_name="guinea_2", columns_to_summarise=c("rain","count"), summaries=c("summary_count", "summary_sum"), factors=c("station", "month_abbr"))
types <- data_book$build_climatic_types_from_summary(data_name="guinea_2", columns_to_summarise=c("rain","count"), base_types=c(station="station", within_variable="month_abbr"), summary_variables=summary_variables)
data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c(station="station", within_variable="month_abbr"), types=types, overwrite=FALSE)
summary_variables <- data_book$preview_summary_names(data_name="guinea_2", columns_to_summarise=c("rain","count"), summaries=c("summary_count", "summary_sum"), factors=c("station", "month_abbr"))
Within_Year_Definitions <- data_book$get_climatic_summaries_definition(data_name="guinea_2", summary_data=linked_data_name, summary_variables=summary_variables, definition_name="Within_Year_Definitions")
data_book$add_object(data_name="guinea_2", object_name="Within_Year_Definitions", object_type_label="structure", object_format="text", object=Within_Year_Definitions)

rm(list=c("linked_data_name", "types", "summary_variables", "Within_Year_Definitions"))

# Annual Temperature
# Dialog: Climatic Summary
data_book$calculate_summary(data_name="guinea_2", columns_to_summarise=c("tmax","tmin"), factors=c("station", "year"), j=1, summaries=c("summary_mean", "summary_min", "summary_max"), silent=TRUE)

linked_data_name <- data_book$get_linked_to_data_name(from_data_frame="guinea_2", link_cols=c(station="station", year="year"))
summary_variables <- data_book$preview_summary_names(data_name="guinea_2", columns_to_summarise=c("tmax","tmin"), summaries=c("summary_mean", "summary_min", "summary_max"), factors=c("station", "year"))
types <- data_book$build_climatic_types_from_summary(data_name="guinea_2", columns_to_summarise=c("tmax","tmin"), base_types=c(station="station", year="year"), summary_variables=summary_variables)
data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c(station="station", year="year"), types=types, overwrite=FALSE)

summary_variables <- data_book$preview_summary_names(data_name="guinea_2", columns_to_summarise=c("tmax","tmin"), summaries=c("summary_mean", "summary_min", "summary_max"), factors=c("station", "year"))
temperature_definitions <- data_book$get_climatic_summaries_definition(data_name="guinea_2", summary_data=linked_data_name, summary_variables=summary_variables, definition_name="temperature_definitions")
data_book$add_object(data_name="guinea_2", object_name="temperature_definitions", object_type_label="structure", object_format="text", object=temperature_definitions)

rm(list=c("linked_data_name", "types", "summary_variables", "temperature_definitions"))

# Monthly Temperature

data_book$calculate_summary(data_name="guinea_2", columns_to_summarise="tmax", factors=c("station", "month_abbr"), j=1, summaries=c("summary_mean", "summary_min", "summary_max"), silent=TRUE)
linked_data_name <- data_book$get_linked_to_data_name(from_data_frame="guinea_2", link_cols=c(station="station", within_variable="month_abbr"))
summary_variables <- data_book$preview_summary_names(data_name="guinea_2", columns_to_summarise="tmax", summaries=c("summary_mean", "summary_min", "summary_max"), factors=c("station", "month_abbr"))
types <- data_book$build_climatic_types_from_summary(data_name="guinea_2", columns_to_summarise="tmax", base_types=c(station="station", within_variable="month_abbr"), summary_variables=summary_variables)
data_book$define_as_climatic(data_name=linked_data_name, key_col_names=c(station="station", within_variable="month_abbr"), types=types, overwrite=FALSE)
summary_variables <- data_book$preview_summary_names(data_name="guinea_2", columns_to_summarise="tmax", summaries=c("summary_mean", "summary_min", "summary_max"), factors=c("station", "month_abbr"))
Within_Year_Definitions1 <- data_book$get_climatic_summaries_definition(data_name="guinea_2", summary_data=linked_data_name, summary_variables=summary_variables, definition_name="Within_Year_Definitions1")
data_book$add_object(data_name="guinea_2", object_name="Within_Year_Definitions1", object_type_label="structure", object_format="text", object=Within_Year_Definitions1)

rm(list=c("linked_data_name", "types", "summary_variables", "Within_Year_Definitions1"))


# COLLATING THEM ########################################
annual_rain <- "guinea_2_by_station_year"
monthly_rain <- "guinea_2_by_station_month_abbr"
annual_temp <- "guinea_2_by_station_year"
monthly_temp <- "guinea_2_by_station_month_abbr"

# Annual rainfall
annual_rain_longer <- data_book$build_summary_long(
  data_name = annual_rain,

  time_type = "annual",
  summary_type = "Rain",
  definitions = c("start_rains_definition", "Annual_Definitions1")
)

# Monthly rainfall 
monthly_rain_longer <- data_book$build_summary_long(
  data = monthly_rain,

  time_type = "monthly",
  summary_type = "Rain",
  
  definitions = "Within_Year_Definitions"
)

# Annual temperature
annual_temp_longer <- data_book$build_summary_long(
  data = annual_temp,
  
  time_type = "annual",
  summary_type = "Temperature",
  
  definitions = "temperature_definitions"
)

monthly_temp_longer <- data_book$build_summary_long(
  data = monthly_temp,
  
  time_type = "monthly",
  summary_type = "Temperature",
  definitions = "Within_Year_Definitions1"
)

summary_data_binded <- data_book$collate_summary_definitions(
  annual_rain_longer,
  monthly_rain_longer,
  annual_temp_longer,
  monthly_temp_longer
)

data_book$import_RDS(data_RDS=summary_data_binded)

saveRDS(file="C:/Users/lclem/OneDrive/Documents/summary_data_binded.RDS", object=data_book)
#

# break, then check that the cols are all in and named well.
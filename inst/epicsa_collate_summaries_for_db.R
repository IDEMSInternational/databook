# Collate Summaries
devtools::load_all()
data_book <- DataBook$new()
n = dplyr::n

# Code run from Script Window (selected text)
# Dialog: Import Dataset
new_RDS <- readRDS(file="C:/Users/lclem/OneDrive/Documents/dodoma_testing.RDS")
data_book$import_RDS(data_RDS=new_RDS)

data_book$get_data_names()

# COLLATING THEM ########################################
annual_rain <- "dodoma_by_year"
monthly_rain <- "dodoma_by_month_abbr"
annual_temp <- "dodoma_by_year"
monthly_temp <- "dodoma_by_month_abbr"
annual_monthly_temp <- "dodoma_by_year_month_abbr"

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
  data = monthly_rain,

  time_type = "monthly",
  summary_type = "Temperature",

  definitions = "Within_Year_Definitions"
)

# Monthly Annual Temperature
annual_monthly_temp_longer <- data_book$build_summary_long(
  data_name = annual_monthly_temp,
  
  time_type = "annual-monthly",
  summary_type = "Temperature",
  definitions = "Month_Year_Definitions"
)

# Collate them
summary_data_binded <- data_book$collate_summary_definitions(
  annual_rain_longer,
  monthly_temp_longer,
  annual_monthly_temp_longer
)

View(summary_data_binded$definitions_data)


# Dialog: PICSA Crops
existing_dfs <- data_book$get_data_names()
data_book$crops_definitions(data_name="dodoma", year="year", rain="rain", day="doy_366", plant_days=c(160), plant_lengths=c(120), rain_totals=c(600), start_day="start", season_data_name="dodoma_by_year", end_day="end_rains", start_check="both")
new_df_name <- setdiff(data_book$get_data_names(), existing_dfs)

new_crop_def <- new_df_name[startsWith(new_df_name, "crop_def")]
crop_def <- data_book$get_data_frame(new_crop_def)
saved_crop_def <- get_crop_definition(crop_def)
data_book$add_object(data_name=new_crop_def, object_name="saved_crop_def", object_type_label="structure", object_format="text", object=saved_crop_def)

new_crop_prop <- new_df_name[startsWith(new_df_name, "crop_prop")]
crop_prop <- data_book$get_data_frame(new_crop_prop)
saved_prop_def <- get_crop_definition(crop_prop)
data_book$add_object(data_name=new_crop_prop, object_name="saved_prop_def", object_type_label="structure", object_format="text", object=saved_prop_def)

#crop_summary <- data_book$build_crop_longer("crop_def", NULL, "saved_crop_def", "saved_prop_def")
#crop_summary <- data_book$build_crop_longer(NULL, "crop_prop", "saved_crop_def", "saved_prop_def")
crop_summary <- data_book$build_crop_longer("crop_def", "crop_prop", "saved_crop_def", "saved_prop_def")

# Collate them
summary_data_binded <- data_book$collate_summary_definitions(
  annual_rain_longer,
  monthly_temp_longer,
  annual_monthly_temp_longer,
  crop_summary = crop_summary
)


# data_book$build_crop_longer("crop_def", "crop_prop", "saved_crop_def", "saved_prop_def")

# collate_summary_definitions has crop_summary as an option


# 
# data_book$import_RDS(data_RDS=summary_data_binded)
# 
# saveRDS(file="C:/Users/lclem/OneDrive/Documents/summary_data_binded.RDS", object=data_book)



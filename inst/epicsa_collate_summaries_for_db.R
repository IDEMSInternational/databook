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


# 
# data_book$import_RDS(data_RDS=summary_data_binded)
# 
# saveRDS(file="C:/Users/lclem/OneDrive/Documents/summary_data_binded.RDS", object=data_book)



# Dialog: Import Dataset
data_book <- DataBook$new()
data(ghana)
data_book$import_RDS(data_RDS=ghana)
ghana$get_data_names()

ghana_df <- ghana$get_data_frame("ghana")
ghana_df_by_station_year <- ghana$get_data_frame("ghana_by_station_year")
crop_prop <- ghana$get_data_frame("crop_prop")
crop_def <- ghana$get_data_frame("crop_def")
data_book$delete_dataframes(data_names=c("crop_prop","crop_def"))

# Dialog: PICSA Crops
groups <- dplyr::groups
group_by <- dplyr::group_by

data_book$crops_definitions(data_name="ghana", year="year", station="station", rain="rainfall", day="doy",
                            plant_days=c(100, 150),
                            plant_lengths=c(110),
                            rain_totals=c(370, 400, 500), start_day="start_rain", season_data_name="ghana_by_station_year", end_day="end_rains",
                            start_check="both")

crop_def <- data_book$get_data_frame("crop_def")
crop_prop <- data_book$get_data_frame("crop_prop")




#usethis::use_data(ghana, dodoma, overwrite = TRUE)

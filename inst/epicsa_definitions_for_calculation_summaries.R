devtools::load_all()

data_book <- DataBook$new()

# Dialog: Import Dataset
new_RDS <- readRDS(file="C:/Users/lclem/OneDrive/Documents/Zambia_data_all.RDS")
data_book$import_RDS(data_RDS=new_RDS)

rm(new_RDS)

# Dialog: Calculations

`_df` <- data_book$get_data_frame(data_name="observations_unstacked_data", use_current_filter=FALSE)
attach(what=`_df`)
calc <- 1
data_book$add_columns_to_data(data_name="observations_unstacked_data", col_name="calc", col_data=calc, before=FALSE)

detach(name=`_df`, unload=TRUE)
data_book$append_to_variables_metadata(data_name="observations_unstacked_data", col_names="calc", property="labels", new_val="")
rm(list=c("calc", "`_df`"))

#data_book$rename_column_in_data(data_name="observations_unstacked_data", column_name="count", type="single", new_val="count", label="", case="snake", minlength=8)

data_book$define_as_climatic(data_name="observations_unstacked_data", key_col_names=c(station="station_id", date="date"),
                             types=c(station="station_id", year="s_year", count = c("count")),
                             overwrite=FALSE)

data_book$define_as_climatic(data_name="observations_unstacked_data", key_col_names=c(station="station_id", date="date"),
                             types=c(station="station_id", year="s_year", count = c("extreme_rainfall")),
                             overwrite=FALSE)

cts <- c("PRECIP", "count")#, "extreme_rainfall")#, "count") #, "extreme_rainfall")
s <- c("summary_sum", "summary_count")
# Dialog: Climatic Summary
data_book$calculate_summary(data_name="observations_unstacked_data", columns_to_summarise=cts, factors=c("station_id", "s_year"), j=1, summaries=s, silent=TRUE)

linked_data_name <- data_book$get_linked_to_data_name(from_data_frame="observations_unstacked_data", link_cols=c(station="station_id", year="s_year"))

data_book$get_variables_metadata(linked_data_name)


calculations_data <- data_book$get_calculations(linked_data_name)
variables_metadata <- data_book$get_variables_metadata("observations_unstacked_data")
summary_variables <- data_book$preview_summary_names(data_name="observations_unstacked_data", columns_to_summarise=cts, summaries=s, factors=c("station_id", "s_year"))
daily_data_calculation <- data_book$get_calculations("observations_unstacked_data")


# if I do summary_count for PRECIP and count, it gives one single list with all NAs, because PRECIP count is not needed as a definition
# if I do summary_sum   for PRECIP and count, it gives $total_rain and $n_rain as TRUE
# if I do summary_count and summary_sum for PRECIP, it gives $total_rain TRUE and $n_rain FALSE (so it ignores the irrelevant one: summary_count for rainfall)
# if I do summary_count and summary_sum for count, it gives $total_rain FALSE and $n_rain TRUE  (so it ignores the irrelevant one: summary_count for rainfall)
# if I do summary_count and summary_sum for calc and count, it works for count only (total rain FALSE; n rain TRUE)
# if I do summary_count and summary_sum for calc, it gives error: No Rainfall or Temperature Summaries found to define (only can define sum rain, or min/mean/max temperatures).
# if I do summary_count and summary_sum for PRECIP and count, it combines and uses just summary_sum it because PRECIP count and count count is not needed as a definition
# if I do summary_count and summary_sum for PRECIP and count and extreme_rainfall, it throws an expected error

# Note that it may be called extreme_rain when it's just a count, but that is OK. That just happens, and can be renamed later in the collate_* function.
Annual_Definitions1 <- get_climatic_summaries_definition(calculations_data = calculations_data,
                                                         variables_metadata = variables_metadata,
                                                         summary_variables = summary_variables,
                                                         daily_data_calculation = daily_data_calculation)
Annual_Definitions1


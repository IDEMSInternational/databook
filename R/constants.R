# labels_and_defaults.R ########################################################
#Labels for strings which will be added to logs
Set_property="Set"
Added_col="Added column"
Replaced_col="Replaced column"
Renamed_col="Renamed column"
Removed_col="Removed column"
Added_metadata="Added metadata"
Added_object="Added object"
Added_scalar= "Added scalar"
Added_variables_metadata="Added variables metadata"
Added_filter="Added filter"
Added_column_selection="Added column selection"
Converted_col_="Converted column"
Replaced_value="Replaced value"
Removed_row="Removed row"
Inserted_col = "Inserted column"
Move_col = "Moved column"
Col_order = "Order of columns"
Inserted_row = "Inserted row"
Copy_cols = "Copied columns"
Merged_data = "Merged data"

#meta data labels
data_name_label="data_name"
is_calculated_label="Is_Calculated"
decimal_places_label="Decimal_Places"
columns_label="columns"
summarised_from_label="summarised_from"
key_label="key"
row_count_label="Rows"
column_count_label="Columns"
is_linkable="Is_Linkable"
scalar= "scalars"

#variables_metadata labels
label_label="label"
labels_label="labels"
signif_figures_label="Signif_Figures"
scientific_label="Scientific"
name_label="Name"
is_factor_label="Is_Factor"
#changes because attributes default is class
data_type_label="class"
is_hidden_label="Is_Hidden"
is_protected_label="Is_Protected"
is_frozen_label="Is_Frozen"
is_key_label="Is_Key"
structure_label="Structure"
has_dependants_label="Has_Dependants"
dependent_columns_label="Dependent_Columns"
calculated_by_label="Calculated_By"
dependencies_label="Dependencies"
colour_label="Colour"
set_prefix="set."

#Variables_metadata value labels
structure_type_1_label="Layout"
structure_type_2_label="Treatment"
structure_type_3_label="Measurement"

#object labels
overall_label="[Overall]"
graph_label="graph"
table_label="table"
model_label="model"
summary_label = "summary"

#link labels
keyed_link_label="keyed_link"

max_labels_display=4

# Column Selection Operations
column_selection_operations <- c("base::match", "tidyselect::starts_with", "tidyselect::ends_with", "tidyselect::contains", "tidyselect::matches", "tidyselect::num_range", "tidyselect::last_col", "tidyselect::where")

# instat_comment.R #############################################################
comment_types <- c("critical", "warning", "message", "")

# Climatic Labels ##############################################################
is_climatic_label <- "Is_Climatic"

# labels for climatic column types
rain_label="rain"
rain_day_label="rain_day"
rain_day_lag_label="rain_day_lag"
date_label="date"
doy_label="doy"
s_doy_label = "s_doy"
doy_start_label = "doy_start"
year_label="year"
year_month_label="year_month"
date_time_label="date_time"
dos_label="dos" ##Day of Season
season_label="season"
month_label="month"
day_label="day"
dm_label="day_month"
time_label="time"
station_label="station"
date_asstring_label="date_asstring"
temp_min_label="temp_min"
temp_max_label="temp_max"
hum_min_label="hum_min"
hum_max_label="hum_max"
temp_air_label="temp_air"
temp_range_label="temp_range"
wet_buld_label="wet_bulb"
dry_bulb_label="dry_buld"
evaporation_label="evaporation"
element_factor_label="element_type"
identifier_label = "identifier"
capacity_label = "capacity_max"
wind_speed_label="wind_speed"
wind_direction_label="wind_direction"
lat_label="lat"
lon_label="lon"
alt_label="alt"
season_station_label="season_station"
date_station_label="date_station"
sunshine_hours_label="sunshine_hours"
radiation_label="radiation"
cloud_cover_label="cloud_cover"
district_label = "district"

all_climatic_column_types <- c(rain_label, district_label, rain_day_label, rain_day_lag_label, date_label, doy_label, s_doy_label, year_label, year_month_label, date_time_label, dos_label, season_label, month_label, day_label, dm_label, time_label, station_label, date_asstring_label, temp_min_label, temp_max_label, hum_min_label, hum_max_label, temp_air_label, temp_range_label, wet_buld_label, dry_bulb_label, evaporation_label, element_factor_label, identifier_label, capacity_label, wind_speed_label, wind_direction_label, lat_label, lon_label, alt_label, season_station_label, date_station_label, sunshine_hours_label, radiation_label, cloud_cover_label)

# Column metadata
climatic_type_label <- "Climatic_Type"
is_element_label <- "Is_Element"

# Procurement Labels ###########################################################

### Primary corruption column types
corruption_country_label="country"
corruption_region_label="region"
corruption_procuring_authority_label="procuring_authority"
corruption_award_date_label="award_date"
corruption_fiscal_year_label="fiscal_year"
corruption_signature_date_label="signature_date"
corruption_contract_title_label="contract_title"
corruption_contract_sector_label="contract_sector"
corruption_procurement_category_label="procurement_category"
corruption_winner_name_label="winner_name"
corruption_winner_country_label="winner_country"
corruption_original_contract_value_label="original_contract_value"
corruption_no_bids_received_label="no_bids_received"
corruption_no_bids_considered_label="no_bids_considered"
corruption_method_type_label="method_type"

all_primary_corruption_column_types <- c(corruption_country_label,
                                         corruption_region_label,
                                         corruption_procuring_authority_label,
                                         corruption_award_date_label,
                                         corruption_fiscal_year_label,
                                         corruption_signature_date_label,
                                         corruption_contract_title_label,
                                         corruption_contract_sector_label,
                                         corruption_procurement_category_label,
                                         corruption_winner_name_label,
                                         corruption_winner_country_label,
                                         corruption_original_contract_value_label,
                                         corruption_no_bids_received_label,
                                         corruption_no_bids_considered_label,
                                         corruption_method_type_label)

### Calculated corruption column types
corruption_award_year_label="award_year"
corruption_procedure_type_label="procedure_type"
corruption_country_iso2_label="country_iso2"
corruption_country_iso3_label="country_iso3"
corruption_w_country_iso2_label="w_country_iso2"
corruption_w_country_iso3_label="w_country_iso3"
corruption_procuring_authority_id_label="procuring_authority_id"
corruption_winner_id_label="winner_id"
corruption_foreign_winner_label="foreign_winner"
corruption_ppp_conversion_rate_label="ppp_conversion_rate"
corruption_ppp_adjusted_contract_value_label="ppp_adjusted_contr_value"
corruption_contract_value_cats_label="contr_value_cats"
corruption_procurement_type_cats_label="procurement_type_cats"
corruption_procurement_type_2_label="procurement_type2"
corruption_procurement_type_3_label="procurement_type3"
corruption_signature_period_label="signature_period"
corruption_signature_period_corrected_label="signature_period_corrected"
corruption_signature_period_5Q_label="signature_period5Q"
corruption_signature_period_25Q_label="signature_period25Q"
corruption_signature_period_cats_label="signature_period_cats"
corruption_secrecy_score_label="secrecy_score"
corruption_tax_haven_label="tax_haven"
corruption_tax_haven2_label="tax_haven2"
corruption_tax_haven3_label="tax_haven3"
corruption_tax_haven3bi_label="tax_haven3bi"
corruption_roll_num_winner_label="roll_num_winner"
corruption_roll_num_issuer_label="roll_num_issuer"
corruption_roll_sum_winner_label="roll_sum_winner"
corruption_roll_sum_issuer_label="roll_sum_issuer"
corruption_roll_share_winner_label="roll_share_winner"
corruption_single_bidder_label="single_bidder"
corruption_all_bids_label="all_bids"
corruption_all_bids_trimmed_label="all_bids_trimmed"
corruption_contract_value_share_over_threshold_label="contract_value_share_over_threshold"

all_calculated_corruption_column_types <- c(corruption_award_year_label,
                                            corruption_procedure_type_label,
                                            corruption_country_iso2_label,
                                            corruption_country_iso3_label,
                                            corruption_w_country_iso2_label,
                                            corruption_w_country_iso3_label,
                                            corruption_procuring_authority_id_label,
                                            corruption_winner_id_label,
                                            corruption_procedure_type_label,
                                            corruption_foreign_winner_label,
                                            corruption_ppp_conversion_rate_label,
                                            corruption_ppp_adjusted_contract_value_label,
                                            corruption_contract_value_cats_label,
                                            corruption_procurement_type_cats_label,
                                            corruption_procurement_type_2_label,
                                            corruption_procurement_type_3_label,
                                            corruption_signature_period_label,
                                            corruption_signature_period_corrected_label,
                                            corruption_signature_period_5Q_label,
                                            corruption_signature_period_25Q_label,
                                            corruption_signature_period_cats_label,
                                            corruption_secrecy_score_label,
                                            corruption_tax_haven_label,
                                            corruption_tax_haven2_label,
                                            corruption_tax_haven3_label,
                                            corruption_tax_haven3bi_label,
                                            corruption_roll_num_winner_label,
                                            corruption_roll_num_issuer_label,
                                            corruption_roll_sum_winner_label,
                                            corruption_roll_sum_issuer_label,
                                            corruption_roll_share_winner_label,
                                            corruption_single_bidder_label,
                                            corruption_all_bids_label,
                                            corruption_all_bids_trimmed_label,
                                            corruption_contract_value_share_over_threshold_label
)

corruption_ctry_iso2_label="iso2"
corruption_ctry_iso3_label="iso3"
corruption_ctry_ss_2009_label="ss_2009"
corruption_ctry_ss_2011_label="ss_2011"
corruption_ctry_ss_2013_label="ss_2013"
corruption_ctry_ss_2015_label="ss_2015"
corruption_ctry_small_state_label="small_state"

all_primary_corruption_country_level_column_types <- c(corruption_country_label,
                                                       corruption_ctry_iso2_label,
                                                       corruption_ctry_iso3_label,
                                                       corruption_ctry_ss_2009_label,
                                                       corruption_ctry_ss_2011_label,
                                                       corruption_ctry_ss_2013_label,
                                                       corruption_ctry_ss_2015_label,
                                                       corruption_ctry_small_state_label
)

# Column metadata for corruption colums
corruption_type_label = "Procurement_Type"
corruption_output_label = "Is_Corruption_Risk_Output"
corruption_red_flag_label = "Is_Corruption_Red_Flag"
corruption_index_label = "Is_CRI_Component"

# Data frame metadata for corruption dataframes
corruption_data_label = "Is_Procurement_Data"
corruption_contract_level_label = "Contract_Level"
corruption_country_level_label = "Country_Level"

# options by Context Labels ####################################################
option_1_label <- "option_1"
option_other_label <- "option_other"
context_1_label <- "context_1"
context_2_label <- "context_2"
context_3_label <- "context_3"
context_4_label <- "context_4"
context_other_label <- "context_other"
measurement_1_label <- "measurement_1"
measurement_other_label <- "measurement_other"
id_1_label <- "id_1"
id_other_label <- "id_other"
blocking_1_label <- "blocking_1"
blocking_other_label <- "blocking_other"

obyc_all_types <- c(option_1_label, option_other_label, context_1_label, context_2_label, context_3_label, context_4_label, context_other_label, measurement_1_label, measurement_other_label, id_1_label, id_other_label, blocking_1_label, blocking_other_label)

# Column metadata
obyc_type_label = "O_by_C_Type"

# Data frame metadata
is_obyc_label = "Is_O_by_C"

# Calculation.R Labels #########################################################
c_data_label <- "data"
c_link_label <- "link"
c_has_summary_label <- "has_summary"
c_has_filter_label <- "has_filter"


# Summary.R Labels #############################################################
# summary function labels
sum_label <- "summary_sum"
mode_label <- "summary_mode"
count_label <- "summary_count_all"
count_missing_label <- "summary_count_miss"
count_non_missing_label <- "summary_count"
sd_label <- "summary_sd"
var_label <- "summary_var"
median_label <- "summary_median"
range_label <- "summary_range"
min_label <- "summary_min"
max_label <- "summary_max"
mean_label <- "summary_mean"
trimmed_mean_label <- "summary_trimmed_mean"
quartile_label <- "summary_quartile"
p10_label <- "p10"
p20_label <- "p20"
p25_label <- "p25"
p30_label <- "p30"
p33_label <- "p33"
p40_label <- "p40"
p60_label <- "p60"
p67_label <- "p67"
p70_label <- "p70"
p75_label <- "p75"
p80_label <- "p80"
p90_label <- "p90"
skewness_label <- "summary_skewness"
summary_skewness_mc_label <- "summary_skewness_mc"
summary_outlier_limit_label <- "summary_outlier_limit"
kurtosis_label <- "summary_kurtosis"
summary_coef_var_label <- "summary_coef_var"
summary_median_absolute_deviation_label <- "summary_median_absolute_deviation"
summary_Qn_label <- "summary_Qn"
summary_Sn_label <- "summary_Sn"
cor_label <- "summary_cor"
cov_label <- "summary_cov"
first_label <- "summary_first"
last_label <- "summary_last"
nth_label <- "summary_nth"
n_distinct_label <- "summary_n_distinct"
proportion_label <- "proportion_calc"
count_calc_label <- "count_calc"
standard_error_mean_label <- "standard_error_mean"
circular_mean_label <- "summary_circular_mean"
circular_median_label <- "summary_circular_median"
circular_medianHL_label <- "summary_circular_medianHL"
circular_min_label <- "summary_circular_min"
circular_max_label <- "summary_circular_max"
circular_Q1_label <- "summary_circular_Q1"
circular_Q3_label <- "summary_circular_Q3"
circular_quantile_label <- "summary_circular_quantile"
circular_sd_label <- "summary_circular_sd"
circular_var_label <- "summary_circular_var"
circular_ang_dev_label <- "summary_circular_ang_dev"
circular_ang_var_label <- "summary_circular_ang_var"
circular_rho_label <- "summary_circular_rho"
circular_range_label <- "summary_circular_range"
mean_error_label <- "me"
mean_absolute_error_label <- "mae"
root_mean_square_error_label <- "rmse"
normalised_mean_square_error_label <- "nrmse"
percent_bias_label <- "PBIAS"
nash_Sutcliffe_efficiency_label <- "NSE"
modified_Nash_Sutcliffe_efficiency_label <- "mNSE"
relative_Nash_Sutcliffe_efficiency_label <- "rNSE"
Index_of_agreement_label <- "d"
modified_index_of_aggrement_label <- "md"
relative_index_of_agreement_label <- "rd"
coefficient_of_determination_label <- "R2"
coefficient_of_persistence_label <- "cp"
kling_Gupta_efficiency_label <- "KGE"
mean_squared_error_label <- "mse"
ratio_of_standard_deviations_label <- "rSD"
ratio_of_RMSE_label <- "rsr"
sum_of_squared_residuals_label <- "ssq"
volumetric_efficiency_label <- "VE"
which_min_label <- "summary_which_min"
which_max_label <- "summary_which_max"
where_min_label <- "summary_where_min"
where_max_label <- "summary_where_max"


# list of all summary function names
# the order of this list determines the order summaries appears in certain functions
all_summaries <- c(
  count_label, count_non_missing_label, count_missing_label,
  min_label, p10_label, p20_label, p25_label, p30_label, p33_label, p40_label, p60_label, p67_label, p70_label, p75_label, p80_label, p90_label, quartile_label, median_label,
  summary_median_absolute_deviation_label, summary_coef_var_label,
  summary_Qn_label, summary_Sn_label,
  mode_label, mean_label, which_min_label, which_max_label,where_max_label,
  trimmed_mean_label, max_label, sum_label, where_min_label,
  sd_label, var_label, range_label, standard_error_mean_label,
  skewness_label, summary_skewness_mc_label, kurtosis_label,
  summary_outlier_limit_label,
  cor_label, cov_label, first_label, last_label, nth_label, n_distinct_label,
  proportion_label, count_calc_label,
  circular_min_label, circular_Q1_label, circular_quantile_label,
  circular_median_label, circular_medianHL_label, circular_mean_label,
  circular_Q3_label, circular_max_label,
  circular_sd_label, circular_var_label, circular_range_label,
  circular_ang_dev_label, circular_ang_var_label, circular_rho_label,
  mean_error_label, mean_absolute_error_label, root_mean_square_error_label,
  normalised_mean_square_error_label, percent_bias_label, nash_Sutcliffe_efficiency_label,
  modified_Nash_Sutcliffe_efficiency_label, relative_Nash_Sutcliffe_efficiency_label,
  Index_of_agreement_label, modified_index_of_aggrement_label, relative_index_of_agreement_label,
  coefficient_of_determination_label, coefficient_of_persistence_label,
  kling_Gupta_efficiency_label, mean_squared_error_label, ratio_of_standard_deviations_label,
  ratio_of_RMSE_label, sum_of_squared_residuals_label, volumetric_efficiency_label
)

# which of the summaries should return a Date value when x is a Date?
date_summaries <- c(
  min_label, p10_label, p20_label, p25_label, p30_label, p33_label, p40_label, p60_label, p67_label, p70_label, p75_label, p80_label, p90_label, quartile_label, median_label,
  mode_label, mean_label, trimmed_mean_label, which_min_label, which_max_label, where_min_label,
  max_label, first_label, last_label, nth_label, where_max_label,
  circular_min_label, circular_Q1_label, circular_quantile_label,
  circular_median_label, circular_medianHL_label, circular_mean_label,
  circular_Q3_label, circular_max_label
)

#Variables_metadata value labels
structure_type_1_label="Layout"
structure_type_2_label="Treatment"
structure_type_3_label="Measurement"

#Labels for strings which will be added to logs
Set_property="Set"

Added_col="Added column"
Replaced_col="Replaced column"
Renamed_col="Renamed column"
Removed_col="Removed column"
Added_metadata="Added metadata"
Added_object="Added object"
Added_scalar= "Added scalar"
Added_variables_metadata="Added variables metadata"
Added_filter="Added filter"
Added_column_selection="Added column selection"
Converted_col_="Converted column"
Replaced_value="Replaced value"
Removed_row="Removed row"
Inserted_col = "Inserted column"
Move_col = "Moved column"
Col_order = "Order of columns"
Inserted_row = "Inserted row"
Copy_cols = "Copied columns"
Merged_data = "Merged data"

#meta data labels
data_name_label="data_name"
is_calculated_label="Is_Calculated"
decimal_places_label="Decimal_Places"
columns_label="columns"
summarised_from_label="summarised_from"
key_label="key"
row_count_label="Rows"
column_count_label="Columns"
is_linkable="Is_Linkable"
scalar = "scalars"
colour_label="Colour"
is_frozen_label="Is_Frozen"
is_hidden_label="Is_Hidden"  ## check if we need this.

#variables_metadata labels
label_label="label"
data_type_label="class"
labels_label="labels"
signif_figures_label="Signif_Figures"
scientific_label="Scientific"
name_label="Name"
is_factor_label="Is_Factor"

#changes because attributes default is class
is_protected_label="Is_Protected"
is_key_label="Is_Key"
structure_label="Structure"
has_dependants_label="Has_Dependants"
dependent_columns_label="Dependent_Columns"
calculated_by_label="Calculated_By"
dependencies_label="Dependencies"
set_prefix="set."

#object labels
overall_label="[Overall]"
graph_label="graph"
table_label="table"
model_label="model"
summary_label = "summary"

#link labels
keyed_link_label="keyed_link"

max_labels_display=4

# Column Selection Operations
column_selection_operations <- c("base::match", "tidyselect::starts_with", "tidyselect::ends_with", "tidyselect::contains", "tidyselect::matches", "tidyselect::num_range", "tidyselect::last_col", "tidyselect::where")




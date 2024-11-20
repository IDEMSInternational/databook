# Data frame metadata

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

all_climatic_column_types <- c(rain_label, rain_day_label, rain_day_lag_label, date_label, doy_label, s_doy_label, year_label, year_month_label, date_time_label, dos_label, season_label, month_label, day_label, dm_label, time_label, station_label, date_asstring_label, temp_min_label, temp_max_label, hum_min_label, hum_max_label, temp_air_label, temp_range_label, wet_buld_label, dry_bulb_label, evaporation_label, element_factor_label, identifier_label, capacity_label, wind_speed_label, wind_direction_label, lat_label, lon_label, alt_label, season_station_label, date_station_label, sunshine_hours_label, radiation_label, cloud_cover_label)

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

# Calculation.R Labels #########################################################
c_data_label <- "data"
c_link_label <- "link"
c_has_summary_label <- "has_summary"
c_has_filter_label <- "has_filter"
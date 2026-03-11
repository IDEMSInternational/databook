#' Is Climatic Element
#' @description
#' Check if the column name is a climatic element.
#'
#' @param x Character, the name of the column.
#'
#' @return Logical, TRUE if the column is a climatic element, FALSE otherwise.
is_climatic_element = function(x) {
  return(x %in% c(rain_label, rain_day_label, rain_day_lag_label, temp_min_label, temp_max_label, temp_air_label,
                  temp_range_label, wet_buld_label, dry_bulb_label, evaporation_label, capacity_label, wind_speed_label,
                  wind_direction_label, sunshine_hours_label, radiation_label, cloud_cover_label,
                  count_label,
                  start_rain_label, start_rain_date_label, start_rain_status_label, 
                  end_rain_label, end_rain_date_label, end_rain_status_label, 
                  end_season_label, end_season_date_label, end_season_status_label,
                  season_length_label, season_length_status_label, dry_spell_label,
                  plant_day_label, plant_length_label,
                  rain_total_label, rain_total_actual_label,
                  overall_cond_with_start_label, overall_cond_no_start_label,
                  prop_success_with_start_label, prop_success_no_start_label))
}
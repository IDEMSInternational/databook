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
                  wind_direction_label, sunshine_hours_label, radiation_label, cloud_cover_label))
}
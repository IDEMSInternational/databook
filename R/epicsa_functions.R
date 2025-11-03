#' Extract rain-day count rule (sign and threshold)
#'
#' Parses the rain-day definition embedded in a daily-data calculation list
#' (from R-Instat style objects) and returns the comparison sign and threshold
#' used to count a "rain day" (e.g., `">="` and `"1"`).
#'
#' @param daily_data_calcs A list-like object of daily data calculations
#'   passed to \code{get_r_instat_definitions()}.
#' @param rainfall_column Character. Name of the rain-related element in
#'   \code{daily_data_calcs} to inspect (default \code{"extreme_rain"}).
#' @param list_name Optional name; if given, the result is wrapped and named
#'   with this value.
#'
#' @return A list with elements \code{sign} and \code{threshold}.
#'   If \code{list_name} is supplied, returns a named list of that list.
#'
#' @examples
#' # res <- get_rain_count_variable(daily_data_calcs, "rain_days")
#' # res$sign      # e.g. ">="
#' # res$threshold # e.g. "1"
#' @seealso get_r_instat_definitions()
#' @export
get_rain_count_variable <- function(daily_data_calcs,
                                    rainfall_column = "extreme_rain",
                                    list_name = NULL) {
  result <- list(sign = NA, threshold = NA)
  
  definitions_in_raw <- get_r_instat_definitions(daily_data_calcs)
  
  if (!is.null(definitions_in_raw) && !is.null(rainfall_column)) {
    definition <- definitions_in_raw[[rainfall_column]]
    definition_rain_day_value <- definition$rain_day[[2]]
    
    # Extract components
    result$sign <- sub(".*\\s([<>]=?|==|!=)\\s.*", "\\1", definition_rain_day_value)
    result$threshold <- sub(".*\\s([<>]=?|==|!=)\\s*(-?\\d*\\.?\\d+)\\s*\\)?", "\\2", definition_rain_day_value)
  }
  
  if (!is.null(list_name)) {
    return(setNames(list(result), list_name))
  } else {
    return(result)
  }
}

#' Get "Start of Rains" definition bundle
#'
#' Collects the parameters that define the "start of rains" calculation from
#' R-Instat-style calculation objects, including whether DOY, date and/or
#' status outputs are required, and adds the start-of-year offset.
#'
#' @param summary_data Summary data.frame used to check presence of status col.
#' @param calculations_data A list of calculation objects (R-Instat style).
#' @param start_rain,start_rain_date,start_rain_status Character column names
#'   in \code{calculations_data} identifying the desired definitions. Supply
#'   any combination; output fields are inferred.
#' @param definitions_offset The value of the offset term, found by `data_book$get_offset_term()`
#'
#' @return A list with parsed definition elements plus:
#'   \itemize{
#'     \item \code{output}: which outputs to produce (\code{"doy"}, \code{"date"}, \code{"status"})
#'   }
#'
#' @details Requires external helpers \code{get_offset_term()}, \code{create_start_rains_definitions()},
#'   and \code{get_r_instat_definitions()} to exist.
#'
#' @examples
#' # def <- get_start_rains_definition(daily, yearly, calcs,
#' #                                   start_rain = "start_of_rains_doy",
#' #                                   start_rain_date = "start_of_rains_date",
#' #                                   start_rain_status = "start_of_rains_status")
#' @seealso create_start_rains_definitions(), get_r_instat_definitions()
#' @export
get_start_rains_definition <- function(summary_data, calculations_data, start_rain = NULL, start_rain_date = NULL, start_rain_status = NULL, definitions_offset = NULL){
  # 1. Get the offset term
  
  # 2. Get the definitions data
  # TODO: For efficiency, we should have that you call in what you want to get definition for (e.g., start_rain, start_rain_date, start_rain_status)
  definitions_year <- get_r_instat_definitions(calculations_data)
  
  # 3. Get the start of rains definitions
  if (!is.null(start_rain)){
    output_value <- "doy"
    start_of_rains <- create_start_rains_definitions(definitions_year[[start_rain]])
    if (!is.null(start_rain_date)){
      output_value <- c(output_value, "date")
    }
  } else {
    if (!is.null(start_rain_date)){
      output_value <- c("date")
      start_of_rains <- create_start_rains_definitions(definitions_year[[start_rain_date]])
    } else if (!is.null(start_rains_status)){
      output_value <- c("status")
      start_of_rains <- create_start_rains_definitions(definitions_year[[start_rain_status]])
    } else {
      start_of_rains <- create_start_rains_definitions(definitions_year[[""]])
      return(start_of_rains)
    }
  }
  if (!is.null(start_rain_status) && !is.null(summary_data[[start_rain_status]])){
    start_of_rains$include_status <- TRUE
    start_of_rains$output <- NA
    start_of_rains$s_start_doy <- NA
    output_value <- unique(c(output_value, "status"))
  }
  start_of_rains$output <- output_value
  start_of_rains$s_start_doy <- definitions_offset
  return(start_of_rains)
}

#' Get "End of Rains" definition bundle
#'
#' Collects parameters defining the end-of-rains calculation and augments with
#' requested outputs and DOY offset.
#'
#' @inheritParams get_start_rains_definition
#' @param end_rains,end_rains_date,end_rains_status Character names in
#'   \code{calculations_data} to locate definitions.
#'
#' @return A list of parsed definition elements plus \code{output} and
#'   \code{s_end_doy}.
#' @seealso create_end_rains_definitions(), get_r_instat_definitions()
#' @export
get_end_rains_definition <- function(summary_data, calculations_data, end_rains = NULL, end_rains_date = NULL, end_rains_status = NULL, definitions_offset = NULL){
  # 1. Get the offset term

  # 2. Get the definitions data
  # TODO: For efficiency, we should have that you call in what you want to get definition for (e.g., end_rains, end_rains_date, end_rains_status)
  definitions_year <- get_r_instat_definitions(calculations_data)
  
  # 3. Get the start of rains definitions
  if (!is.null(end_rains)){
    output_value <- "doy"
    end_of_rains <- create_end_rains_definitions(definitions_year[[end_rains]])
    if (!is.null(end_rains_date)){
      output_value <- c(output_value, "date")
    }
  } else {
    if (!is.null(end_rains_date)){
      output_value <- c("date")
      end_of_rains <- create_end_rains_definitions(definitions_year[[end_rains_date]])
    } else if (!is.null(end_rains_status)){
      # check this
      output_value <- c("status")
      end_of_rains <- create_end_rains_definitions(definitions_year[[end_rains_status]])
    } else {
      end_of_rains <- create_end_rains_definitions(definitions_year[[""]])
      end_of_rains$output <- NA
      end_of_rains$s_start_doy <- NA
      return(end_of_rains)
    }
  }
  if (!is.null(end_rains_status) && !is.null(summary_data[[end_rains_status]])){
    end_of_rains$include_status <- TRUE
    output_value <- unique(c(output_value, "status"))
  }
  end_of_rains$output <- output_value
  end_of_rains$s_start_doy <- definitions_offset
  return(end_of_rains)
}

#' Get "End of Season" definition bundle
#'
#' Collects parameters defining the end-of-season calculation (water balance
#' logic) and augments with requested outputs and DOY offset.
#'
#' @inheritParams get_start_rains_definition
#' @param end_season,end_season_date,end_season_status Character names in
#'   \code{calculations_data} to locate definitions.
#'
#' @return A list of parsed definition elements plus \code{output} and
#'   \code{s_end_doy}.
#' @seealso create_end_season_definitions(), get_r_instat_definitions()
#' @export
get_end_season_definition <- function(summary_data, calculations_data, end_season = NULL, end_season_date = NULL, end_season_status = NULL, definitions_offset = NULL){
  # 1. Get the offset term

  # 2. Get the definitions data
  # TODO: For efficiency, we should have that you call in what you want to get definition for (e.g., end_season, end_season_date, end_season_status)
  definitions_year <- get_r_instat_definitions(calculations_data)
  
  # 3. Get the start of rains definitions
  if (!is.null(end_season)){
    output_value <- "doy"
    end_of_season <- create_end_season_definitions(definitions_year[[end_season]])
    if (!is.null(end_season_date)){
      output_value <- c(output_value, "date")
    }
  } else {
    if (!is.null(end_season_date)){
      output_value <- c("date")
      end_of_season <- create_end_season_definitions(definitions_year[[end_season_date]])
    } else if (!is.null(end_season_status)){
      output_value <- c("status")
      end_of_season <- create_end_season_definitions(definitions_year[[end_season_status]])
    } else {
      end_of_season <- create_end_season_definitions(definitions_year[[""]])
      end_of_season$output <- NA
      end_of_season$s_start_doy <- NA
      return(end_of_season)
    }
  }
  if (!is.null(end_season_status) && !is.null(summary_data[[end_season_status]])){
    end_of_season$include_status <- TRUE
    output_value <- unique(c(output_value, "status"))
  }
  end_of_season$output <- output_value
  end_of_season$s_start_doy <- definitions_offset
  return(end_of_season)
}

#' Get "Season Length" definition bundle
#'
#' Returns parsed season-length definition parameters from calculation objects.
#'
#' @param calculations_data A list of calculation objects (R-Instat style).
#' @param seasonal_length Character. Name in \code{calculations_data} for the
#'   season-length definition.
#'
#' @return A list of parsed season-length parameters.
#' @seealso get_r_instat_definitions()
#' @export
get_seasonal_length_definition <- function(calculations_data, seasonal_length){
  # 1. Get the definitions data
  # TODO: For efficiency, we should have that you call in what you want to get definition for (e.g., end_season, end_season_date, end_season_status)
  definitions_year <- get_r_instat_definitions(calculations_data)
  
  # 2. Get the start of rains definitions
  seasonal_length <- create_season_length_definitions(definitions_year[[seasonal_length]])
  
  return(seasonal_length)
}

#' Get total rainfall / rain-day definition bundle
#'
#' Collects NA-handling parameters and (optionally) the rain-day threshold used
#' to compute annual/seasonal totals and counts.
#'
#' @param calculations_data A list of calculation objects (R-Instat style).
#' @param total_rain Character or NULL. Name of total-rain definition in
#'   \code{calculations_data}. If non-NULL, \code{total_rain = "TRUE"} is set.
#' @param rain_days Character or NULL. Name of rain-day count definition in
#'   \code{calculations_data}. If non-NULL, \code{n_rain = "TRUE"} is set.
#' @param daily_data_calculation A list of daily-data calculations (used by
#'   \code{get_rain_count_variable()}).
#' @param rain_days_variable_from Character. Element name inside
#'   \code{daily_data_calculation} that holds the rain-day threshold rule.
#'
#' @return A list with elements \code{total_rain}, \code{n_rain},
#'   \code{na_rm}, \code{na_n}, \code{na_n_non}, \code{na_consec},
#'   \code{na_prop}, and \code{rain_day} (numeric threshold).
#'
#' @seealso get_rain_count_variable(), get_r_instat_definitions()
#' @export
get_rainfall_definition <- function(calculations_data, total_rain = NULL, rain_days = NULL,
                                    daily_data_calculation = NULL, rain_days_variable_from = NULL){
  #### 1. Set up
  definitions_year <- get_r_instat_definitions(calculations_data)
  
  #### 2. TOTAL RAINFALL ########
  # variable names for total rain and rainy days
  total_rain_definition <- definitions_year[[total_rain]]
  rain_days_definition <- definitions_year[[rain_days]]
  if (!is.null(total_rain)){
    total_rain <- "TRUE"
  } else {
    total_rain <- "FALSE"
  }
  
  if (!is.null(rain_days)){
    n_rain <- "TRUE"
  } else {
    n_rain <- "FALSE"
  }
  
  # 3. Getting the threshold definition for a rain day from the daily data.
  if (as.logical(n_rain)){
    n_raindays <- get_rain_count_variable(daily_data_calculation, rain_days_variable_from)$threshold
  }
  
  # 4. adding in the params for seasonal/annual_rain ----------------------------------------
  if (as.logical(total_rain) || as.logical(n_rain)) {
    if (as.logical(total_rain) == FALSE) total_rain_definition <- rain_days_definition # setting this so that na.rm can all run for it as a back up.
    na_rm <- extract_value(total_rain_definition$function_exp, "na.rm = ", FALSE)
    na_n <- extract_value(total_rain_definition$function_exp, "na_max_n = ", TRUE)
    na_n_non <- extract_value(total_rain_definition$function_exp, "na_min_n = ", TRUE)
    na_consec <- extract_value(total_rain_definition$function_exp, "na_consecutive_n = ", TRUE)
    na_prop <- extract_value(total_rain_definition$function_exp, "na_max_prop = ", TRUE)
    
    variables_list = c("total_rain", "n_rain", "na_rm",
                       "na_n", "na_n_non", "na_consec", "na_prop")
    
    # Create an empty list
    data_list <- list()
    
    # Loop through variables and add to the list if defined
    for (variable in variables_list) {
      if (exists(variable) && !is.na(get(variable))) {
        data_list[[variable]] <- get(variable)
      } else {
        data_list[[variable]] <- NA
      }
    }
    data_list[["rain_day"]] <- as.numeric(n_raindays) # for rain day threshold
  } else {
    for (variable in variables_list) {
      data_list[[variable]] <- NA
    }
  }
  
  return(data_list)
}


#' Extract "extreme rain" definition bundle
#'
#' Thin wrapper around \code{get_rain_count_variable()} for an extreme-rain
#' threshold definition.
#'
#' @param daily_data_calculation Daily-data calculations list.
#' @param extreme_rainfall Character name of the element holding the rule.
#'
#' @return A list with \code{sign} and \code{threshold}.
#' @seealso get_rain_count_variable()
#' @export
get_extreme_rain_definition <- function(daily_data_calculation, extreme_rainfall){
  get_rain_count_variable(daily_data_calculation, extreme_rainfall)
}


#' Get longest dry/wet spell definition bundle
#'
#' Extracts spell window \code{from}/\code{to} parameters from a spell
#' definition in the calculation list.
#'
#' @param calculations_data A list of calculation objects.
#' @param spell_column Character. Name of the spell definition in
#'   \code{calculations_data}.
#' @param definitions_offset The value of the offset term, found by `data_book$get_offset_term()`
#' 
#' @return A list with elements \code{spell_from}, \code{spell_to}.
#' @export
get_longest_spell_definition <- function(calculations_data, spell_column, definitions_offset = 1){
  definitions_year <- get_r_instat_definitions(calculations_data)
  
  # Create an empty list
  data_list <- list()
  
  if (!is.null(spell_column)) spell <- definitions_year[[spell_column]]
  else spell <- NULL
  
  parse_spell <- function(expr) {
    if (is.null(expr) || is.na(expr) || !nzchar(expr)) {
      return(list(direction = NA_character_, value = NA_real_, value_lb = NA_real_))
    }
    # Grab operators and numbers in order of appearance
    ops  <- stringr::str_match_all(expr, "(<=|>=|<|>)")[[1]][,2]
    nums <- as.numeric(stringr::str_extract_all(expr, "\\d+(?:\\.\\d+)?")[[1]])
    
    # Indices of lower/upper bound ops
    lo_idx <- which(ops %in% c(">=", ">"))[1]
    hi_idx <- which(ops %in% c("<=", "<"))[1]
    lo_val <- if (!is.na(lo_idx)) nums[lo_idx] else NA_real_
    hi_val <- if (!is.na(hi_idx)) nums[hi_idx] else NA_real_
    
    direction <-
      if (all(c(">=","<=") %in% ops)) "between" else
        if (all(c(">","<")   %in% ops)) "outer"   else
          if (any(ops %in% c(">=", ">"))) "greater" else
            if (any(ops %in% c("<=", "<"))) "less"    else NA_character_
    
    # Map to value/value_lb consistently
    out <- switch(direction,
                  "between" = list(direction = direction, value_lb = lo_val, value = hi_val),
                  "outer"   = list(direction = direction, value_lb = hi_val, value = lo_val),
                  "greater" = list(direction = direction, value_lb = NA_real_, value = lo_val),
                  "less"    = list(direction = direction, value_lb = NA_real_, value = hi_val),
                  list(direction = NA_character_, value = NA_real_, value_lb = NA_real_)
    )
    out
  }
  
  # --- Your block, simplified ---
  if (!is.null(spell)) {
    spell_calculation <- spell$spell_length$spell_day[[2]]
    parsed <- parse_spell(spell_calculation)
    
    data_list[["direction"]] <- parsed$direction
    data_list[["value"]]     <- parsed$value
    data_list[["value_lb"]]  <- parsed$value_lb
  } else {
    data_list[["value"]]    <- NA_real_
    data_list[["value_lb"]] <- NA_real_
  }
  
  if (!is.null(spell$filter_2)){
    start_day <- extract_value(spell$filter_2, " >= ")
    data_list[["start_day"]] <- start_day
  } else {
    data_list[["start_day"]] <- 1
  }
  if (!is.null(spell$filter_2)){
    start_day <- extract_value(spell$filter_2, " <= ")
    data_list[["end_day"]] <- end_day
  } else {
    data_list[["end_day"]] <- 366
  }

  data_list[["s_start_doy"]] <- definitions_offset
  data_list[["return_max_spell"]] <- "TRUE"
  data_list[["return_all_spells"]] <- "TRUE"
  return(data_list)
}

#' Get crop-related definition bundles
#'
#' Reads crop parameter grids (e.g., water requirements, planting dates/length)
#' and, where appropriate, compresses evenly spaced vectors into \code{from/to/by}.
#'
#' @param definition_file A data.frame with columns like \code{rain_total},
#'   \code{plant_day}, \code{plant_length}. If \code{NULL}, NAs are returned.
#' @param definitions_offset The value of the offset term, found by `data_book$get_offset_term()`
#'
#' @return A list with elements \code{water_requirements}, \code{planting_dates},
#'   \code{planting_length}. Each element is either a vector or a list with
#'   \code{from/to/by}.
#' @export
get_crop_definition <- function(definition_file = NULL, definitions_offset = 1){
  variables_list <- c("water_requirements", "planting_dates", "planting_length", "s_start_doy", "start_check")
  data_list <- list()
  
  get_seq_values <- function(value) {
    if (length(value) < 3) return(value)
    
    from <- value[1]
    to <- value[length(value)]
    by <- (to - from) / (length(value) - 1)
    
    # Reconstruct the sequence
    reconstructed <- seq(from, to, by)
    
    # Check if reconstructed sequence exactly matches original
    if (all.equal(value, reconstructed) == TRUE) {
      return(list(from = from, to = to, by = by))
    } else {
      return(value)
    }
  }
  
  if (!is.null(definition_file)){
    water_requirements <- get_seq_values(unique(definition_file$rain_total))
    planting_dates <- get_seq_values(unique(definition_file$plant_day))
    planting_length <- get_seq_values(unique(definition_file$plant_length))
  }
  
  # Loop through variables and add to the list if defined
  for (variable in variables_list) {
    if (exists(variable) && !anyNA(get(variable))) {
      data_list[[variable]] <- get(variable)
    } else {
      data_list[[variable]] <- NA
    }
  }
  
  if (all(c("overall_cond_with_start", "overall_cond_no_start") %in% names(definition_file))){
    data_list$start_check <- "TRUE"
  } else if (all(c("prop_success_with_start", "prop_success_no_start") %in% names(definition_file))){
    data_list$start_check <- "TRUE"    
  } else {
    data_list$start_check <- "FALSE"
  }
  
  data_list$s_start_doy <- definitions_offset
  data_list$return_crops_table <- "TRUE"
  
  return(data_list)
}

# TODO: How does this differ to getting the sum rain, sum rain days?
# It will be in the same dlg.
#' Extract temperature summary definition
#'
#' For a set of temperature columns, pull the NA rules (\code{na.rm},
#' \code{na_max_n}, \code{na_min_n}, \code{na_consecutive_n}, \code{na_max_prop})
#' from their corresponding summary definitions.
#'
#' @param calculations_data A list of calculation objects (R-Instat style).
#' @param cols Character vector of temperature summary keys (e.g., \code{"tmax"},
#'   \code{"tmin"}, \code{"tmean"} as defined in \code{calculations_data}).
#' @param variables_metadata The variables metadata for the data set. Found by `data_book$get_variables_metadata()`
#'
#' @return A named list of lists, one per \code{cols}, each with NA rules.
#' @export
get_temperature_definition <- function(calculations_data, cols, variables_metadata){
  definitions_year <- get_r_instat_definitions(calculations_data)
  variables_list = c("na_rm", "na_n", "na_n_non", "na_consec", "na_prop")
  
  get_temperature_na_details <- function(data, temp_col){
    temp_summary_name_list <- NULL
    # Note, we take the na.rm bits from data_by_year
    temp_summary <- data[[temp_col]]
    if (!is.null(temp_summary)){
      na_rm <- extract_value(temp_summary$function_exp, "na.rm = ", FALSE)
      na_n <- extract_value(temp_summary$function_exp, "na_max_n = ", TRUE)
      na_n_non <- extract_value(temp_summary$function_exp, "na_min_n = ", TRUE)
      na_consec <- extract_value(temp_summary$function_exp, "na_consecutive_n = ", TRUE)
      na_prop <- extract_value(temp_summary$function_exp, "na_max_prop = ", TRUE)
      for (variable in variables_list) {
        if (exists(variable) && all(!is.na(get(variable)))) {
          temp_summary_name_list[[variable]] <- get(variable)
        } else {
          temp_summary_name_list[[variable]] <- NA
        }
      }
    }
    return(temp_summary_name_list)
  }
  
  build_block <- function(cols, data) {
    purrr::map(cols, ~ get_temperature_na_details(data, .x)) |>
      purrr::set_names(cols)
  }
  
  temperature_definitions <- build_block(cols = cols, definitions_year)
  
  # Next, we need to rename our variables in the metadata to min_tmin, max_tmin, mean_tmin, etc. (it otherwise takes min_MINTEMPCOLUMNNAME)
  variables_metadata <- variables_metadata %>%
    dplyr::select(dplyr::any_of(c("Name", "Climatic_Type")))
  
  if (ncol(variables_metadata) == 2){ # if we have Climatic defined
    variables_metadata <- variables_metadata %>%
      dplyr::filter(Climatic_Type %in% c("temp_max", "temp_min")) %>%
      dplyr::mutate(Climatic_Type = ifelse(Climatic_Type == "temp_max", "tmax",
                                           ifelse(Climatic_Type == "temp_min", "tmin", "check")))
    
    # Now, replace any instance of TMPMAX with tmax; and TMPMIN with tmin in our whole of temperature_definitions
    # map from variables_metadata
    map <- with(variables_metadata, setNames(Climatic_Type, Name))
    # e.g. map = c(TMPMAX = "tmax", TMPMIN = "tmin")
    
    # recursively replace *names* (at all depths), not values
    rename_list_names <- function(x, map) {
      if (is.list(x)) {
        nms <- names(x)
        if (!is.null(nms)) {
          # replace substrings like "TMPMAX" -> "tmax" anywhere in the name
          for (from in names(map)) {
            nms <- gsub(from, map[[from]], nms, fixed = TRUE)
          }
          names(x) <- nms
        }
        # recurse into children
        x <- lapply(x, rename_list_names, map = map)
      }
      x
    }
    
    # apply it
    temperature_definitions <- rename_list_names(temperature_definitions, map)
    
  } else {
    warning("No temperature data found. Define temperature data in Define Climatic dialog")
  }
  return(temperature_definitions)
}

# ============================
# Low-level parsing helpers
# ============================

#' Get end rains definitions (internal)
#'
#' Parses end-of-rains definition parameters from a calculation sub-tree.
#'
#' @param end_rains The end-of-rains node (from \code{get_r_instat_definitions()}).
#' @return A list with \code{start_day}, \code{end_day}, \code{output} (="both"),
#'   \code{min_rainfall}, and \code{interval_length}.
#' @keywords internal
#' @examples
#' # create_end_rains_definitions(end_rains)
create_end_rains_definitions <- function(end_rains = NULL){
  # Create an empty list
  data_list <- list()
  variables_list = c("start_day", "end_day",  "output", "min_rainfall", "interval_length")
  if (!is.null(end_rains)) {
    start_day <- extract_value(end_rains$filter_2, " >= ")
    end_day <- extract_value(end_rains$filter_2, " <= ")
    output <- "both"
    min_rainfall <- extract_value(end_rains$filter[[1]], "roll_sum_rain > ")
    if (is.null(end_rains$filter$roll_sum_rain[[2]])){
      stop("No roll_sum_rain value found. Have you put end_rains_column to equal 'end_season'? You want end_season_column to equal 'end_season'.")
    }
    interval_length <- extract_value(end_rains$filter$roll_sum_rain[[2]], "n=")
  }
  # Loop through variables and add to the list if defined
  for (variable in variables_list) {
    if (exists(variable) && !is.na(get(variable))) {
      data_list[[variable]] <- get(variable)
    } else {
      data_list[[variable]] <- NA
    }
  }
  
  return(data_list)
}

#' Get end of season definitions (internal)
#'
#' Parses end-of-season (water balance) definition parameters from a calculation node.
#'
#' @param end_season The end-season node (from \code{get_r_instat_definitions()}).
#' @return A list with \code{start_day}, \code{end_day}, \code{water_balance_max},
#'   \code{capacity}, \code{evaporation}, \code{evaporation_value}.
#' @keywords internal
#' @examples
#' # create_end_season_definitions(end_season)
create_end_season_definitions <- function(end_season = NULL){
  # Create an empty list
  data_list <- list()
  variables_list <- c("start_day", "end_day", "water_balance_max",
                      "capacity", "evaporation", "evaporation_value")
  
  if (!is.null(end_season))  {
    start_day <- extract_value(end_season$filter_2, " >= ")
    end_day <- extract_value(end_season$filter_2, " <= ")
    output <- "both"
    water_balance_max <- extract_value(end_season$filter[[1]], "wb <= ")
    capacity_value <- end_season$filter$conditions_check$wb$wb_max$rain_max[[2]]
    if (is.null(capacity_value)){
      capacity_value <- end_season$filter$wb$wb_max$rain_max[[2]]
      evaporation_value <- end_season$filter$wb$wb_max[[1]]
    } else {
      evaporation_value <- end_season$filter$conditions_check$wb$wb_max[[1]]
    }
    capacity <- extract_value(capacity_value, "yes=")
    evaporation_value <- extract_value(evaporation_value, "rain_max - ")
    if (is.na(evaporation_value)){
      evaporation_value <- end_season$filter$conditions_check$wb$wb_max[[1]]
      if (is.null(evaporation_value)) evaporation_value <- end_season$filter$wb$wb_max[[1]]
      evaporation_value <- extract_value(evaporation_value, "no=", FALSE)
      evaporation <- "variable"
    } else {
      evaporation <- "value"
    }
  }
  # Loop through variables and add to the list if defined
  for (variable in variables_list) {
    if (exists(variable) && !is.na(get(variable))) {
      data_list[[variable]] <- get(variable)
    } else {
      data_list[[variable]] <- NA
    }
  }
  return(data_list)
}

#' Get start of rains definitions (internal)
#'
#' Parses start-of-rains definition parameters from a calculation node.
#'
#' @param start_rains The start-of-rains node (from \code{get_r_instat_definitions()}).
#' @return A list with keys among:
#'   \code{start_day}, \code{end_day}, \code{threshold},
#'   \code{total_rainfall}, \code{over_days}, \code{amount_rain},
#'   \code{proportion}, \code{prob_rain_day},
#'   \code{dry_spell}, \code{spell_max_dry_days}, \code{spell_interval},
#'   \code{dry_period}, \code{max_rain}, \code{period_interval}, \code{period_max_dry_days}.
#' @keywords internal
#' @examples
#' # create_start_rains_definitions(start_rains)
create_start_rains_definitions <- function(start_rains = NULL){
  # Create an empty list
  data_list <- list()
  # Create a list
  variables_list = c("start_day", "end_day", "threshold",
                     "total_rainfall", "over_days", "amount_rain", "proportion", "prob_rain_day", 
                     "evaporation", "evaporation_fraction",
                     "number_rain_days", "min_rain_days", "rain_day_interval",
                     "dry_spell", "spell_max_dry_days", "spell_interval", 
                     "dry_period", "max_rain", "period_interval", "period_max_dry_days")
  
  if (!is.null(start_rains)) {
    start_day <- extract_value(start_rains$filter_2, " >= ")
    end_day <- extract_value(start_rains$filter_2, " <= ")
    output <- "both"
    
    # Important! Assuming that threshold is the first argument!
    threshold <- extract_value(start_rains$filter[[1]], " >= ")
    
    # if null, then we didn't run it so set that to be false in definitions file.
    if (is.null(start_rains$filter$roll_sum_rain)){   # where is roll_sum_rain
      total_rainfall <- FALSE  
    } else {
      total_rainfall <- TRUE
      if (is.null(start_rains$filter$wet_spell)){
        amount_rain <- extract_value(start_rains$filter[[1]], "roll_sum_rain > ")
        over_days <- extract_value(start_rains$filter$roll_sum_rain[[2]], "n=")
        proportion <- FALSE
        if (!is.null(start_rains$filter$roll_sum_evap)){
          evaporation <- TRUE
          evaporation_fraction <- extract_value(start_rains$filter$roll_sum_evap$fraction_evap[[2]], " * ", FALSE, TRUE)
        } else {
          evaporation <- FALSE
        }
      } else { # ottherwise it is proportion rain days
        proportion <- TRUE
        evaporation <- FALSE
        prob_rain_day <- extract_value(start_rains$filter$wet_spell[[1]], "probs=")
        over_days <- extract_value(start_rains$filter$wet_spell$roll_sum_rain[[2]], "n=")
      }
    }
    if (is.null(start_rains$filter$roll_n_rain_days)){
      number_rain_days <- FALSE 
    } else {
      number_rain_days <- TRUE
      min_rain_days <- extract_value(start_rains$filter[[1]], "roll_n_rain_days >= ")
      rain_day_interval <- extract_value(start_rains$filter$roll_n_rain_days[[1]], "n=")
    }
    if (is.null(start_rains$filter$roll_max_dry_spell)){
      dry_spell <- FALSE
    } else {
      dry_spell <- TRUE
      spell_max_dry_days <- extract_value(start_rains$filter[[1]], "roll_max_dry_spell <= ")
      spell_interval <- extract_value(start_rains$filter$roll_max_dry_spell[[1]], "n=")
    }
    if (is.null(start_rains$filter$n_dry_period)){
      dry_period <- FALSE
    } else {
      dry_period <- TRUE
      max_rain <- extract_value(start_rains$filter$n_dry_period[[1]], "roll_sum_rain_dry_period <= ")
      period_interval <- extract_value(start_rains$filter$n_dry_period[[1]], "n=")
      period_max_dry_days <- extract_value(start_rains$filter$n_dry_period[[1]],
                                           paste0("n=", period_interval, " - "))
    }
  }
  # Loop through each variable in the list
  for (variable in variables_list) {
    # Check if the variable exists and is not NA
    if (exists(variable) && any(!is.na(get(variable)) | !is.null(get(variable)))) {
      # Retrieve the variable's value
      variable_value <- get(variable)
      
      # Check if the variable's class includes "instat_calculation"
      if ("instat_calculation" %in% class(variable_value)) {
        data_list[[variable]] <- NA
      } else {
        data_list[[variable]] <- variable_value
      }
    } else {
      # Assign NA if the variable does not exist or is NA
      data_list[[variable]] <- NA
    }
  }
  return(data_list)
}

#' Flatten R-Instat calculation tree into a named list
#'
#' Walks a calculation list (as used by R-Instat) and returns a named list of
#' definition nodes (filters, summaries, calculations, etc.) that other
#' helpers can parse.
#'
#' @param calculation A list of calculations (as produced by R-Instat flows).
#'
#' @return A named list of sub-definitions where names are typically result
#'   names or structural tags (e.g., \code{"filter"}, \code{"filter_2"}, \code{"by_#"}).
#'
#' @examples
#' # defs <- get_r_instat_definitions(calcs)
#' # defs[["start_of_rains_doy"]]
#' @export
get_r_instat_definitions <- function(calculation){
  manips <- NULL
  type <- NULL
  if (length(calculation) > 0){
    for (i in 1:length(calculation)){
      calc <- calculation[[i]]
      type[i] <- calc$type
      if (type[i] == "summary"){
        # this will tell us if it is DOY or date (or both)
        # run the function with 
        manips[[i]] <- c(variables = calc$calculated_from,
                         function_exp = calc$function_exp, 
                         get_r_instat_definitions(calculation = calc$manipulations))
        type[i] <- calc$result_name
      } else if (type[i] == "by"){
        manips[[i]] <- calc$calculated_from
        type[i] <- paste0("by_", i)
      } else if (type[i] == "filter"){
        if (length(calc$sub_calculations) > 0){
          manips[[i]] <- c(calc$function_exp, get_r_instat_definitions(calculation = calc$sub_calculations))
          type[i] <- paste0("filter")
        } else {
          manips[[i]] <- calc$function_exp
          type[i] <- paste0("filter_2")
        }
      } else if (type[i] == "calculation"){
        if (length(calc$sub_calculations) > 0){
          manips[[i]] <- c(calc$function_exp, get_r_instat_definitions(calculation = calc$sub_calculations))
          type[i] <- calc$result_name
        } else {
          if (length(calc$calculated_from) > 0){
            manips[[i]] <- c(calc$calculated_from, calc$function_exp)        
          } else {
            manips[[i]] <- calc$function_exp
          }
          type[i] <- calc$result_name
        }
        type[i] <- calc$result_name
      }
    }
    if (!is.null(manips)){
      names(manips) <- type
    }
    return(manips)
  }
}

#' Extract a numeric or text value from a calculation expression string
#'
#' Parses a string (typically a R-Instat calculation expression) and extracts
#' the value that appears after a specified pattern. Useful for pulling parameter
#' values (e.g., thresholds, window sizes, NA rules) from text-based calculation
#' expressions stored in metadata.
#'
#' @param string Character string containing the expression to parse.
#' @param value_expr Character string specifying the pattern that precedes the
#'   value to extract (e.g., `"n="`, `"na.rm = "`, `"roll_sum_rain > "`).
#'   This should include any literal characters appearing before the target value.
#' @param as_numeric Logical (default `TRUE`). If `TRUE`, extracts and converts
#'   the value to numeric. If `FALSE`, extracts text until a whitespace or comma.
#' @param after_asterix Logical (default `FALSE`). If `TRUE`, then it looks for values
#'   after an asterix. This is only used if `as_numeric` is `FALSE`.
#'   
#' @return A numeric value if `as_numeric = TRUE`, otherwise a character value.
#'   Returns `NA` if the value cannot be found.
#'
#' @details
#' - Numeric mode matches digits optionally followed by a decimal.
#' - Text mode strips `)` if present and stops at whitespace or comma.
#' - Designed to work with strings produced by R-Instat calculation definitions.
#'
#' @examples
#' # Extract numeric window size
#' extract_value("roll_sum_rain(x, n=21)", "n=")
#' #> 21
#'
#' # Extract threshold
#' extract_value("roll_sum_rain > 20", "roll_sum_rain > ")
#' #> 20
#'
#' # Extract logical flag as text
#' extract_value("probs=yes", "probs=", as_numeric = FALSE)
#' #> "yes"
#'
#' @seealso stringr::str_match
extract_value <- function(string, value_expr, as_numeric = TRUE, after_asterix = FALSE) {
  if (as_numeric) {
    value <- stringr::str_match(string, paste0(value_expr, "([0-9]+(?:\\.[0-9]+)?)"))[1, 2]
    value <- as.numeric(value)
  } else if (after_asterix){
    value <- sub(".*\\*\\s*([0-9.]+).*", "\\1", string)
    value <- as.numeric(value)
  } else {
    value <- gsub("\\)", "", stringr::str_match(
      string,
      paste0(value_expr, "([^\\s,]+)")
    ))[1, 2]
  }
  return(value)
}

#' Get season length definitions
#'
#' Retrieves season length definitions.
#'
#' @param length The season length data.
#' @return A list representation of season length definitions.
#' @examples
#' # Example usage:
#' #create_season_length_definitions(length)
create_season_length_definitions <- function(length = NULL){
  # Create an empty list
  data_list <- list()
  variables_list <- c("end_type")
  
  if (!is.null(length)) {
    end_type <- sub(" - .*", "", length[[3]])
    end_type <- sub(".*?_", "", end_type)
  }
  # Loop through variables and add to the list if defined
  for (variable in variables_list) {
    if (exists(variable) && !is.na(get(variable))) {
      data_list[["seasonal_length"]][[variable]] <- get(variable)
    } else {
      data_list[["seasonal_length"]][[variable]] <- NA
    }
  }
  return(data_list)
}
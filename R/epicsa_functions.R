#' Get "Start of Rains" definition bundle
#'
#' Collects parameters that define the "start of rains" calculation from
#' R-Instat-style calculation objects, including which outputs are requested
#' (day-of-year, date, and/or status) and the start-of-year offset.
#'
#' @param summary_data A data.frame used to check if a status column exists.
#' @param calculations_data A list (R-Instat style) passed to \code{get_r_instat_definitions()}.
#' @param start_rain,start_rain_date,start_rain_status Character keys inside
#'   \code{calculations_data} that point to the DOY, Date and Status definitions.
#'   Supply any combination; outputs are inferred.
#' @param definitions_offset Numeric DOY offset (e.g., \code{data_book$get_offset_term()}).
#'
#' @return A list with parsed elements from the definition plus:
#'   \itemize{
#'     \item \code{output}: character vector among \code{"doy"}, \code{"date"}, \code{"status"}
#'     \item \code{s_start_doy}: numeric offset applied to DOY
#'   }
#'
#' @details Requires \code{get_r_instat_definitions()} and
#'   \code{create_start_rains_definitions()}.
#'
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
    } else if (!is.null(start_rain_status)){
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
#' Parses the season-length definition parameters from calculation objects.
#'
#' @param calculations_data A list of calculation objects (R-Instat style).
#' @param seasonal_length Character key in \code{calculations_data}.
#'
#' @return A list with a \code{seasonal_length} element containing parsed fields
#'   (e.g., \code{end_type}).
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
#' Collects NA-handling parameters and the rain-day threshold rule(s) used to
#' compute totals and counts. If multiple \code{rain_days} variables are supplied,
#' returns a named list of definition lists (one per variable).
#'
#' @param calculations_data List of calculation objects (R-Instat style).
#' @param total_rain Character or NULL. Name of total-rain definition. If non-NULL, \code{total_rain = "TRUE"}.
#' @param rain_days Character vector or NULL. Names of rain-day count definitions. If non-NULL, \code{n_rain = "TRUE"}.
#' @param daily_data_calculation List of daily-data calculations (for \code{get_count_variable()}).
#' @param rain_days_variable_from Character vector. Element names inside \code{daily_data_calculation}
#'   that hold the rain-day rule(s) corresponding to \code{rain_days}.
#' @param rearranged_var_metadata Optional data.frame with columns \code{new_var} and \code{short}
#'   used to rename top-level list names (e.g., \code{extreme_min_temp → tmin}).
#'
#' @return Either:
#' \itemize{
#'   \item a single list with \code{total_rain}, \code{n_rain}, NA rules, and a \code{rain_day} rule (list with \code{sign}/\code{threshold});
#'   \item or a named list of such lists (one per \code{rain_days_variable_from}).
#' }
#'
#' @seealso get_count_variable(), get_r_instat_definitions()
#' @export
get_rainfall_definition <- function(calculations_data, total_rain = NULL, rain_days = NULL,
                                    daily_data_calculation = NULL, rain_days_variable_from = NULL,
                                    rearranged_var_metadata = NULL){
  #### 1. Set up
  definitions_year <- get_r_instat_definitions(calculations_data)

  #### 2. TOTAL RAINFALL ########
  # variable names for total rain and rainy days
  if (!is.null(total_rain)){
    total_rain_definition <- definitions_year[[total_rain]]
    total_rain <- "TRUE"
  } else {
    total_rain <- "FALSE"
  }
  
  if (!is.null(rain_days)){
    rain_days_definition <- definitions_year[[rain_days[1]]] # only needed for the first one if there are multiple in here, because the same thing applies to them all. 
    n_rain <- "TRUE"
  } else {
    n_rain <- "FALSE"
  }
  
  # 3. Getting the threshold definition for a rain day from the daily data.
  if (as.logical(n_rain)){
    if (length(rain_days_variable_from) > 1){
      n_raindays <- NULL
      for (i in rain_days_variable_from){
        n_raindays[[i]] <- get_count_variable(daily_data_calculation, i)
      }
    } else {
      n_raindays <- get_count_variable(daily_data_calculation, rain_days_variable_from)
    }
  } else {
    n_raindays <- NULL
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
    
    if (!is.null(n_raindays)){
      if (is.list(n_raindays) && is.list(n_raindays[[1]])){
        data_list_with_rain_days <- NULL
        for (i in 1:length(n_raindays)){
          data_list_with_rain_days[[i]] <- c(data_list, n_raindays[[i]]) # for rain day threshold
        }
        data_list <- data_list_with_rain_days
        names(data_list) <- rain_days_variable_from
      } else {
        # In here, we just get one data_list which gets renamed later I think.
        data_list <- c(data_list, n_raindays) 
      }
    }
  } else {
    for (variable in variables_list) {
      data_list[[variable]] <- NA
    }
  }
  
  if (is.list(data_list) && is.list((data_list[[1]]))){
    # Next, we need to rename our variables in the metadata to annual_rainfall, etc (it otherwise takes the variable name)
    # 3) Named character vector: names = original list names, values = short codes
    map_tbl <- rearranged_var_metadata
    map <- setNames(map_tbl$short, map_tbl$new_var)
    
    # 4) Your recursive renamer (unchanged)
    rename_list_names <- function(x, map, exact = TRUE, rename_df_cols = FALSE) {
      stopifnot(is.character(map), !is.null(names(map)))
      
      rename_vec <- function(nms) {
        if (is.null(nms)) return(nms)
        idx <- match(nms, names(map))
        repl <- nms
        repl[!is.na(idx)] <- unname(map[idx[!is.na(idx)]])
        repl
      }
      
      walk_rename <- function(obj) {
        if (!is.null(names(obj)) && (rename_df_cols || !is.data.frame(obj))) {
          names(obj) <- rename_vec(names(obj))
        }
        if (is.list(obj)) {
          obj <- lapply(obj, walk_rename)
        }
        obj
      }
      
      # First full recursive rename
      out <- walk_rename(x)
      
      # ---- Now adjust ONLY the top level names ----
      
      top <- names(out)
      
      # add extreme_ prefix to "tmin", "tmax", and "rain" IF they came from extremes
      prefix_targets <- c("tmin", "tmax", "rain")
      new_top <- ifelse(top %in% prefix_targets, paste0("extreme_", top), top)
      
      names(out) <- new_top
      
      out
    }
    
    # 5) Apply to your list
    data_list <- rename_list_names(data_list, map, rename_df_cols = FALSE)
  }
  return(data_list)
}

#' Extract "extreme rain" definition bundle
#'
#' Thin wrapper around \code{get_count_variable()} for an extreme-rain
#' threshold definition.
#'
#' @param daily_data_calculation Daily-data calculations list.
#' @param extreme_rainfall Character name of the element holding the rule.
#'
#' @return A list with \code{sign} and \code{threshold}.
#' @seealso get_count_variable()
#' @export
get_extreme_rain_definition <- function(daily_data_calculation, extreme_rainfall){
  get_count_variable(daily_data_calculation, extreme_rainfall)
}

#' Parse comparison expression (internal)
#'
#' Parses a simple comparison expression like \code{"x >= 1 & x <= 5"} and returns
#' \code{direction} and numeric \code{value}/\code{value_lb}.
#'
#' @param expr A character expression.
#' @return A list with \code{direction} in \code{c("between","outer","greater","less",NA)},
#'   and numeric \code{value}, \code{value_lb}.
#' @keywords internal
get_transform_column_info <- function(expr) {
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

#' Get longest dry/wet spell definition bundle
#'
#' Extracts spell window, comparison \code{direction}, and bounds from a spell
#' definition in the calculation list.
#'
#' @param calculations_data A list of calculation objects.
#' @param spell_column Character key in \code{calculations_data}.
#' @param definitions_offset Numeric DOY offset (e.g., \code{get_offset_term()}).
#' @return A list with \code{direction}, \code{value}, \code{value_lb},
#'   \code{start_day}, \code{end_day}, \code{s_start_doy}, and flags
#'   \code{return_max_spell}, \code{return_all_spells}.
#' @export
get_longest_spell_definition <- function(calculations_data, spell_column, definitions_offset = 1){
  definitions_year <- get_r_instat_definitions(calculations_data)
  
  # Create an empty list
  data_list <- list()
  
  if (!is.null(spell_column)) spell <- definitions_year[[spell_column]]
  else spell <- NULL
  
  # Getting get_transform_column_info (e.g, is it <=, >=, etc)
  if (!is.null(spell)) {
    spell_calculation <- spell$spell_length$spell_day[[2]]
    parsed <- get_transform_column_info(spell_calculation)
    
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
    end_day <- extract_value(spell$filter_2, " <= ")
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
#' Reads crop parameter grids and compresses evenly spaced vectors into
#' \code{from}/\code{to}/\code{by} where possible.
#' ...
#' @return A list with \code{water_requirements}, \code{planting_dates}, \code{planting_length},
#'   plus \code{s_start_doy}, \code{start_check}, and \code{return_crops_table}.
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
#' @details
#' Variable names are normalized using \code{variables_metadata}: \code{TMPMAX to tmax}, \code{TMPMIN to tmin}.
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

#' Build climatic summary definitions (rainfall or temperature)
#'
#' Given calculated daily data, variable metadata, and a set of summary columns,
#' this helper constructs and returns the appropriate definition object for
#' either rainfall summaries (total rain / rain-day counts) or temperature
#' summaries (min/max temps). It rejects mixed inputs that combine rainfall and
#' temperature in the same call.
#'
#' @param calculations_data A list or environment produced upstream that
#'   \emph{get_r_instat_definitions()} can read. Typically contains the
#'   calculation context used to derive yearly definitions.
#' @param variables_metadata A data frame with at least the columns
#'   \code{Name} and \code{Climatic_Type}. \code{Climatic_Type} must be one of
#'   \code{"temp_max"}, \code{"temp_min"}, \code{"rain"}, \code{"count"} for
#'   the variables referenced in \code{summary_variables}.
#' @param summary_variables Character vector of column names for which
#'   definitions are requested (e.g., rainfall total column, rain-day count
#'   column, or temperature summary columns).
#' @param daily_data_calculation A flag or object passed through to
#'   \code{get_rainfall_definition()} to control how daily data are treated.
#'
#' @details
#' Errors if rainfall/count and temperature summaries are mixed.
#' Also errors when \code{rain} plus two distinct \code{count} summaries are supplied
#' (extreme definitions conflict with annual rainfall summaries).
#'
#' @return For rainfall, a definition (or list of definitions) from \code{get_rainfall_definition()}.
#' For temperature, a named list from \code{get_temperature_definition()}.
#' @export
get_climatic_summaries_definition <- function(calculations_data, variables_metadata, summary_variables, 
                                              daily_data_calculation){
  
  definitions_year <- get_r_instat_definitions(calculations_data)
  # We run through and we need to find out if this is min/max/mean temperature summaries
  # Or if this is rainfall sum summaries.
  
  # 1) Keep Name, Climatic_Type, and Dependencies so we can resolve derived vars
  vars_md <- variables_metadata %>%
    dplyr::select(dplyr::any_of(c("Name","Climatic_Type","Dependencies")))
  
  if (!all(c("Name","Climatic_Type") %in% names(vars_md))) {
    stop("Data not climatic defined: variables_metadata must contain Name and Climatic_Type.")
  }
  
  allowed <- c("temp_max","temp_min","rain","count")
  
  # Helper: given a variable name used by a summary, infer its climatic type.
  resolve_type <- function(var_nm) {
    row <- vars_md[vars_md$Name == var_nm, , drop = FALSE]
    
    # a) direct match
    if (nrow(row) == 1 && !is.na(row$Climatic_Type) && row$Climatic_Type %in% allowed) {
      return(row$Climatic_Type)
    }
    
    # b) try via Dependencies (for derived vars like high_temp / low_temp / high_rain)
    if (nrow(row) == 1 && "Dependencies" %in% names(row) && !is.na(row$Dependencies)) {
      deps <- unlist(strsplit(row$Dependencies, "\\s*,\\s*"))
      src <- vars_md[vars_md$Name %in% deps & vars_md$Climatic_Type %in% allowed, , drop = FALSE]
      if (nrow(src) >= 1) return(src$Climatic_Type[[1]])
    }
    
    NA_character_
  }
  
  # 2) Build def_name / variable_name from the actual definitions
  defs <- get_r_instat_definitions(calculations_data)
  missing <- setdiff(summary_variables, names(defs))
  if (length(missing)) {
    stop("Definitions not found in calculations_data: ", paste(missing, collapse = ", "))
  }
  
  variable_name <- character(length(summary_variables))
  def_name      <- character(length(summary_variables))
  
  for (k in seq_along(summary_variables)) {
    nm <- summary_variables[k]
    vd <- defs[[nm]]
    variable_name[k] <- vd[[1]]                   # upstream variable used by the summary
    def_name[k]      <- resolve_type(variable_name[k])
  }
  
  # Guard: all classified?
  if (anyNA(def_name)) {
    bad <- which(is.na(def_name))
    stop(
      "Cannot infer Climatic_Type for: ",
      paste(sprintf("%s (upstream: %s)", summary_variables[bad], variable_name[bad]), collapse = ", "),
      ". Check variables_metadata$Climatic_Type / $Dependencies."
    )
  }
  
  map_data <- data.frame(
    col           = as.character(summary_variables),
    summary       = as.character(def_name),
    variable_name = as.character(variable_name),
    stringsAsFactors = FALSE
  )
  
  has_rain_or_count <- any(grepl("rain|count", def_name))
  has_temp          <- any(grepl("temp_min|temp_max", def_name))
  
  # One issue with this is currently having extremes with rainfall summaries. This is the only catch I can do for now. 
  if (sum(def_name == "rain", na.rm=TRUE) >= 1 && sum(def_name == "count", na.rm=TRUE) >= 2)
    stop("Cannot define extreme types with annual rainfall summaries (found rain, count, count).")
  
  if (has_rain_or_count && has_temp) {
    stop("Both Rainfall and Temperature Definitions. The definitions can only get Rainfall OR Temperature Definitions.")
  }
  
  # If it's rainfall
  if (has_rain_or_count) {
    map_data <- map_data %>%
      dplyr::filter(summary %in% c("rain", "count")) %>%
      dplyr::mutate(variable_type = ifelse(summary == "rain", "total_rain",
                                           ifelse(summary == "count", "rain_days", "check")))
    
    total_rain_var <- map_data %>% dplyr::filter(summary == "rain") %>% dplyr::pull(col)
    rain_days_var <- map_data %>% dplyr::filter(summary == "count") %>% dplyr::pull(col)
    variable_name <- map_data %>% dplyr::filter(summary == "count") %>% dplyr::pull(variable_name)
    
    
    # Run a check 
    map_data_variables <- map_data %>% dplyr::filter(summary == "count")
    map_tbl <- variables_metadata %>%
      dplyr::filter(!is.na(Dependencies)) %>%
      dplyr::transmute(new_var = Name,
                       source_var = stringr::str_split(Dependencies, "\\s*,\\s*")) %>%
      tidyr::unnest(source_var) %>%
      dplyr::left_join(variables_metadata %>% dplyr::select(Name, Climatic_Type),
                       by = c("source_var" = "Name")) %>%
      dplyr::rename(source_type = Climatic_Type) %>%
      dplyr::filter(source_type %in% c("temp_max", "temp_min", "rain")) %>%
      # 2) Recode to short codes you want in the final names
      dplyr::mutate(short = dplyr::recode(source_type,
                                          temp_min = "tmin",
                                          temp_max = "tmax",
                                          rain     = "rain")) %>%
      # if a new_var shows up multiple times, keep one (shouldn’t after the filter, but safe)
      dplyr::distinct(new_var, .keep_all = TRUE)
    
    check_data <- map_tbl  %>%
      dplyr::filter(new_var %in% map_data_variables$variable_name) %>%
      dplyr::filter(source_var == "PRECIP") %>%
      dplyr::filter(source_type == "rain")
    
    if (nrow(check_data) > 1){
      stop("Cannot define two count types for Rainfall.")
    }
    
    total_rain_arg <- if (length(total_rain_var) == 0) NULL else total_rain_var
    
    if (length(rain_days_var) == 0) {
      rain_days_arg <- NULL
      rain_days_from_arg <- NULL
    } else {
      rain_days_arg <- rain_days_var
      rain_days_from_arg <- variable_name
    }
    
    rainfall_definitions <- (
      get_rainfall_definition(
        calculations_data,
        total_rain = total_rain_arg,
        rain_days = rain_days_arg,
        rain_days_variable_from = rain_days_from_arg,
        daily_data_calculation = daily_data_calculation,
        map_tbl
      )
    )
    return(rainfall_definitions)
    
  }
  # If it's temperature ============================================================
  if (has_temp) {
    cols <- map_data %>%
      dplyr::filter(summary %in% c("temp_min", "temp_max")) %>%
      dplyr::pull(col)
    
    return(get_temperature_definition(calculations_data, cols, variables_metadata))
  } else {
    stop("No Rainfall or Temperature Summaries found to define (only can define sum rain, or min/mean/max temperatures).")
  }
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
#'   the value to numeric. If `FALSE`, extracts text until a whitespace or comma.#'
#' @param after_asterisk Logical. If \code{TRUE}, extract the numeric immediately after
#'   a \code{"\*"}, e.g., in \code{"evap_var \* 0.5"} becomes \code{0.5}. This path always returns numeric.
#'
#' @return A numeric value if `as_numeric = TRUE`, otherwise a character value.
#'   Returns `NA` if the value cannot be found.
#'
#' @details
#' - Numeric mode matches digits optionally followed by a decimal.
#' - Text mode strips `)` if present and stops at whitespace or comma.
#' - Designed to work with strings produced by R-Instat calculation definitions.
#'
#' @export
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
extract_value <- function(string, value_expr, as_numeric = TRUE, after_asterisk = FALSE) {
  if (after_asterisk) {
    val <- sub(".*\\*\\s*([0-9.]+).*", "\\1", string)
    return(as.numeric(val))
  }
  if (as_numeric) {
    val <- stringr::str_match(string, paste0(value_expr, "([0-9]+(?:\\.[0-9]+)?)"))[1, 2]
    return(as.numeric(val))
  } else {
    val <- gsub("\\)", "", stringr::str_match(string, paste0(value_expr, "([^\\s,]+)")))[1, 2]
    return(val)
  }
}

#' Get season length definitions (internal)
#' @param length A definition node.
#' @return A list with \code{seasonal_length$end_type}.
#' @keywords internal
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

#' Collate all definition bundles into a single structure
#'
#' Gathers start/end of rains, end of season, seasonal length, rainfall,
#' extremes, longest spells, temperature summaries, and crop tables into a
#' single list. Cleans mutually exclusive fields depending on summary type
#' (e.g., removes \code{total_rain}/\code{n_rain} from extreme outputs).
#'
#' @param start_rains,end_rains,end_season,seasonal_length Lists from the corresponding getters.
#' @param annual_rain,seasonal_rain Lists from \code{get_rainfall_definition()}.
#' @param extreme_rain,extreme_tmin,extreme_tmax Extreme definition lists (or a list containing \code{extreme_*}).
#' @param longest_rain_spell,longest_tmin_spell,longest_tmax_spell Spell definition lists.
#' @param annual_temperature,monthly_temperature Named lists from \code{get_temperature_definition()}.
#' @param crop_success,season_start_probabilities Crop-related lists.
#'
#' @return A list with:
#' \itemize{
#'   \item \code{annual_summaries}
#'   \item \code{annual_temperature_summaries}
#'   \item \code{monthly_temperature_summaries}
#'   \item \code{crops_success}
#'   \item \code{seasonal_starting_probabilities}
#' }
#' @export
collate_definitions <- function(start_rains = NULL, end_rains = NULL, end_season = NULL, 
                                seasonal_length = NULL, annual_rain = NULL, seasonal_rain = NULL,
                                extreme_rain = NULL, extreme_tmin = NULL, extreme_tmax = NULL,
                                longest_rain_spell = NULL, longest_tmin_spell = NULL, longest_tmax_spell = NULL,
                                annual_temperature = NULL, monthly_temperature = NULL,
                                crop_success = NULL,
                                season_start_probabilities = NULL){
  
  # The extremes might be defined together
  # If that's the case then they have the names extreme_rain, extreme_tmin, extreme_tmax
  # and so we want to get them and bring them into here.
  if ("extreme_rain" %in% names(extreme_rain)) extreme_rain <- extreme_rain$extreme_rain
  if ("extreme_tmin" %in% names(extreme_tmin)) extreme_tmin <- extreme_tmin$extreme_tmin
  if ("extreme_tmax" %in% names(extreme_tmax)) extreme_tmax <- extreme_tmax$extreme_tmax
  
  annual_summaries <- list(start_rains, end_rains, end_season, seasonal_length, annual_rain,
                           seasonal_rain, extreme_rain, extreme_tmin, extreme_tmax,
                           longest_rain_spell, longest_tmin_spell, longest_tmax_spell)
  names(annual_summaries) <- c("start_rains", "end_rains", "end_season", "seasonal_length", "annual_rain",
                               "seasonal_rain", "extreme_rain", "extreme_tmin", "extreme_tmax",
                               "longest_rain_spell", "longest_tmin_spell", "longest_tmax_spell")
  
  # we want to do some tidying up, because this is all defined together when the column summaries are defined
  # because at that point we don't know if it's extreme rain or annual rain
  # but now it is defined here which it is, so we can tidy it up. 
  if (!is.null(extreme_rain)){
    annual_summaries$extreme_rain$total_rain <- NULL
    annual_summaries$extreme_rain$n_rain <- NULL
    annual_summaries$extreme_rain$threshold <- NULL
  }
  if (!is.null(extreme_tmin)){
    annual_summaries$extreme_tmin$total_rain <- NULL
    annual_summaries$extreme_tmin$n_rain <- NULL
    annual_summaries$extreme_tmin$threshold <- NULL
  }
  if (!is.null(extreme_tmax)){
    annual_summaries$extreme_tmax$total_rain <- NULL
    annual_summaries$extreme_tmax$n_rain <- NULL
    annual_summaries$extreme_tmax$threshold <- NULL
  }
  if (!is.null(annual_rain)){
    annual_summaries$annual_rain$direction <- NULL
    annual_summaries$annual_rain$value_lb <- NULL
    annual_summaries$annual_rain$value <- NULL
  }
  if (!is.null(seasonal_rain)){
    annual_summaries$seasonal_rain$direction <- NULL
    annual_summaries$seasonal_rain$value_lb <- NULL
    annual_summaries$seasonal_rain$value <- NULL
  }
  
  # We rename mean_TMPMAX, min_TMPMAX, etc to be mean_tmax, min_tmax, etc by using the metadata in the get_temperature_summaries function 
  
  definitions_list <- list(annual_summaries = annual_summaries,
                           annual_temperature_summaries = annual_temperature,
                           monthly_temperature_summaries = monthly_temperature,
                           crops_success = crop_success,
                           seasonal_starting_probabilities = season_start_probabilities)
  return(definitions_list)
  
}

#' Extract a rain-day (or generic count) rule from daily calculations
#'
#' Reads the named element in the daily-data calculation tree and parses its
#' comparison rule into \code{direction}, \code{value}, \code{value_lb}, and (if applicable)
#' \code{threshold}.
#'
#' @param calculations_daily_data List of daily-data calculations.
#' @param summary_variables Character key (e.g., \code{"extreme_rain"}).
#' @return A list with \code{direction}, \code{value}, \code{value_lb}, and possibly \code{threshold}.
#' @seealso get_transform_column_info()
#' @export
get_count_variable <- function(calculations_daily_data,
                               summary_variables = "extreme_rain") {
  
  definitions_in_raw <- get_r_instat_definitions(calculations_daily_data)
  
  #if (!is.null(definitions_in_raw) && !is.null(rainfall_column)) {
  definition <- definitions_in_raw[[summary_variables]]
  definition_rain_day_value <- definition$rain_day[[2]]
  
  parsed <- get_transform_column_info(definition_rain_day_value)
  
  if (parsed$direction == "greater" && is.na(parsed$value_lb) && !is.na(parsed$value)){
    parsed$threshold <- parsed$value
  }
  
  return(parsed)
}

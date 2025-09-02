#' Get Data Book Output Object Names
#'
#' Retrieves the names of output objects in a data book list.
#'
#' @param output_object_list A list of output objects.
#' @param object_type_label An optional label to filter the objects by type. Defaults to NULL.
#' @param excluded_items A character vector of items to exclude from the result. Defaults to an empty vector.
#' @param as_list Logical indicating whether to return the result as a list. Defaults to FALSE.
#' @param list_label An optional label for the list if `as_list` is TRUE. Defaults to NULL.
#' @return A character vector or list of object names.
get_data_book_output_object_names <- function(output_object_list,
                                              object_type_label = NULL, 
                                              excluded_items = c(), 
                                              as_list = FALSE, 
                                              list_label = NULL){
  
  if(is.null(object_type_label)){
    out <- names(output_object_list)
  }else{ 
    out <- names(output_object_list)[sapply(output_object_list, function(x) any( identical(x$object_type_label, object_type_label) ))]
  }
  
  if(length(out) == 0){
    return(out)
  } 
  
  if(length(excluded_items) > 0) {
    #get indices of items to exclude
    excluded_indices <- which(out %in% excluded_items)
    
    #remove the excluded items from the list
    if(length(excluded_indices) > 0){
      out <- out[-excluded_indices]
    }
  }
  
  if(as_list) {
    #convert the character vector list
    lst <- list()
    if(!is.null(list_label)){
      lst[[list_label]] <- out
    }else{
      lst <- as.list(out)
    }
    
    return(lst)
  }else{
    #return as a character vector
    return(out)
  }
}

#' Get Scalar Names from Data Book
#'
#' @description
#' Extracts scalar names from a given list, with the option to exclude specific items, 
#' return the names as a list, and provide a label for the list.
#'
#' @param scalar_list A named list from which to extract scalar names.
#' @param excluded_items A character vector of items to exclude from the output. Defaults to an empty vector.
#' @param as_list A logical value indicating whether to return the result as a list. Defaults to `FALSE`.
#' @param list_label A character string specifying the label for the list, if `as_list = TRUE`.
#'
#' @return A character vector of scalar names, or a named list if `as_list = TRUE`.
get_data_book_scalar_names <- function(scalar_list,
                                       excluded_items = c(), 
                                       as_list = FALSE, 
                                       list_label = NULL) {
  out = names(scalar_list)
  if (length(excluded_items) > 0) {
    ex_ind = which(out %in% excluded_items)
    if (length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of calculations")
    if (length(ex_ind) > 0) out = out[-ex_ind]
  }
  if (!as_list) {
    return(out)
  }
  lst = list()
  lst[[list_label]] <- out
  return(lst)
}

# TODO: deprecated. Need to call the data book version in R-Instat

#' Check if the data is at the variety level
#'
#' @description
#' This function checks whether the specified dataset is Tricot-defined 
#' and whether it is at the variety level. A dataset is considered 
#' "at the variety level" if one of its key columns contains only the variety identifier.
#'
#' @param data A character string specifying the name of the dataset.
#' @param col Name of a specific column when testing (default `NULL`).
#'
#' @return An integer indicating the outcome:
#' \itemize{
#'   \item 0 - There is no variety variable that is Tricot-Defined in this data.
#'   \item 1 - No key columns are defined in the dataset.
#'   \item 2 - Only variety level data can be used for this data. This is data where there is a unique row for each variety given.
#'   \item 3 - Success. The dataset is Tricot-defined and at the variety level.
#'   \item 7 - Success. This data is at the plot level, but it can be used.
#'   \item 8 - This data is at the plot level. Either use variety-level data, or use data where there is only one level of 'col' for each variety level.
#' }
#' Additionally, a message is printed describing the result.
#' 
#' @export
check_variety_data_level <- function(data, col = NULL){
  data_by_plot <- data_book$get_data_frame(data)
  variety_col_name <- data_book$get_variables_metadata(data_name = data) %>%
    dplyr::filter(Tricot_Type == tricot_variety_label) %>%
    dplyr::pull(Name)
  if (length(variety_col_name) == 0){
    print("There is no variety variable that is Tricot-Defined in this data.")
    return(0)
  }
  keys_from_data <- data_book$get_keys(data)
  only_variety_cols <- purrr::map_lgl(keys_from_data, ~ all(.x == variety_col_name))
  if (length(keys_from_data) == 0){
    print("No key columns defined.")
    return(1)
  } else {
    if (any(only_variety_cols)){
      print("Success. This data is at the variety level.")
      return(3)
    } else {
      # run a check if it is plot-level data, and that this is unique for each plot
      id_col_name <- data_book$get_variables_metadata(data_name = data) %>%
        dplyr::filter(Tricot_Type == tricot_id_label) %>%
        dplyr::pull(Name)
      plot_level_data <- purrr::map_lgl(keys_from_data, ~  setequal(.x, c(variety_col_name, id_col_name)))
      if (plot_level_data){
        variety_level_var <- data_book$get_columns_from_data(data, variety_col_name)
        data_frame <- data_book$get_data_frame(data_name=data)
        
        # Count unique combinations
        n_variety <- data_frame %>%
          dplyr::distinct(.data[[variety_col_name]]) %>%
          nrow()
        
        # Compare
        for (i in col){
          n_variety_col <- data_frame %>%
            dplyr::distinct(.data[[variety_col_name]], .data[[i]]) %>%
            nrow()
          if (n_variety != n_variety_col) {
            print("Error: This data is at the plot level. Either use variety-level data, or use data where there is only one level of 'col' for each variety level.")
            return(8)
          }
        }
        print("Success. This data is at the plot level, but it can be used.")
        return(7)
      } else {
        print("Only variety level data can be used for this data. This is data where there is a unique row for each variety given.")
        return(2) 
      }
    }
  }
}

# TODO: deprecated. Need to call the data book version in R-Instat

#' Check if the data is at the ID level
#'
#' @description
#' This function checks whether the specified dataset is Tricot-defined 
#' and whether it is at the ID level. A dataset is considered 
#' "at the ID level" if one of its key columns contains only the ID identifier.
#'
#' @param data A character string specifying the name of the dataset.
#'
#' @return An integer indicating the outcome:
#' \itemize{
#'   \item 0 - There is no ID variable that is Tricot-Defined in this data.
#'   \item 1 - No key columns are defined in the dataset.
#'   \item 2 - Only ID level data can be used for this data. This is data where there is a unique row for each ID variable given.
#'   \item 3 - Success. The dataset is Tricot-defined and at the ID level.
#' }
#' Additionally, a message is printed describing the result.
#' @export
check_ID_data_level <- function(data){
  breadwheat_by_ID <- data_book$get_data_frame(data)
  ID_col_name <- data_book$get_variables_metadata(data_name = data) %>%
    dplyr::filter(Tricot_Type == tricot_id_label) %>%
    dplyr::pull(Name)
  if (length(ID_col_name) == 0){
    print("There is no ID variable that is Tricot-Defined in this data.")
    return(0)
  }
  keys_from_data <- data_book$get_keys(data)
  only_ID_cols <- purrr::map_lgl(keys_from_data, ~ all(.x == ID_col_name))
  if (length(keys_from_data) == 0){
    print("No key columns defined.")
    return(1)
  } else {
    if (any(only_ID_cols)){
      print("Success. This data is at the ID level.")
      return(3)
    } else {
      print("Only ID level data can be used for this data. This is data where there is a unique row for each ID given.")
      return(2)
    }
  }
}


# TODO: deprecated. Need to call the data book version in R-Instat

#' Create and Structure Tricot Data at Multiple Levels
#'
#' Detects the appropriate tricot data levels (ID, plot, plot–trait, variety) from a
#' summary of input datasets, pivots or constructs missing levels using `pivot_tricot()`,
#' and registers all levels in the `data_book` with associated metadata (ID, variety,
#' trait keys) and ranking summaries.
#'
#' @param output_data_levels A tibble produced by `instatExtras::summarise_data_levels()`
#'   describing available datasets and their detected levels. Must include at least one
#'   dataset with `level == "id"`.
#' @param id_level_data Optional string naming a dataset to use as the ID level if none
#'   are detected automatically. Defaults to `""`, in which case detection errors if
#'   no ID-level dataset is found.
#' @param id_col Character name of the ID column. Only used when specifying `id_level_data`.
#' @param data_trait_cols Optional character vector of trait-indicator columns to pass
#'   to `pivot_tricot()` when constructing plot data.
#' @param carry_cols Optional character vector of columns to carry through to the plot-level
#'   pivoted data.
#' @param traits Deprecated. Use `data_trait_cols` instead.
#' @param variety_cols Character vector of variety columns (for `detect_tricot_structure()`).
#' @param rank_values Character vector of possible rank values (for `detect_tricot_structure()`).
#' @param prefix Optional string prefix for trait columns (for `detect_tricot_structure()`).
#' @param good_suffixes Character vector of suffixes indicating positive rankings
#'   (e.g. `"_pos"`, `"_best"`).
#' @param bad_suffixes Character vector of suffixes indicating negative rankings
#'   (e.g. `"_neg"`, `"_worst"`).
#' @param na_candidates Character vector of values treated as missing (e.g.
#'   `c("Not observed", "Not scored", NA_character_)`). Only the first value is used.
#'
#' @details
#' 1. Ensures exactly one dataset is assigned to each data level in
#'    `output_data_levels`, allowing manual override via `id_level_data`.
#' 2. Detects tricot structure (options, trait suffixes, rank levels) with
#'    `detect_tricot_structure()` on the ID-level dataset.
#' 3. Constructs or pivots plot-level data using `pivot_tricot()`, combining
#'    ID-level and plot–trait data if provided.
#' 4. Imports the new plot-level data into `data_book`, naming it `<id_dataset>_plot`.
#' 5. Summarises plot-level data by variety, creating a `<plot_dataset>_by_variety` table.
#' 6. Updates and returns `output_data_levels`, adding any newly created plot or variety
#'    datasets and the list of detected trait names.
#'
#' @return A tibble mirroring `output_data_levels` with any new plot- and variety-level
#'   dataset entries and a `trait_names` list-column of detected trait labels.
#' @export
create_tricot_datasets = function(output_data_levels,
                                  id_level_data = "", id_col = "id", data_trait_cols = NULL, carry_cols = NULL,
                                  traits = NULL,
                                  variety_cols = NULL,
                                  rank_values = NULL,
                                  prefix = NULL,
                                  good_suffixes = c("_pos", "_best"), bad_suffixes = c("_neg", "_worst"),
                                  na_candidates = c("Not observed", "Not scored", NA_character_)){
  na_candidates <- match.arg(na_candidates)
  ID_COLS <- c("id", "variety", "dummy_variety")
  
  # 0. Check if there are multiple data frames with output_data_levels at ID level ===========
  output_data_levels_check <- output_data_levels %>% dplyr::filter(level != "No marker columns found.")
  if (length(unique(output_data_levels_check$level)) != length(output_data_levels_check$level)){
    stop("Multiple data Sets at the same level. Should only have one data frame at each level.")
  }
  
  # 1. Check their ID level data ================================================
  if ("id" %in% output_data_levels$level){
    output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "id")
    data_name <- output_data_levels_data %>% dplyr::pull(dataset)
    id_col <- output_data_levels_data %>% dplyr::pull(id_col)
  } else {
    if (id_level_data != ""){
      # what did they say is their ID level
      # and add this into our output_data_levels table so we now have it
      # same for their tricot structure
      output_data_levels <- bind_rows(output_data_levels,
                                      data.frame(dataset = id_level_data,
                                                 level = "id",
                                                 id_col = id_col))
      data_name <- id_level_data
    } else {
      stop("No ID Level data identified in data.")
    }
  }
  
  # 2. Create Tricot Structure for Plot Level Data ==============================
  if ("plot-trait" %in% output_data_levels$level){
    ivt_output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "plot-trait")
    ivt_data_name <- ivt_output_data_levels_data %>% dplyr::pull(dataset)
    ivt_id_col <- ivt_output_data_levels_data %>% dplyr::pull(id_col)
    ivt_variety_col <- ivt_output_data_levels_data %>% dplyr::pull(variety_col)
    ivt_trait_col <- ivt_output_data_levels_data %>% dplyr::pull(trait_col)
  } else {
    ivt_id_col <- ""
    ivt_variety_col <- ""
    ivt_trait_col <- ""
  }
  
  if ("id" %in% output_data_levels$level){
    id_output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "id")
    id_data_name <- id_output_data_levels_data %>% dplyr::pull(dataset)
    id_id_col <- id_output_data_levels_data %>% dplyr::pull(id_col)
  }
  
  if (!"plot" %in% output_data_levels$level){
    data_name_to_get <- data_book$get_data_frame(data_name)
    tricot_structure <- instatExtras::detect_tricot_structure(data = data_name_to_get,
                                                              variety_cols = variety_cols,
                                                              rank_values = rank_values,
                                                              prefix = prefix,
                                                              good_suffixes = good_suffixes,
                                                              bad_suffixes = bad_suffixes,
                                                              na_candidates = na_candidates)
    
    # if we have our plot-Trait data then
    if ("plot-trait" %in% output_data_levels$level){
      ivt_data_name_to_get <- data_book$get_data_frame(ivt_data_name)
      if ("id" %in% output_data_levels$level) {
        id_data_name_to_get <- data_book$get_data_frame(id_data_name)
        data_by_plot <- instatExtras::pivot_tricot(data_plot_trait = ivt_data_name_to_get,
                                                   data_plot_trait_id_col = ivt_id_col,
                                                   data = id_data_name_to_get,
                                                   data_id_col = id_id_col,
                                                   data_trait_cols = data_trait_cols,
                                                   carry_cols = carry_cols,
                                                   option_cols = tricot_structure$option_cols,
                                                   variety_col = ivt_variety_col,
                                                   trait_col = ivt_trait_col,
                                                   rank_col = "rank")
      } else {
        data_by_plot <- instatExtras::pivot_tricot(data_plot_trait = ivt_data_name_to_get,
                                                   data_id_col = ivt_id_col,
                                                   variety_col = ivt_variety_col,
                                                   trait_col = ivt_trait_col,
                                                   rank_col = "rank")
      }
    } else if ("id" %in% output_data_levels$level) {
      id_data_name_to_get <- data_book$get_data_frame(id_data_name)
      data_by_plot <- instatExtras::pivot_tricot(data = id_data_name_to_get,
                                                 data_id_col = id_id_col,
                                                 data_trait_cols = data_trait_cols,
                                                 carry_cols = carry_cols,
                                                 option_cols = tricot_structure$option_cols,
                                                 possible_ranks = tricot_structure$ranks,
                                                 trait_good = tricot_structure$trait_good_cols, 
                                                 trait_bad = tricot_structure$trait_bad_cols,
                                                 na_value = tricot_structure$na_candidates)
    } else {
      stop("Invalid data to create plot data")
    }

    #4. Import 
    plot_data_name <- paste0(data_name, "_plot")
    data_book$import_data(data_tables = setNames(list(data_by_plot), plot_data_name))
    plot_id_col <- unique(c(ivt_id_col, id_id_col, "id"))
    plot_variety_name <- "variety"
    plot_variety_col <- unique(c(ivt_variety_col, "variety"))
    plot_trait_col <- ivt_trait_col
    #plot_trait_cols <- names(data_by_plot %>% dplyr::select(-any_of(c(plot_id_col, plot_variety_col, "dummy_variety")))
  } else {
    output_plot_levels_data <- output_data_levels %>% dplyr::filter(level == "plot")
    plot_data_name <- output_plot_levels_data %>% dplyr::pull(dataset)
    plot_id_col <- output_plot_levels_data %>% dplyr::pull(id_col)
    plot_variety_col <- output_plot_levels_data %>% dplyr::pull(variety_col)
    plot_variety_name <- plot_variety_col
    plot_trait_col <- ivt_trait_col
  }
  
  # 3. Pivot/transformation that gives data at Variety Level too ===================
  if (!"variety" %in% output_data_levels$level){
    data_book$calculate_summary(data_name = plot_data_name,
                                factors = plot_variety_name,
                                store_results = TRUE,
                                summaries = c("summary_count"), silent = TRUE)
    plot_by_variety_data_name <- paste0(plot_data_name, "_by_", plot_variety_name)
    plot_variety_col <- "variety"
    # if ("plot" %in% output_data_levels$level){
    #   data_book$rename_dataframe(data_name = paste0(plot_data_name, "_by_variety"), new_value=paste0(data_name, "_by_variety"), label="")
    #   plot_by_variety_data_name <- paste0(plot_data_name, "_by_variety")
    # }
  } else {
    output_plot_variety_levels_data <- output_data_levels %>% 
      dplyr::filter(level == "variety")
    plot_by_variety_data_name <- output_plot_variety_levels_data %>% 
      dplyr::pull(dataset)
    plot_variety_col_1 <- output_plot_variety_levels_data %>% 
      dplyr::pull(variety_col)
    plot_variety_col <- unique(c(plot_variety_col, plot_variety_col_1))
  }
  
  # 5. Create list of datasets to update, only if they exist in data_book
  datasets_to_check <- unique(c(data_name, plot_data_name, plot_by_variety_data_name))
  datasets_to_check <- datasets_to_check[sapply(datasets_to_check, function(nm) {
    tryCatch(!is.null(data_book$get_data_frame(nm)), error = function(e) FALSE)
  })]
  
  # Update output_data_levels with latest structure
  updated_output_data_levels <- instatExtras::summarise_data_levels(data_list = datasets_to_check,
                                                                    id_cols = na.omit(c(output_data_levels$id_col, plot_id_col)),
                                                                    variety_cols = na.omit(c(output_data_levels$variety_col, plot_variety_col)),
                                                                    trait_cols = na.omit(c(output_data_levels$trait_col)))
  
  # 6. Get Trait Names =================================================================
  # find cols ending in any of the suffixes - this is to get our traits given. Required for next after this function
  # because what if they have carried columns. Now we know what are our traits to define as our traits, etc. 
  # 6.1. build the suffix regex
  suffixes <- c(tricot_structure$trait_good_cols,
                tricot_structure$trait_bad_cols)
  re <- paste0("(", paste0(suffixes, collapse = "|"), ")$")
  
  # 6.2. pull in your two datasets
  wide_df <- data_book$get_data_frame(data_name)
  plot_df <- data_book$get_data_frame(plot_data_name)
  
  # 6.3. extract the base‐trait names from the wide data
  trait_names <- wide_df %>%
    dplyr::select(matches(re)) %>%
    names() %>%
    sub(re, "", .) %>%
    unique()
  
  # 6.4. find which of those appear as columns in your plot‐level data
  common_traits <- intersect(trait_names, names(plot_df))
  
  # 6.5. build a tibble with a list‐column
  constructed_traits <- tibble::tibble(
    dataset     = plot_data_name,
    trait_names = list(common_traits)
  )
  
  # 6.6 merge
  updated_output_data_levels <- dplyr::full_join(updated_output_data_levels, constructed_traits)
  
  # You could optionally return or assign this updated output
  return(updated_output_data_levels)
}

# TODO: deprecated. Need to call the data book version in R-Instat

#' Define Tricot Data in a Data Book
#'
#' Registers tricot experiment datasets (ID-, plot-, and variety-level) into a
#' `data_book` object, setting key identifiers and variable roles for each level
#' based on detected or provided suffix conventions.
#'
#' @param output_data_levels A data frame summarising datasets and their key columns,
#'   typically produced by `instatExtras::summarise_data_levels()` or
#'   `create_tricot_datasets()`.
#' @param variety_cols Character vector of variety columns for detection (optional).
#' @param trait_cols Optional character vector of trait column names to assign at the
#'   plot level. If `NULL`, traits are inferred from the dataset after loading.
#'
#' @details
#' 1. Detects tricot structure (options names, trait suffixes, rank set) using
#'    `detect_tricot_structure()` on the ID-level dataset.
#' 2. Calls `data_book$define_as_tricot()` for each dataset at the "id", "plot",
#'    and "variety" levels, supplying the appropriate key columns and type mapping
#'    (e.g. `id=`, `variety=`, `traits=`).
#'
#' @return Invisibly returns `NULL`; registers metadata in `data_book`.
#'
#' @examples
#' # Given a data book and output_data_levels:
#' #define_tricot_data(output_data_levels)
#'
#' @export
define_tricot_data <- function(output_data_levels,
                               variety_cols = NULL,
                               trait_cols = NULL) {
  
  # 1. Get Tricot Structure =====================================================
  output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "id") %>% dplyr::pull(dataset)
  data_name_to_get <- data_book$get_data_frame(output_data_levels_data)
  
  # 2. Define Data =================================================================
  # Define ID level data
  ID_data <- output_data_levels %>% dplyr::filter(level == "id")
  ID_data_name <- ID_data %>% dplyr::pull(dataset)
  ID_data_id_var <- ID_data %>% dplyr::pull(id_col)
  data_book$define_as_tricot(data_name = ID_data_name,
                             key_col_names = ID_data_id_var,
                             types = c(id = ID_data_id_var,
                                       varieties = variety_cols),
                             auto_selection = TRUE)
  
  # Define Variety level data
  variety_data <- output_data_levels %>% dplyr::filter(level == "variety")
  variety_data_name <- variety_data %>% dplyr::pull(dataset)
  variety_data_variety_var <- variety_data %>% dplyr::pull(variety_col)
  data_book$define_as_tricot(data_name = variety_data_name,
                             key_col_names = c(variety_data_variety_var),
                             types = c(variety = variety_data_variety_var),
                             auto_selection = TRUE)
  
  # Define Plot level data
  plot_data <- output_data_levels %>% dplyr::filter(level == "plot")
  plot_data_name <- plot_data %>% dplyr::pull(dataset)
  plot_data_id_var <- plot_data %>% dplyr::pull(id_col)
  plot_data_variety_var <- plot_data %>% dplyr::pull(variety_col)
  
  if ("trait_names" %in% names(output_data_levels)){
    trait_cols <- unlist(output_data_levels %>% dplyr::filter(level == "plot") %>% dplyr::pull(trait_names))
  } else {
    trait_cols <- names(data_book$get_data_frame(plot_data_name) %>%
                          dplyr::select(-any_of(c(plot_data_id_var, plot_data_variety_var, "dummy_variety"))))
  }
  
  data_book$define_as_tricot(data_name = plot_data_name,
                             key_col_names = c(plot_data_id_var, plot_data_variety_var),
                             types = c(id = plot_data_id_var,
                                       variety = plot_data_variety_var,
                                       traits = trait_cols),
                             auto_selection = TRUE)
}

## Workaround an R CMD check false positive
ignore_unused_imports <- function(){
  R6::R6Class
  chillR::test_if_equal
  clipr::clear_clip
  data.table::address
  ggplot2::xlab
  gridExtra::combine
  imputeTS::na.ma
  instatCalculations::`%>%`
  instatExtras::`%>%`
  janitor::add_totals_col
  lazyeval::ast
  lubridate::am
  patchwork::set_dim
  plyr::as.quoted
  purrr::as_mapper
  reshape2::colsplit
  sjlabelled::to_numeric
  stringr::fixed
  sjmisc::to_long
  tibble::lst
  tidyselect::enquo
  zoo::as.zoo
}
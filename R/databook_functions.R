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

#' Check if the data is at the variety level
#'
#' @description
#' This function checks whether the specified dataset is Tricot-defined 
#' and whether it is at the variety level. A dataset is considered 
#' "at the variety level" if one of its key columns contains only the variety identifier.
#'
#' @param data A character string specifying the name of the dataset.
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
        
        n_variety_col <- data_frame %>%
          dplyr::distinct(.data[[variety_col_name]], .data[[col]]) %>%
          nrow()
        
        # Compare
        if (n_variety == n_variety_col) {
          print("Success. This data is at the plot level, but it can be used.")
          return(7)
        } else {
          print("This data is at the plot level. Either use variety-level data, or use data where there is only one level of 'col' for each variety level.")
          return(8)
        }
        
      } else {
        print("Only variety level data can be used for this data. This is data where there is a unique row for each variety given.")
        return(2) 
      }
    }
  }
}

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


#' Create and Structure Tricot Data at Multiple Levels
#'
#' This function prepares and structures tricot data by detecting the appropriate data level 
#' (ID, plot, plot-trait, or variety) and creating the necessary data frames and metadata.
#'
#' @param output_data_levels A tibble from `instatExtras`' `summarise_data_levels()` that describes the structure of input data sets. 
#' Must contain at least one dataset at the "id" level.
#' @param id_level_data Optional string. If no dataset is automatically detected at the "id" level, this can be used 
#' to specify the dataset name manually.
#' @param id_col The name of the ID column in the dataset (default is `"id"`).
#' @param good_suffixes Character vector of suffixes used for positive trait rankings (e.g., `"_pos"`, `"_best"`).
#' @param bad_suffixes Character vector of suffixes used for negative trait rankings (e.g., `"_neg"`, `"_worst"`).
#' @param na_candidates Character vector of values considered as missing (e.g., `"Not observed"`). Must be a single value if supplied.
#'
#' @details
#' This function does the following:
#' \enumerate{
#'   \item Detects and defines the ID-level data using the `define_as_tricot()` function.
#'   \item If no plot data is available, it creates it using `instatExtras::pivot_tricot()` based on detected structure.
#'   \item Defines plot and variety-level datasets in the `data_book` with appropriate metadata.
#'   \item Adds a link between the plot and variety datasets.
#'   \item Generates `rankings_list` and `grouped_rankings_list` objects using `gosset::rank_numeric()` and stores them in the `data_book`.
#' }
#'
#' @return The function modifies the `data_book` object by importing, transforming,
#' linking, and defining structured tricot data and storing relevant ranking objects.
#' @export
create_tricot_datasets = function(output_data_levels,
                                  id_level_data = "", id_col = "id", 
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
    tricot_structure <- instatExtras::detect_tricot_structure(data_name_to_get,
                                                              good_suffixes = good_suffixes,
                                                              bad_suffixes = bad_suffixes,
                                                              na_candidates = na_candidates)
    
    # if we have our plot-Trait data then
    if ("plot-trait" %in% output_data_levels$level){
      ivt_data_name_to_get <- data_book$get_data_frame(ivt_data_name)
      if ("id" %in% output_data_levels$level){
        id_data_name_to_get <- data_book$get_data_frame(id_data_name)
        data_by_plot <- instatExtras::pivot_tricot(data_plot_trait = ivt_data_name_to_get,
                                                   data_plot_trait_id_col = ivt_id_col,
                                                   data = id_data_name_to_get,
                                                   data_id_col = id_id_col,
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
    } else if ("id" %in% output_data_levels$level){
      id_data_name_to_get <- data_book$get_data_frame(id_data_name)
      data_by_plot <- instatExtras::pivot_tricot(data = id_data_name_to_get,
                                                 data_id_col = id_id_col,
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
    output_plot_variety_levels_data <- output_data_levels %>% dplyr::filter(level == "variety") 
    plot_by_variety_data_name <- output_plot_variety_levels_data %>% dplyr::pull(dataset)
    plot_variety_col_1 <- output_plot_variety_levels_data %>% dplyr::pull(variety_col)
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
  # You could optionally return or assign this updated output
  return(updated_output_data_levels)
}


#' Create and Structure Tricot Data at Multiple Levels
#'
#' This function prepares and structures tricot data by detecting the appropriate data level 
#' (ID, plot, plot-trait, or variety) and creating the necessary data frames and metadata.
#' It also defines the data within a `data_book` object for further analysis, and generates ranking objects.
#'
#' @param output_data_levels A tibble from `instatExtras`' `summarise_data_levels()` that describes the structure of input data sets. 
#' Must contain at least one dataset at the "id" level.
#' @param id_level_data Optional string. If no dataset is automatically detected at the "id" level, this can be used 
#' to specify the dataset name manually.
#' @param id_col The name of the ID column in the dataset (default is `"id"`).
#' @param good_suffixes Character vector of suffixes used for positive trait rankings (e.g., `"_pos"`, `"_best"`).
#' @param bad_suffixes Character vector of suffixes used for negative trait rankings (e.g., `"_neg"`, `"_worst"`).
#' @param na_candidates Character vector of values considered as missing (e.g., `"Not observed"`). Must be a single value if supplied.
#'
#' @details
#' This function does the following:
#' \enumerate{
#'   \item Detects and defines the ID-level data using the `define_as_tricot()` function.
#'   \item If no plot data is available, it creates it using `instatExtras::pivot_tricot()` based on detected structure.
#'   \item Defines plot and variety-level datasets in the `data_book` with appropriate metadata.
#'   \item Adds a link between the plot and variety datasets.
#'   \item Generates `rankings_list` and `grouped_rankings_list` objects using `gosset::rank_numeric()` and stores them in the `data_book`.
#' }
#'
#' @return The function returns nothing explicitly. It modifies the `data_book` object by importing, transforming,
#' linking, and defining structured tricot data and storing relevant ranking objects.
#' @export
create_tricot_data = function(output_data_levels,
                              id_level_data = "", id_col = "id", 
                              good_suffixes = c("_pos", "_best"), bad_suffixes = c("_neg", "_worst"),
                              na_candidates = c("Not observed", "Not scored", NA_character_)){
  na_candidates <- match.arg(na_candidates)
  ID_COLS <- c("id", "variety", "dummy_variety")
  
  # 0. Check if there are multiple data frames with output_data_levels at ID level ===========
  output_data_levels_check <- output_data_levels %>% dplyr::filter(level != "No marker columns found.")
  if (length(unique(output_data_levels_check$level)) != length(output_data_levels_check$level)){
    stop("Multiple data Sets at the same level. Should only have one data frame at each level.")
  }
  
  # 1. Check their ID level data, and define it.  ============================================
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

  # Create Tricot Structure =====================================================
  data_name_to_get <- data_book$get_data_frame(data_name)
  tricot_structure <- instatExtras::detect_tricot_structure(data_name_to_get,
                                              good_suffixes = good_suffixes,
                                              bad_suffixes = bad_suffixes,
                                              na_candidates = na_candidates)
  
  # Define ID Level Data ========================================================
  data_book$define_as_tricot(data_name = data_name,
                             key_col_names = id_col,
                             types=c(id = id_col,
                                     varieties = tricot_structure$option_cols),
                             auto_selection = TRUE)
  
  # 2. Now for plot Level Data ============================================
  if (!"plot" %in% output_data_levels$level){
    
    # if we have our plot-Trait data then
    if ("plot-trait" %in% output_data_levels$level){
      output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "plot-trait")
      data_name <- output_data_levels_data %>% dplyr::pull(dataset)
      id_col <- output_data_levels_data %>% dplyr::pull(id_col)
      variety_col <- output_data_levels_data %>% dplyr::pull(variety_col)
      trait_col <- output_data_levels_data %>% dplyr::pull(trait_col)
      data_name_to_get <- data_book$get_data_frame(data_name)
      if ("id" %in% output_data_levels$level){
        output_data_levels_data <-output_data_levels %>% dplyr::filter(level == "id")
        id_data_name <- output_data_levels_data %>% dplyr::pull(dataset)
        id_data_name_to_get <- data_book$get_data_frame(id_data_name)
        id_id_col <- output_data_levels_data %>% dplyr::pull(id_col)
        data_by_ID_variety <- instatExtras::pivot_tricot(data_id_variety_trait = data_name_to_get,
                                                         data_id_variety_trait_id_col = id_col,
                                                         data = id_data_name_to_get,
                                                         data_id_col = id_id_col,
                                                         option_cols = tricot_structure$option_cols,
                                                         variety_col = variety_col,
                                                         trait_col = trait_col,
                                                         rank_col = "rank")
      } else {
        data_by_ID_variety <- instatExtras::pivot_tricot(data_id_variety_trait = data_name_to_get,
                                                         data_id_col = id_col,
                                                         variety_col = variety_col,
                                                         trait_col = trait_col,
                                                         rank_col = "rank")
      }
    } else if ("id" %in% output_data_levels$level){
      output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "id")
      data_name <- output_data_levels_data %>% dplyr::pull(dataset)
      id_col <- output_data_levels_data %>% dplyr::pull(id_col)
      data_name_to_get <- data_book$get_data_frame(data_name)
      data_by_ID_variety <- instatExtras::pivot_tricot(data = data_name_to_get,
                                                       data_id_col = id_col,
                                                       option_cols = tricot_structure$option_cols,
                                                       possible_ranks = tricot_structure$ranks,
                                                       trait_good = tricot_structure$trait_good_cols, 
                                                       trait_bad = tricot_structure$trait_bad_cols,
                                                       na_value = tricot_structure$na_candidates)
    } else {
      stop("Invalid data to create plot data")
    }
    
    new_var_name <- paste0(data_name, "_by_ID_variety")
    data_book$import_data(data_tables = setNames(list(data_by_ID_variety), new_var_name))
    
    # Define ID-Varitey Level Data
    id_col <- "id"
    variety_col <- "variety"
    all_traits <- names(data_by_ID_variety %>% dplyr::select(-dplyr::any_of(ID_COLS)))
    
    data_book$define_as_tricot(data_name = new_var_name,
                               key_col_names=c(id_col, variety_col),
                               types=c(variety = variety_col,
                                       id = id_col,
                                       traits = all_traits),
                               auto_selection = TRUE)
    
    # now we create the rankings object
    data_name_id_variety_data <- data_book$get_data_frame(new_var_name)
    rankings_list <- instatExtras::create_rankings_list(data = data_name_id_variety_data,
                                                        traits = all_traits,
                                                        variety = variety_col,
                                                        id = id_col, FALSE)
    data_book$add_object(data_name=new_var_name, object_name="rankings_list", object_type_label="structure", object_format="text", object=rankings_list)
    
    # create grouped rankings object
    grouped_rankings_list <- instatExtras::create_rankings_list(data = data_name_id_variety_data,
                                                                traits = all_traits,
                                                                variety = variety_col,
                                                                id = id_col, TRUE)
    data_book$add_object(data_name = new_var_name, object_name="grouped_rankings_list", object_type_label="structure", object_format="text", object=grouped_rankings_list)
  } else {
    output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "plot")
    data_name_id_variety <- output_data_levels_data %>% dplyr::pull(dataset)
    id_col <- output_data_levels_data %>% dplyr::pull(id_col)
    variety_col <- output_data_levels_data %>% dplyr::pull(variety_col)
    
    # Define plot Level Data
    data_name_id_variety_data <- data_book$get_data_frame(data_name_id_variety)
    all_traits <- names(data_name_id_variety_data %>% dplyr::select(-dplyr::all_of(c(id_col, variety_col))))
    data_book$define_as_tricot(data_name = data_name_id_variety,
                               key_col_names = c(id_col, variety_col),
                               types=c(variety = variety_col,
                                       id = id_col,
                                       traits = all_traits),
                               auto_selection = TRUE)
    
    # now we create the rankings obejct
    rankings_list <- instatExtras::create_rankings_list(data = data_name_id_variety_data,
                                                        traits = all_traits,
                                                        variety = variety_col,
                                                        id = id_col, FALSE)
    data_book$add_object(data_name=data_name_id_variety, object_name="rankings_list", object_type_label="structure", object_format="text", object=rankings_list)
    
    # create grouped rankings object
    grouped_rankings_list <- instatExtras::create_rankings_list(data = data_name_id_variety_data,
                                                                traits = all_traits,
                                                                variety = variety_col,
                                                                id = id_col, TRUE)
    self$add_object(data_name = data_name_id_variety, object_name="grouped_rankings_list", object_type_label="structure", object_format="text", object=grouped_rankings_list)
  }
  
  # 3. Pivot/transformation that gives data at Variety Level too ===================
  if (!"variety" %in% output_data_levels$level){
    data_book$calculate_summary(data_name = paste0(data_name, "_by_ID_variety"),
                                factors = "variety",
                                store_results = TRUE,
                                summaries = c("summary_count"), silent = TRUE)
    # if paste0(data_name, "_by_ID_variety_by_variety") is a data frame in the data
    if (paste0(data_name, "_by_ID_variety_by_variety") %in% data_book$get_data_names()) data_book$rename_dataframe(data_name = paste0(data_name, "_by_ID_variety_by_variety"), new_value=paste0(data_name, "_by_variety"), label="")
    
    # Define Variety-level data
    data_book$define_as_tricot(data_name = paste0(data_name, "_by_variety"),
                               key_col_names = c("variety"),
                               types = c(variety = "variety"),
                               auto_selection = TRUE)
  } else {
    # Define Variety-level data
    output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "variety")
    data_name_variety <- output_data_levels_data %>% dplyr::pull(dataset)
    variety_col <- output_data_levels_data %>% dplyr::pull(variety_col)
    
    data_book$define_as_tricot(data_name = data_name_variety,
                               key_col_names = variety_col ,
                               types = c(variety = variety_col),
                               auto_selection = TRUE)
  }
  
  # 4. Add link between ID-Var and Var level data ================================
  id_variety_data_name <- output_data_levels %>% dplyr::filter(level == "plot") %>% dplyr::pull(dataset)
  if (length(id_variety_data_name) == 0) { id_variety_data_name = paste0(data_name, "_by_ID_variety")}
  # get variety variable
  variety_data_name <- output_data_levels %>% dplyr::filter(level == "variety") %>% dplyr::pull(dataset)
  if (length(variety_data_name) == 0) { variety_data_name = paste0(data_name, "_by_variety")}
  id_variety_data_type <- data_book$get_variables_from_metadata(id_variety_data_name, "Tricot_Type", "variety")
  variety_data_type <- data_book$get_variables_from_metadata(variety_data_name, "Tricot_Type", "variety")
  # Add link from ID_variety to _variety data
  data_book$add_link(from_data_frame = id_variety_data_name,
                     to_data_frame = variety_data_name,
                     link_pairs=c(setNames(list(variety_data_type), id_variety_data_type)), type="keyed_link", link_name="link")
  
  # 5. Create Rankings Objects: =================================================
  traits <- data_book$get_column_selection(data_name = id_variety_data_name, name = "traits_selection") #get_object (all_trial_vars)
  traits <- unname(traits$conditions$C0$parameters$x)
  data_by_ID_variety <- data_book$get_data_frame(id_variety_data_name)
  data_by_ID_variety <- data_by_ID_variety %>%
    tidyr::pivot_longer(cols = all_of(traits), names_to = "trait", values_to = "rank") %>%
    dplyr::group_by(id, trait) %>%
    dplyr::mutate(x = ifelse(any(is.na(rank)), 1, 0)) %>%
    dplyr::filter(x == 0)
  rankings_list <- traits %>%
    purrr::map(~ {
      data_by_ID_variety %>%
        dplyr::filter(trait == .x) %>%
        gosset::rank_numeric(data = ., 
                             items = "variety", 
                             input = "rank", 
                             id = "id", 
                             ascending = TRUE)
    })
  names(rankings_list) <- traits
  data_book$add_object(data_name=id_variety_data_name, object_name="rankings_list", object_type_label="structure", object_format="text", object=rankings_list)
  
  grouped_rankings_list <- traits %>%
    purrr::map(~ {
      data_by_ID_variety %>%
        dplyr::filter(trait == .x) %>%
        gosset::rank_numeric(data = ., 
                             items = "variety", 
                             input = "rank", 
                             id = "id", 
                             group = TRUE,
                             ascending = TRUE)
    })
  names(grouped_rankings_list) <- traits
  data_book$add_object(data_name=id_variety_data_name, object_name="grouped_rankings_list", object_type_label="structure", object_format="text", object=grouped_rankings_list)
}

#' Define Tricot Data in a Data Book
#'
#' This function registers datasets from a tricot experiment into the `data_book` system,
#' defining the key identifiers and variable roles for each data level (ID, plot, and variety).
#' It uses marker columns and suffixes to automatically detect the structure of the dataset
#' and assigns the appropriate tricot metadata to each data level.
#'
#' @param output_data_levels A data frame summarizing the structure and key columns of each dataset,
#' typically created using `instatExtras::summarise_data_levels()`.
#' @param good_suffixes Character vector of suffixes indicating positively ranked options (e.g., `"_pos"`).
#' @param bad_suffixes Character vector of suffixes indicating negatively ranked options (e.g., `"_neg"`).
#' @param na_candidates Character vector of values used to indicate missing or unscored data (e.g., `"Not observed"`).
#' @param trait_cols Optional character vector specifying trait columns in the plot-level dataset. 
#' If `NULL`, they will be inferred automatically.
#'
#' @return No return value. The function modifies the `data_book` by registering datasets with appropriate tricot metadata.
#'
#' @examples
#' # Assuming output_data_levels is available and structured correctly:
#' #define_tricot_data(output_data_levels)
#'
#' @export
define_tricot_data <- function(output_data_levels,
                               good_suffixes = "_pos",
                               bad_suffixes = "_neg", 
                               na_candidates = "Not observed",
                               trait_cols = NULL) {
  
  # 1. Get Tricot Structure =====================================================
  output_data_levels_data <- output_data_levels %>% dplyr::filter(level == "id") %>% dplyr::pull(dataset)
  data_name_to_get <- data_book$get_data_frame(output_data_levels_data)
  tricot_structure <- instatExtras::detect_tricot_structure(data_name_to_get,
                                                            good_suffixes = good_suffixes,
                                                            bad_suffixes = bad_suffixes,
                                                            na_candidates = na_candidates)
  
  # 2. Define Data =================================================================
  # Define ID level data
  ID_data <- output_data_levels %>% dplyr::filter(level == "id")
  ID_data_name <- ID_data %>% dplyr::pull(dataset)
  ID_data_id_var <- ID_data %>% dplyr::pull(id_col)
  data_book$define_as_tricot(data_name = ID_data_name,
                             key_col_names = ID_data_id_var,
                             types = c(id = ID_data_id_var,
                                       varieties = tricot_structure$option_cols),
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
  
  if (is.null(trait_cols)) {
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
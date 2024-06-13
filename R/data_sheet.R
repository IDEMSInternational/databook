#' DataSheet Class
#'
#' An R6 class to handle and manage a data frame with associated metadata, filters, and various settings.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{set_data(new_data, messages, check_names)}}{Sets the data for the DataSheet object.}
#'   \item{\code{set_changes(new_changes)}}{Sets the changes for the DataSheet object.}
#'   \item{\code{set_filters(new_filters)}}{Sets the filters for the DataSheet object.}
#'   \item{\code{set_column_selections(new_column_selections)}}{Sets the column selections for the DataSheet object.}
#'   \item{\code{set_meta(new_meta)}}{Sets the metadata for the DataSheet object.}
#'   \item{\code{clear_metadata()}}{Clears the metadata for the DataSheet object.}
#'   \item{\code{clear_variables_metadata()}}{Clears the variables metadata for the DataSheet object.}
#'   \item{\code{add_defaults_meta()}}{Adds default metadata to the DataSheet object.}
#'   \item{\code{add_defaults_variables_metadata(column_names)}}{Adds default variables metadata to the DataSheet object.}
#'   \item{\code{set_objects(new_objects)}}{Sets the objects for the DataSheet object.}
#'   \item{\code{set_calculations(new_calculations)}}{Sets the calculations for the DataSheet object.}
#'   \item{\code{set_keys(new_keys)}}{Sets the keys for the DataSheet object.}
#'   \item{\code{set_comments(new_comments)}}{Sets the comments for the DataSheet object.}
#'   \item{\code{append_to_metadata(label, value)}}{Appends to the metadata of the DataSheet object.}
#'   \item{\code{is_metadata(label)}}{Checks if a label is in the metadata of the DataSheet object.}
#'   \item{\code{set_data_changed(new_val)}}{Set the data_changed flag.}
#'   \item{\code{set_variables_metadata_changed(new_val)}}{Set the variables_metadata_changed flag.}
#'   \item{\code{set_metadata_changed(new_val)}}{Set the metadata_changed flag.}
#'   \item{\code{get_data_frame(convert_to_character, include_hidden_columns, use_current_filter, use_column_selection, filter_name, column_selection_name, stack_data, remove_attr, retain_attr, max_cols, max_rows, drop_unused_filter_levels, start_row, start_col, ...)}}{Get the data frame with various options for filtering, column selection, and attribute handling.}
#'   \item{\code{get_variables_metadata(data_type, convert_to_character, property, column, error_if_no_property, direct_from_attributes, use_column_selection)}}{Get the metadata for the variables in the data frame.}
#'   \item{\code{get_column_data_types(columns)}}{Get the data types of the specified columns.}
#'   \item{\code{get_column_labels(columns)}}{Get the labels of the specified columns.}
#'   \item{\code{get_data_frame_label(use_current_filter)}}{Get the label of the data frame.}
#'   \item{\code{clear_variables_metadata()}}{Clear the variables metadata.}
#'   \item{\code{get_metadata(label, include_calculated, excluded_not_for_display)}}{Get the metadata for the data frame.}
#'   \item{\code{get_changes()}}{Get the changes made to the data frame.}
#'   \item{\code{get_calculations()}}{Get the calculations applied to the data frame.}
#'   \item{\code{get_calculation_names(as_list, excluded_items)}}{Get the names of the calculations applied to the data frame.}
#'   \item{\code{add_columns_to_data(col_name, col_data, use_col_name_as_prefix, hidden, before, adjacent_column, num_cols, require_correct_length, keep_existing_position)}}{Add new columns to the data frame.}
#'   \item{\code{get_columns_from_data(col_names, force_as_data_frame, use_current_filter, use_column_selection, remove_labels, drop_unused_filter_levels)}}{Get the data for the specified columns.}
#'   \item{\code{anova_tables(x_col_names, y_col_name, signif.stars, sign_level, means)}}{Generate ANOVA tables for the specified columns.}
#'   \item{\code{cor(x_col_names, y_col_name, use, method)}}{Calculate the correlation between specified columns.}
#'   \item{\code{rename_column_in_data(curr_col_name, new_col_name, label, type, .fn, .cols, new_column_names_df, new_labels_df, ...)}}{Renames a column in the data.}
#'   \item{\code{remove_columns_in_data(cols, allow_delete_all)}}{Removes specified columns from the data.}
#'   \item{\code{replace_value_in_data(col_names, rows, old_value, old_is_missing, start_value, end_value, new_value, new_is_missing, closed_start_value, closed_end_value, locf, from_last)}}{Replaces values in the specified columns and rows.}
#'   \item{\code{paste_from_clipboard(col_names, start_row_pos, first_clip_row_is_header, clip_board_text)}}{Pastes data from the clipboard into the specified columns and rows.}
#'   \item{\code{append_to_metadata(property, new_value)}}{Appends a new value to the metadata of the data.}
#'   \item{\code{append_to_variables_metadata(col_names, property, new_val)}}{Appends a new value to the variables metadata.}
#'   \item{\code{append_to_changes(value)}}{Appends a value to the changes list.}
#'   \item{\code{is_metadata(str)}}{Checks if a string is in the metadata.}
#'   \item{\code{is_variables_metadata(str, col, return_vector)}}{Checks if a string is in the variables metadata.}
#'   \item{\code{add_defaults_meta()}}{Adds default values to the metadata.}
#'   \item{\code{add_defaults_variables_metadata(column_names)}}{Adds default values to the variables metadata for the specified columns.}
#'   \item{\code{remove_rows_in_data(row_names)}}{Removes the specified rows from the data.}
#'   \item{\code{get_next_default_column_name(prefix)}}{Gets the next default column name based on the given prefix.}
#'   \item{\code{reorder_columns_in_data(col_order)}}{Reorders the columns in the data based on the given order.}
#'   \item{\code{insert_row_in_data(start_row, row_data, number_rows, before)}}{Inserts new rows into the data at the specified position.}
#'   \item{\code{get_data_frame_length(use_current_filter)}}{Gets the length of the data frame.}
#'   \item{\code{get_factor_data_frame(col_name, include_levels, include_NA_level)}}{Gets the data frame for a factor column with optional inclusion of levels and NA level.}
#'   \item{\code{get_column_factor_levels(col_name)}}{Gets the factor levels for the specified column.}
#'   \item{\code{sort_dataframe(col_names, decreasing, na.last, by_row_names, row_names_as_numeric)}}{Sorts the data frame based on the specified columns.}
#'   \item{\code{convert_column_to_type(col_names, to_type, factor_values, set_digits, set_decimals, keep_attr, ignore_labels, keep.labels)}}{Converts the specified columns to the given type.}
#'   \item{\code{copy_columns(col_names)}}{Copies the specified columns in the data.}
#'   \item{\code{drop_unused_factor_levels(col_name)}}{Drops unused factor levels in the specified column.}
#'   \item{\code{set_factor_levels(col_name, new_labels, new_levels, set_new_labels)}}{Sets the factor levels for the specified column.}
#'   \item{\code{edit_factor_level(col_name, old_level, new_level)}}{Edits a factor level in the specified column.}
#'   \item{\code{set_factor_reference_level(col_name, new_ref_level)}}{Sets the reference level for a factor column.}
#'   \item{\code{reorder_factor_levels(col_name, new_level_names)}}{Reorders the factor levels for the specified column.}
#'   \item{\code{get_column_count(use_column_selection)}}{Gets the count of columns in the data frame.}
#'   \item{\code{get_column_names(as_list, include, exclude, excluded_items, max_no, use_current_column_selection)}}{Gets the names of the columns in the data frame.}
#'   \item{\code{get_data_type(col_name)}}{Gets the data type of the specified column.}
#'   \item{\code{set_hidden_columns(col_names)}}{Sets the specified columns as hidden.}
#'   \item{\code{unhide_all_columns()}}{Unhides all columns.}
#'   \item{\code{set_row_names(row_names)}}{Sets the row names of the data.}
#'   \item{\code{set_col_names(col_names)}}{Sets the column names of the data.}
#'   \item{\code{get_row_names()}}{Gets the row names of the data.}
#'   \item{\code{get_dim_dataframe()}}{Gets the dimensions of the data frame.}
#'   \item{\code{set_protected_columns(col_names)}}{Sets the specified columns as protected.}
#'   \item{\code{add_filter(filter, filter_name, replace, set_as_current, na.rm, is_no_filter, and_or, inner_not, outer_not)}}{Adds a filter to the data.}
#'   \item{\code{add_filter_as_levels(filter_levels, column)}}{Adds multiple filters based on the levels of a specified column.}
#'   \item{\code{get_current_filter()}}{Gets the current filter applied to the data.}
#'   \item{\code{set_current_filter(filter_name)}}{Sets the current filter for the data.}
#'   \item{\code{get_filter_names(as_list, include, exclude, excluded_items)}}{Gets the names of all filters.}
#'   \item{\code{get_filter(filter_name)}}{Gets a specific filter by name.}
#'   \item{\code{get_filter_as_logical(filter_name)}}{Gets the logical vector of a filter.}
#'   \item{\code{get_filter_column_names(filter_name)}}{Gets the column names used in a filter.}
#'   \item{\code{get_current_filter_column_names()}}{Gets the column names used in the current filter.}
#'   \item{\code{filter_applied()}}{Checks if a filter is applied.}
#'   \item{\code{remove_current_filter()}}{Remove the current filter.}
#'   \item{\code{filter_string(filter_name)}}{Returns the string representation of a filter.}
#'   \item{\code{get_filter_as_instat_calculation(filter_name)}}{Returns the filter as an instat calculation object.}
#'   \item{\code{add_column_selection(column_selection, name, replace, set_as_current, is_everything, and_or)}}{Adds a column selection to the data.}
#'   \item{\code{get_current_column_selection()}}{Gets the current column selection applied to the data.}
#'   \item{\code{set_current_column_selection(name)}}{Sets the current column selection for the data.}
#'   \item{\code{get_column_selection_names(as_list, include, exclude, excluded_items)}}{Gets the names of all column selections.}
#'   \item{\code{get_column_selection(name)}}{Gets a specific column selection by name.}
#'   \item{\code{get_column_selection_column_names(name)}}{Gets the column names used in a column selection.}
#'   \item{\code{get_column_selected_column_names(column_selection_name)}}{Gets the selected column names for a given column selection name.}
#'   \item{\code{column_selection_applied()}}{Checks if a column selection is applied.}
#'   \item{\code{remove_current_column_selection()}}{Removes the current column selection.}
#'   \item{\code{get_variables_metadata_fields(as_list, include, exclude, excluded_items)}}{Gets the fields of the variables metadata.}
#'   \item{\code{add_object(object_name, object_type_label, object_format, object)}}{Adds an object with its metadata to the list of objects.}
#'   \item{\code{get_object_names(object_type_label, as_list)}}{Gets the names of objects of a specified type.}
#'   \item{\code{get_objects(object_type_label)}}{Gets objects of a specified type.}
#'   \item{\code{get_object(object_name)}}{Gets a specific object by name.}
#'   \item{\code{rename_object(object_name, new_name, object_type)}}{Renames an object.}
#'   \item{\code{delete_objects(data_name, object_names, object_type)}}{Deletes specified objects.}
#'   \item{\code{reorder_objects(new_order)}}{Reorders the objects.}
#'   \item{\code{data_clone(include_objects, include_metadata, include_logs, include_filters, include_column_selections, include_calculations, include_comments, ...)}}{Clones the data with specified attributes included or excluded.}
#'   \item{\code{freeze_columns(column)}}{Freezes the specified columns.}
#'   \item{\code{unfreeze_columns()}}{Unfreezes all columns.}
#'   \item{\code{add_key(col_names, key_name)}}{Adds a key with specified columns.}
#'   \item{\code{is_key(col_names)}}{Checks if specified columns form a key.}
#'   \item{\code{has_key()}}{Checks if there is a key in the data.}
#'   \item{\code{get_keys(key_name)}}{Gets the keys of the data.}
#'   \item{\code{remove_key(key_name)}}{Removes a specified key.}
#'   \item{\code{get_comments(comment_id)}}{Gets the comments for the data.}
#'   \item{\code{remove_comment(key_name)}}{Removes a comment.}
#'   \item{\code{set_structure_columns(struc_type_1, struc_type_2, struc_type_3)}}{Sets the structure columns of the data.}
#'   \item{\code{add_dependent_columns(columns, dependent_cols)}}{Adds dependent columns to the specified columns.}
#'   \item{\code{set_column_colours(columns, colours)}}{Sets the colours of the specified columns.}
#'   \item{\code{has_colours(columns)}}{Checks if the specified columns have colours.}
#'   \item{\code{set_column_colours_by_metadata(data_name, columns, property)}}{Sets the colours of columns based on metadata property.}
#'   \item{\code{remove_column_colours()}}{Removes the colours of the columns.}
#'   \item{\code{graph_one_variable(columns, numeric, categorical, output, free_scale_axis, ncol, coord_flip, ...)}}{Creates a graph for a single variable.}
#'   \item{\code{make_date_yearmonthday(year, month, day, f_year, f_month, f_day, year_format, month_format)}}{Creates a date from year, month, and day columns.}
#'   \item{\code{make_date_yeardoy(year, doy, base, doy_typical_length)}}{Creates a date from year and day of year columns.}
#' }
#'
#' @section Active bindings:
#' \describe{
#'   \item{\code{data_changed}}{Logical, indicates if the data has changed. If setting a value, \code{new_value} must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{metadata_changed}}{Logical, indicates if the metadata has changed. If setting a value, \code{new_value} must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{variables_metadata_changed}}{Logical, indicates if the variables metadata has changed. If setting a value, \code{new_value} must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{current_filter}}{A list representing the current filter. If setting a value, \code{filter} must be a list.}
#'   \item{\code{current_column_selection}}{A list representing the current column selection. If setting a value, \code{column_selection} must be a list.}
#' }
#'
#' @export
DataSheet <- R6::R6Class(
  "DataSheet",
  public = list(
    #' @description
    #' Create a new DataSheet object.
    #' 
    #' @param data A data frame to be managed by the DataSheet object. Default is an empty data frame.
    #' @param data_name A character string for the name of the data set. Default is an empty string.
    #' @param variables_metadata A data frame containing metadata for the variables. Default is an empty data frame.
    #' @param metadata A list containing additional metadata. Default is an empty list.
    #' @param imported_from A character string indicating the source of the data import. Default is an empty string.
    #' @param messages Logical, if TRUE messages will be shown during the setup. Default is TRUE.
    #' @param convert Logical, if TRUE data will be converted. Default is TRUE.
    #' @param create Logical, if TRUE the data will be created. Default is TRUE.
    #' @param start_point Numeric, the starting point for default naming. Default is 1.
    #' @param filters A list of filters to be applied to the data. Default is an empty list.
    #' @param column_selections A list of column selections. Default is an empty list.
    #' @param objects A list of objects associated with the data. Default is an empty list.
    #' @param calculations A list of calculations to be performed on the data. Default is an empty list.
    #' @param keys A list of keys for the data. Default is an empty list.
    #' @param comments A list of comments associated with the data. Default is an empty list.
    #' @param keep_attributes Logical, if TRUE attributes will be kept. Default is TRUE.
    #' @return A new `DataSheet` object.
    initialize = function(data = data.frame(), data_name = "", 
                          variables_metadata = data.frame(), metadata = list(), 
                          imported_from = "", 
                          messages = TRUE, convert = TRUE, create = TRUE, 
                          start_point = 1, filters = list(), column_selections = list(), objects = list(),
                          calculations = list(), keys = list(), comments = list(), keep_attributes = TRUE) {
      # Set up the data object
      self$set_data(data, messages)
      self$set_changes(list())
      #removed until this can be fixed.
      #self$set_variables_metadata(variables_metadata)
      
      # Set first so that "no_filter" is added
      self$set_filters(filters)
      self$set_column_selections(column_selections)
      if (keep_attributes) {
        self$set_meta(c(attributes(private$data), metadata))
      } else {
        self$set_meta(metadata)
        self$clear_variables_metadata()
      }
      self$add_defaults_meta()
      self$add_defaults_variables_metadata(self$get_column_names())
      #self$update_variables_metadata()
      self$set_objects(objects)
      self$set_calculations(calculations)
      self$set_keys(keys)
      self$set_comments(comments)
      
      # If no name for the data.frame has been given in the list we create a default one.
      # Decide how to choose default name index
      if (!(is.null(data_name) || data_name == "" || missing(data_name))) {
        if (data_name != make.names(iconv(data_name, to = "ASCII//TRANSLIT", sub = "."))) {
          message("data_name is invalid. It will be made valid automatically.")
          data_name <- make.names(iconv(data_name, to = "ASCII//TRANSLIT", sub = "."))
        }
        self$append_to_metadata(data_name_label, data_name)
      } else if (!self$is_metadata(data_name_label)) {
        if ((is.null(data_name) || data_name == "" || missing(data_name))) {
          self$append_to_metadata(data_name_label, paste0("data_set_", sprintf("%03d", start_point)))
          if (messages) {
            message(paste0("No name specified in data_tables list for data frame ", start_point, ". 
                       Data frame will have default name: ", "data_set_", sprintf("%03d", start_point)))
          }
        } else {
          self$append_to_metadata(data_name_label, data_name)     
        }
      }
    },
    #' @description 
    #' Sets the data for the DataSheet object. Accepts various data types and converts them to a data frame.
    #' 
    #' @param new_data The new data to be set. It can be a matrix, tibble, data.table, ts object, array, or vector.
    #' @param messages Logical, if TRUE, messages will be shown during the data setup. Default is TRUE.
    #' @param check_names Logical, if TRUE, column names will be checked and made valid if necessary. Default is TRUE.
    #' 
    #' @return The DataSheet object with the updated data.
    set_data = function(new_data, messages = TRUE, check_names = TRUE) {
      if (is.matrix(new_data)) new_data <- as.data.frame(new_data)
      # This case could happen when removing rows
      # as.data.frame preserves column and data frame attributes so no issue with this
      else if (tibble::is_tibble(new_data) || data.table::is.data.table(new_data)) new_data <- as.data.frame(new_data)
      # TODO convert ts objects correctly
      else if (is.ts(new_data)) {
        ind <- zoo::index(new_data)
        new_data <- data.frame(index = ind, value = new_data)
      }
      else if (is.array(new_data)) {
        new_data <- as.data.frame(new_data)
      }
      else if (is.vector(new_data) && !is.list(new_data)) {
        new_data <- as.data.frame(new_data)
      }
      
      if (!is.data.frame(new_data)) {
        stop("Data set must be of type: data.frame")
      }
      else {
        if (length(new_data) == 0 && messages) {
          message("data is empty. Data will be an empty data frame.")
        }
        if (check_names) {
          # "T" should be avoided as a column name but is not checked by make.names()
          if ("T" %in% names(new_data)) names(new_data)[names(new_data) == "T"] <- ".T"
          valid_names <- make.names(iconv(names(new_data), to = "ASCII//TRANSLIT", sub = "."), unique = TRUE)
          if (!all(names(new_data) == valid_names)) {
            warning("Not all column names are syntactically valid or unique. make.names() and iconv() will be used to force them to be valid and unique.")
            names(new_data) <- valid_names
          }
        }
        private$data <- new_data
        self$append_to_changes(list(Set_property, "data"))
        self$data_changed <- TRUE
        self$variables_metadata_changed <- TRUE
      }
    },
    
    #' @description 
    #' Sets the metadata for the DataSheet object.
    #' @param new_meta A list containing the new metadata.
    set_meta = function(new_meta) {
      meta_data_copy <- new_meta
      self$clear_metadata()
      if (!is.list(meta_data_copy)) stop("new_meta must be of type: list")
      for (name in names(meta_data_copy)) {
        self$append_to_metadata(name, meta_data_copy[[name]])
      }
      self$metadata_changed <- TRUE
      self$append_to_changes(list(Set_property, "meta data"))
    },
    
    #' @description 
    #' Clears the metadata for the DataSheet object.
    clear_metadata = function() {
      for (name in names(attributes(private$data))) {
        if (!name %in% c(data_type_label, data_name_label, "row.names", "names")) attr(private$data, name) <- NULL
      }
      self$add_defaults_meta()
      self$metadata_changed <- TRUE
      self$append_to_changes(list(Set_property, "meta data"))
    },
    
    #' @description 
    #' Sets the changes for the DataSheet object.
    #' @param new_changes A list containing the new changes.
    set_changes = function(new_changes) {
      if (!is.list(new_changes)) stop("Changes must be of type: list")
      private$changes <- new_changes
      self$append_to_changes(list(Set_property, "changes"))  
    },
    
    #' @description 
    #' Sets the filters for the DataSheet object.
    #' @param new_filters A list containing the new filters.
    set_filters = function(new_filters) {
      if (!is.list(new_filters)) stop("Filters must be of type: list")
      self$append_to_changes(list(Set_property, "filters"))  
      private$filters <- new_filters
      if (!"no_filter" %in% names(private$filters)) {
        self$add_filter(filter = list(), filter_name = "no_filter", replace = TRUE, set_as_current = TRUE, na.rm = FALSE, is_no_filter = TRUE)
      }
    },
    #' @description 
    #' Sets the column selections for the DataSheet object.
    #' @param new_column_selections A list containing the new column selections.
    set_column_selections = function(new_column_selections) {
      stopifnot(is.list(new_column_selections))
      self$append_to_changes(list(Set_property, "column selections"))  
      private$column_selections <- new_column_selections
      if (!".everything" %in% names(private$column_selections)) {
        self$add_column_selection(column_selection = list(), name = ".everything", replace = TRUE, set_as_current = TRUE, is_everything = TRUE)
      }
    },
    #' @description 
    #' Sets the objects for the DataSheet object.
    #' @param new_objects A list containing the new objects.
    set_objects = function(new_objects) {
      if (!is.list(new_objects)) stop("new_objects must be of type: list")
      self$append_to_changes(list(Set_property, "objects"))  
      private$objects <- new_objects
    },
    
    #' @description 
    #' Sets the calculations for the DataSheet object.
    #' @param new_calculations A list containing the new calculations.
    set_calculations = function(new_calculations) {
      if (!is.list(new_calculations)) stop("new_calculations must be of type: list")
      self$append_to_changes(list(Set_property, "calculations"))  
      private$calculations <- new_calculations
    },
    
    #' @description 
    #' Sets the keys for the DataSheet object.
    #' @param new_keys A list containing the new keys.
    set_keys = function(new_keys) {
      if (!is.list(new_keys)) stop("new_keys must be of type: list")
      self$append_to_changes(list(Set_property, "keys"))  
      private$keys <- new_keys
    },
    
    #' @description 
    #' Sets the comments for the DataSheet object.
    #' @param new_comments A list containing the new comments.
    set_comments = function(new_comments) {
      if (!is.list(new_comments)) stop("new_comments must be of type: list")
      self$append_to_changes(list(Set_property, "comments"))  
      private$comments <- new_comments
    },
    
    #' @description 
    #' Set the data_changed flag.
    #' @param new_val Logical, new value for the data_changed flag.
    set_data_changed = function(new_val) {
      self$data_changed <- new_val
    },
    
    #' @description 
    #' Set the variables_metadata_changed flag.
    #' @param new_val Logical, new value for the variables_metadata_changed flag.
    set_variables_metadata_changed = function(new_val) {
      self$variables_metadata_changed <- new_val
    },
    
    
    #' @description 
    #' Set the metadata_changed flag.
    #' @param new_val Logical, new value for the metadata_changed flag.
    set_metadata_changed = function(new_val) {
      self$metadata_changed <- new_val
    },
    
    #' @description 
    #' Get the data frame with various options for filtering, column selection, and attribute handling.
    #' @param convert_to_character Logical, if TRUE converts the data to character format.
    #' @param include_hidden_columns Logical, if TRUE includes hidden columns in the output.
    #' @param use_current_filter Logical, if TRUE uses the current filter applied to the data.
    #' @param use_column_selection Logical, if TRUE uses the current column selection.
    #' @param filter_name Character, specifies the name of the filter to use.
    #' @param column_selection_name Character, specifies the name of the column selection to use.
    #' @param stack_data Logical, if TRUE stacks the data.
    #' @param remove_attr Logical, if TRUE removes certain attributes from the data.
    #' @param retain_attr Logical, if TRUE retains certain attributes in the data.
    #' @param max_cols Numeric, specifies the maximum number of columns to include in the output.
    #' @param max_rows Numeric, specifies the maximum number of rows to include in the output.
    #' @param drop_unused_filter_levels Logical, if TRUE drops unused levels from factors in the filtered data.
    #' @param start_row Numeric, specifies the starting row for the output.
    #' @param start_col Numeric, specifies the starting column for the output.
    #' @param ... Additional arguments passed to internal functions.
    #' @return A data frame with the specified options applied.
    get_data_frame = function(convert_to_character = FALSE, include_hidden_columns = TRUE, use_current_filter = TRUE, use_column_selection = TRUE, filter_name = "", column_selection_name = "", stack_data = FALSE, remove_attr = FALSE, retain_attr = FALSE, max_cols, max_rows, drop_unused_filter_levels = FALSE, start_row, start_col, ...) {
      if(!stack_data) {
        if(!include_hidden_columns && self$is_variables_metadata(is_hidden_label)) {
          hidden <- self$get_variables_metadata(property = is_hidden_label)
          hidden[is.na(hidden)] <- FALSE
          out <- private$data[!hidden]
        } else {
          out <- private$data
        }
        nam <- names(out)
        if(use_current_filter && self$filter_applied()) {
          if(filter_name != "") {
            out <- out[self$current_filter & self$get_filter_as_logical(filter_name = filter_name), ]
          } else {
            out <- out[self$current_filter, ]
            if(drop_unused_filter_levels) out <- drop_unused_levels(out, self$get_current_filter_column_names())
          }
        } else {
          if(filter_name != "") {
            out <- out[self$get_filter_as_logical(filter_name = filter_name), ]
          }
        }
        if(column_selection_name != "") {
          selected_columns <- self$get_column_selection_column_names(column_selection_name)
          missing_columns <- selected_columns[!selected_columns %in% names(private$data)]
          if(!length(missing_columns) > 0) {
            out <- out[, selected_columns, drop = FALSE]
          }
        }
        if(use_column_selection && self$column_selection_applied()) {
          old_metadata <- attributes(private$data)
          selected_columns <- self$get_column_names()
          missing_columns <- selected_columns[!selected_columns %in% names(private$data)]
          if(!length(missing_columns) > 0) {
            out <- out[, selected_columns, drop = FALSE]
            for(name in names(old_metadata)) {
              if(!(name %in% c("names", "class", "row.names"))) {
                attr(out, name) <- old_metadata[[name]]
              }
            }
            all_columns <- self$get_column_names(use_current_column_selection = FALSE)
            hidden_cols <- all_columns[!(all_columns %in% selected_columns)]
            self$append_to_variables_metadata(hidden_cols, is_hidden_label, TRUE)
            private$.variables_metadata_changed <- TRUE
          }
        }
        if(!is.data.frame(out)) {
          out <- data.frame(out)
          if(length(nam) == length(out)) names(out) <- nam
        }
        if(remove_attr) {
          for(i in seq_along(out)) {
            attributes(out[[i]])[!names(attributes(out[[i]])) %in% c("class", "levels")] <- NULL
          }
        }
        if(retain_attr) {
          for(col_name in names(out)) {
            private_attr_names <- names(attributes(private$data[[col_name]]))
            for(attr_name in private_attr_names) {
              if(!attr_name %in% c("class", "names")) {
                private_attr <- attr(private$data[[col_name]], attr_name)
                if(!is.null(private_attr)) {
                  attr(out[[col_name]], attr_name) <- private_attr
                }
              }
            }
          }
        }
        if(!missing(start_col) && start_col <= ncol(out)) {
          if(!missing(max_cols)) {
            if(max_cols + start_col > ncol(out)) {
              out <- out[start_col:ncol(out)]
            } else {
              out <- out[start_col:(start_col + max_cols - 1)]
            }
          } else {
            out <- out[start_col:ncol(out)]
          }
        } else if(!missing(max_cols) && max_cols < ncol(out)) {
          out <- out[1:max_cols]
        }
        if(!missing(start_row) && start_row <= nrow(out)) {
          if(!missing(max_rows)) {
            if(max_rows + start_row > nrow(out)) {
              if(ncol(out) == 1) {
                rnames <- row.names(out)[start_row:nrow(out)]
                out <- as.data.frame(dplyr::slice(out, start_row:nrow(out)))
                row.names(out) <- rnames
              } else {
                out <- out[start_row:nrow(out), ]
              }
            } else {
              if(ncol(out) == 1) {
                rnames <- row.names(out)[start_row:(start_row + max_rows - 1)]
                out <- as.data.frame(dplyr::slice(out, start_row:(start_row + max_rows - 1)))
                row.names(out) <- rnames
              } else {
                out <- out[start_row:(start_row + max_rows - 1), ]
              }
            }
          } else {
            if(ncol(out) == 1) {
              rnames <- row.names(out)[start_row:nrow(out)]
              out <- as.data.frame(dplyr::slice(out, start_row:nrow(out)))
              row.names(out) <- rnames
            } else {
              out <- out[start_row:nrow(out), ]
            }
          }
        } else if(!missing(max_rows) && max_rows < nrow(out)) {
          if(ncol(out) == 1) {
            rnames <- row.names(out)[1:max_rows]
            out <- as.data.frame(dplyr::slice(out, 1:max_rows))
            row.names(out) <- rnames
          } else {
            out <- out[1:max_rows, ]  
          }
        }
        if(convert_to_character) {
          decimal_places <- self$get_variables_metadata(property = signif_figures_label, column = names(out), error_if_no_property = FALSE, use_column_selection = use_column_selection) 
          scientific_notation <- self$get_variables_metadata(property = scientific_label, column = names(out), error_if_no_property = FALSE)
          return(convert_to_character_matrix(data = out, format_decimal_places = TRUE, decimal_places = decimal_places, is_scientific = scientific_notation))
        } else {
          return(out)
        }
      } else {
        return(reshape2::melt(self$get_data_frame(include_hidden_columns = include_hidden_columns, use_current_filter = use_current_filter, filter_name = filter_name), ...))
      }
    },
    
    #' @description 
    #' Get the metadata for the variables in the data frame.
    #' @param data_type Character, the data type to filter by. Default is "all".
    #' @param convert_to_character Logical, if TRUE converts the metadata to character format.
    #' @param property Character, the property of the metadata to retrieve.
    #' @param column Character, the column to retrieve metadata for.
    #' @param error_if_no_property Logical, if TRUE throws an error if the property is not found.
    #' @param direct_from_attributes Logical, if TRUE retrieves metadata directly from attributes.
    #' @param use_column_selection Logical, if TRUE uses the current column selection.
    #' @return A data frame or list of metadata for the variables.
    get_variables_metadata = function(data_type = "all", convert_to_character = FALSE, property, column, error_if_no_property = TRUE, direct_from_attributes = FALSE, use_column_selection = TRUE) {
      if(direct_from_attributes) {
        if(missing(property)) return(attributes(private$data[[column]]))
        else return(attr(private$data[[column]], property))
      } else if(!missing(property) && length(property == 1) && property == data_type_label) {
        if(missing(column)) column <- names(private$data)
        out <- sapply(private$data[column], class)
        out <- sapply(out, function(x) paste(unlist(x), collapse = ","))
        return(as.vector(out))
      } else {
        out <- list()
        if(missing(column)) {
          curr_data <- private$data
          cols <- names(curr_data)
          if(self$column_selection_applied()) cols <- self$current_column_selection
        } else {
          cols <- column
          if(self$column_selection_applied()) cols <- self$current_column_selection
          curr_data <- private$data[column]
        }
        for(i in seq_along(cols)) {
          col <- curr_data[[cols[i]]]
          ind <- which(names(attributes(col)) == "levels")
          if(length(ind) > 0) col_attributes <- attributes(col)[-ind]
          else col_attributes <- attributes(col)
          if(is.null(col_attributes)) col_attributes <- list()
          col_attributes[[data_type_label]] <- class(col)
          for(j in seq_along(col_attributes)) {
            att_name <- names(col_attributes)[j]
            if(att_name == labels_label) {
              num_labels <- length(col_attributes[[att_name]])    
              max_labels <- min(max_labels_display, num_labels)    
              col_attributes[[att_name]] <- paste(names(col_attributes[[att_name]])[1:max_labels], "=", col_attributes[[att_name]][1:max_labels], collapse = ", ")    
              if(num_labels > max_labels) col_attributes[[att_name]] <- paste0(col_attributes[[att_name]], "...")    
            } else if(is.list(col_attributes[[att_name]]) || length(col_attributes[[att_name]]) > 1) {
              col_attributes[[att_name]] <- paste(unlist(col_attributes[[att_name]]), collapse = ",")
            }
          }
          col_attributes <- data.frame(col_attributes, stringsAsFactors = FALSE)
          out[[i]] <- col_attributes
        }
        out <- plyr::rbind.fill(out)
        out <- as.data.frame(out)
        if(all(c(name_label, label_label) %in% names(out))) {
          out <- out[c(c(name_label, label_label), sort(setdiff(names(out), c(name_label, label_label))))]
        } else if(name_label %in% names(out)) {
          out <- out[c(name_label, sort(setdiff(names(out), name_label)))]
        }
        row.names(out) <- cols
        if(data_type != "all") {
          if(data_type == "numeric") {
            out <- out[out[[data_type_label]] %in% c("numeric", "integer"), ]
          } else {
            out <- out[out[[data_type_label]] == data_type, ]        
          }
        }
        not_found <- FALSE
        if(!missing(property)) {
          if(!property %in% names(out)) {
            if(error_if_no_property) stop(property, " not found in variables metadata")
            not_found <- TRUE
          }
          if(!missing(column)) {
            if(!all(column %in% names(private$data))) stop(column, " not found in data")
            if(not_found) out <- rep(NA, length(column))
            else out <- out[column, property]
          } else {
            if(not_found) out <- rep(NA, ncol(private$data))
            else out <- out[, property]
          }
        }
        if(is.data.frame(out)) row.names(out) <- NULL
        if(convert_to_character && missing(property)) return(convert_to_character_matrix(out, FALSE))
        else return(out)
      }
    },
    
    #' @description 
    #' Get the data types of the specified columns.
    #' @param columns Character vector, names of the columns to get data types for.
    #' @return A character vector of data types for the specified columns.
    get_column_data_types = function(columns) {
      if(missing(columns)) return(as.vector(sapply(private$data, function(x) paste(class(x), collapse = ","))))
      else return(as.vector(sapply(private$data[columns], function(x) paste(class(x), collapse = ","), USE.NAMES = FALSE)))
    },
    
    #' @description 
    #' Get the labels of the specified columns.
    #' @param columns Character vector, names of the columns to get labels for.
    #' @return A character vector of labels for the specified columns.
    get_column_labels = function(columns) {
      if(missing(columns)) return(as.vector(sapply(private$data, function(x) paste(attr(x, "label"), collapse = ","))))
      else return(as.vector(sapply(private$data[columns], function(x) paste(attr(x, "label"), collapse = ","), USE.NAMES = FALSE)))
    },
    
    #' @description 
    #' Get the label of the data frame.
    #' @param use_current_filter Logical, if TRUE uses the current filter applied to the data.
    #' @return A character string representing the label of the data frame.
    get_data_frame_label = function(use_current_filter = FALSE) {
      return(attr(self$get_data_frame(use_current_filter = use_current_filter), "label"))
    },
    
    #' @description 
    #' Clear the variables metadata.
    clear_variables_metadata = function() {
      for(column in self$get_data_frame(use_current_filter = FALSE)) {
        for(name in names(attributes(column))) {
          if(!name %in% c(data_type_label, data_name_label)) attr(self, name) <- NULL
        }
      }
      self$add_defaults_variables_metadata(self$get_column_names())
    },
    
    #' @description 
    #' Get the metadata for the data frame.
    #' @param label Character, specifies the metadata label to retrieve.
    #' @param include_calculated Logical, if TRUE includes calculated metadata.
    #' @param excluded_not_for_display Logical, if TRUE excludes metadata not for display.
    #' @return A list of metadata for the data frame.
    get_metadata = function(label, include_calculated = TRUE, excluded_not_for_display = TRUE) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      n_row <- self$get_data_frame_length(use_current_filter = TRUE)
      if(missing(label)) {
        if(include_calculated) {
          attr(curr_data, row_count_label) <- n_row
          attr(curr_data, column_count_label) <- ncol(curr_data)
        }
        if(excluded_not_for_display) {
          ind <- which(names(attributes(curr_data)) %in% c("names", "row.names"))
          if(length(ind) > 0) out <- attributes(curr_data)[-ind]
        } else {
          out <- attributes(curr_data)
        }
        return(out)
      } else {
        if(label %in% names(attributes(curr_data))) return(attributes(curr_data)[[label]])
        else if(label == row_count_label) return(n_row)
        else if(label == column_count_label) return(ncol(curr_data))
        else return("")
      }
    },
    
    #' @description 
    #' Get the changes made to the data frame.
    #' @return A list of changes made to the data frame.
    get_changes = function() {
      return(private$changes)
    },
    
    #' @description 
    #' Get the calculations applied to the data frame.
    #' @return A list of calculations applied to the data frame.
    get_calculations = function() {
      return(private$calculations)
    },
    
    #' @description 
    #' Get the names of the calculations applied to the data frame.
    #' @param as_list Logical, if TRUE returns the names as a list.
    #' @param excluded_items Character vector, names of calculations to exclude.
    #' @return A character vector or list of calculation names.
    get_calculation_names = function(as_list = FALSE, excluded_items = c()) {
      out = names(private$calculations)
      if(length(excluded_items) > 0) {
        ex_ind = which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of calculations")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(!as_list) {
        return(out)
      }
      lst = list()
      lst[[self$get_metadata(data_name_label)]] <- out
      return(lst)
    },
    
    #' @description 
    #' Add new columns to the data frame.
    #' @param col_name Character, name of the new column.
    #' @param col_data Data, the data for the new column.
    #' @param use_col_name_as_prefix Logical, if TRUE uses the column name as a prefix.
    #' @param hidden Logical, if TRUE the new column will be hidden.
    #' @param before Logical, if TRUE adds the new column before the specified adjacent column.
    #' @param adjacent_column Character, name of the adjacent column.
    #' @param num_cols Numeric, number of columns to add.
    #' @param require_correct_length Logical, if TRUE requires the new column to have the correct length.
    #' @param keep_existing_position Logical, if TRUE keeps the existing position of the new column.
    #' @return The updated data frame with the new columns added.
    add_columns_to_data = function(col_name = "", col_data, use_col_name_as_prefix = FALSE, hidden = FALSE, before, adjacent_column = "", num_cols, require_correct_length = TRUE, keep_existing_position = TRUE) {
      if(!is.character(col_name)) stop("Column name must be of type: character")
      if(missing(num_cols)) {
        if(missing(col_data)) stop("One of num_cols or col_data must be specified.")
        if(!missing(col_data) && (is.matrix(col_data) || is.data.frame(col_data))) {
          num_cols = ncol(col_data)
        } else {
          num_cols = 1
        }
        if(tibble::is_tibble(col_data)) col_data <- data.frame(col_data)
      } else {
        if(missing(col_data)) col_data = replicate(num_cols, rep(NA, self$get_data_frame_length()))
        else {
          if(length(col_data) != 1) stop("col_data must be a vector/matrix/data.frame of correct length or a single value to be repeated.")
          col_data = replicate(num_cols, rep(col_data, self$get_data_frame_length()))
        }
      }
      if(col_name != "" && (length(col_name) != 1) && (length(col_name) != num_cols)) stop("col_name must be a character or character vector with the same length as the number of new columns")
      if(col_name == "") {
        if(!is.null(colnames(col_data)) && length(colnames(col_data)) == num_cols) {
          col_name = colnames(col_data)
        } else {
          col_name = "X"
          use_col_name_as_prefix = TRUE
        }
      }
      if(length(col_name) != num_cols) {
        use_col_name_as_prefix = TRUE
      }
      replaced <- FALSE
      previous_length = self$get_column_count()
      if(adjacent_column != "" && !adjacent_column %in% self$get_column_names()) stop(adjacent_column, "not found in the data")
      new_col_names <- c()
      for(i in 1:num_cols) {
        if(num_cols == 1) {
          curr_col = col_data
        } else {
          curr_col = col_data[,i]
        }
        if(is.matrix(curr_col) || is.data.frame(curr_col)) curr_col = curr_col[,1]
        if(self$get_data_frame_length() %% length(curr_col) != 0) {
          if(require_correct_length) stop("Length of new column must be divisible by the length of the data frame")
          else curr_col <- rep(curr_col, length.out = self$get_data_frame_length())
        }
        if(use_col_name_as_prefix) curr_col_name = self$get_next_default_column_name(col_name[i])
        else curr_col_name = col_name[[i]]
        curr_col_name <- make.names(iconv(curr_col_name, to = "ASCII//TRANSLIT", sub = "."))
        new_col_names <- c(new_col_names, curr_col_name)
        if(curr_col_name %in% self$get_column_names()) {
          message(paste("A column named", curr_col_name, "already exists. The column will be replaced in the data"))
          self$append_to_changes(list(Replaced_col, curr_col_name))
          replaced <- TRUE
        } else {
          self$append_to_changes(list(Added_col, curr_col_name))
        }
        private$data[[curr_col_name]] <- curr_col
        self$data_changed <- TRUE
      }
      self$add_defaults_variables_metadata(new_col_names)
      if((replaced && keep_existing_position) || (missing(before) && adjacent_column == "")) return()
      if(before) {
        if(adjacent_column == "") adjacent_position <- 0
        else adjacent_position <- which(self$get_column_names(use_current_column_selection = FALSE) == adjacent_column) - 1
      } else {
        if(adjacent_column == "") adjacent_position <- self$get_column_count()
        else adjacent_position <- which(self$get_column_names(use_current_column_selection = FALSE) == adjacent_column)
      }
      temp_all_col_names <- replace(self$get_column_names(use_current_column_selection = FALSE), self$get_column_names(use_current_column_selection = FALSE) %in% new_col_names, "")
      new_col_names_order <- append(temp_all_col_names, new_col_names, adjacent_position)
      new_col_names_order <- new_col_names_order[! new_col_names_order == ""]
      if(!all(self$get_column_names(use_current_column_selection = FALSE) == new_col_names_order)) self$reorder_columns_in_data(col_order = new_col_names_order)
    },
    
    #' @description 
    #' Get the data for the specified columns.
    #' @param col_names Character vector, names of the columns to retrieve.
    #' @param force_as_data_frame Logical, if TRUE forces the output to be a data frame.
    #' @param use_current_filter Logical, if TRUE uses the current filter applied to the data.
    #' @param use_column_selection Logical, if TRUE uses the current column selection.
    #' @param remove_labels Logical, if TRUE removes labels from the data.
    #' @param drop_unused_filter_levels Logical, if TRUE drops unused levels from factors in the filtered data.
    #' @return A data frame or vector of the specified columns.
    get_columns_from_data = function(col_names, force_as_data_frame = FALSE, use_current_filter = TRUE, use_column_selection = TRUE, remove_labels = FALSE, drop_unused_filter_levels = FALSE) {
      if(missing(col_names)) stop("no col_names to return")
      if(!all(col_names %in% names(private$data))) stop("Not all column names were found in data")
      if(length(col_names) == 1) {
        if(force_as_data_frame) {
          dat <- self$get_data_frame(use_current_filter = use_current_filter, use_column_selection = use_column_selection, drop_unused_filter_levels = drop_unused_filter_levels)[col_names]
          if(remove_labels) {
            for(i in seq_along(dat)) {
              if(!is.numeric(dat[[i]])) attr(dat[[i]], "labels") <- NULL
            }
          }
          return(dat)
        } else {
          dat <- self$get_data_frame(use_current_filter = use_current_filter, use_column_selection = use_column_selection, drop_unused_filter_levels = drop_unused_filter_levels)[[col_names]]
          if(remove_labels && !is.numeric(dat)) attr(dat, "labels") <- NULL
          return(dat)
        }
      } else {
        dat <- self$get_data_frame(use_current_filter = use_current_filter, use_column_selection = use_column_selection, drop_unused_filter_levels = drop_unused_filter_levels)[col_names]
        if(remove_labels) {
          for(i in seq_along(dat)) {
            if(!is.numeric(dat[[i]])) attr(dat[[i]], "labels") <- NULL
          }
        }
        return(dat)
      }
    },
    
    #' @description 
    #' Generate ANOVA tables for the specified columns.
    #' @param x_col_names Character vector, names of the columns to use as independent variables.
    #' @param y_col_name Character, name of the dependent variable column.
    #' @param signif.stars Logical, if TRUE includes significance stars in the output.
    #' @param sign_level Logical, if TRUE includes significance levels in the output.
    #' @param means Logical, if TRUE includes means in the output.
    anova_tables = function(x_col_names, y_col_name, signif.stars = FALSE, sign_level = FALSE, means = FALSE) {
      if(missing(x_col_names) || missing(y_col_name)) stop("Both x_col_names and y_col_names are required")
      if(sign_level || signif.stars) message("This is no longer descriptive")
      if(sign_level) end_col = 5 else end_col = 4
      for(i in seq_along(x_col_names)) {
        mod <- lm(formula = as.formula(paste0("as.numeric(", as.name(y_col_name), ") ~ ", as.name(x_col_names[i]))), data = self$get_data_frame())
        cat("ANOVA table: ", y_col_name, " ~ ", x_col_names[i], "\n", sep = "")
        print(anova(mod)[1:end_col], signif.stars = signif.stars)
        cat("\n")
        if(means) print(model.tables(aov(mod), type = "means"))
      }
    },
    
    #' @description 
    #' Calculate the correlation between specified columns.
    #' 
    #' @param x_col_names Character vector, names of the columns to use as independent variables.
    #' @param y_col_name Character, name of the dependent variable column.
    #' @param use Character, specifies the handling of missing values. Default is "everything".
    #' @param method Character vector, specifies the correlation method to be used. One of "pearson", "kendall", or "spearman". Default is c("pearson", "kendall", "spearman").
    #' 
    #' @return A matrix of correlation coefficients between the specified columns.
    #' 
    cor = function(x_col_names, y_col_name, use = "everything", method = c("pearson", "kendall", "spearman")) {
      x <- self$get_columns_from_data(x_col_names, force_as_data_frame = TRUE)
      y <- self$get_columns_from_data(y_col_name)
      x <- sapply(x, as.numeric)
      y <- as.numeric(y)
      results <- cor(x = x, y = y, use = use, method = method)
      dimnames(results)[[2]] <- y_col_name
      cat("Correlations:\n")
      return(t(results))
    },
    #' @description
    #' Rename a column in the data.
    #'
    #' @param curr_col_name Character, the current name of the column.
    #' @param new_col_name Character, the new name for the column.
    #' @param label Character, the label for the column.
    #' @param type Character, the type of renaming to perform.
    #' @param .fn Function, the function to use for renaming.
    #' @param .cols Character, the columns to rename.
    #' @param new_column_names_df Data frame, the new column names.
    #' @param new_labels_df Data frame, the new labels for the columns.
    #' @param ... Additional arguments passed to the function.
    rename_column_in_data = function(curr_col_name = "", new_col_name = "", label = "", type = "single", .fn, .cols = everything(), new_column_names_df, new_labels_df, ...) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE, use_column_selection = FALSE)
      # Column name must be character
      if (type == "single") {
        if (new_col_name != curr_col_name) {
          if (new_col_name %in% names(curr_data)) {
            stop("Cannot rename this column. A column named: ", new_col_name, " already exists in the data.")
          }
          if (!is.character(curr_col_name)) {
            stop("Current column name must be of type: character")
          } else if (!(curr_col_name %in% names(curr_data))) {
            stop(paste0("Cannot rename column: ", curr_col_name, ". Column was not found in the data."))
          } else if (!is.character(new_col_name)) {
            stop("New column name must be of type: character")
          } else {
            if (sum(names(curr_data) == curr_col_name) > 1) {
              # Should never happen since column names must be unique
              warning("Multiple columns have name: '", curr_col_name, "'. All such columns will be renamed.")
            }
            # remove key
            get_key <- self$get_variables_metadata() %>% dplyr::filter(Name == curr_col_name)
            if (!is.null(get_key$Is_Key)){
              if (!is.na(get_key$Is_Key) && get_key$Is_Key){
                active_keys <- self$get_keys()
                keys_to_delete <- which(grepl(curr_col_name, active_keys))
                keys_to_delete <- purrr::map_chr(.x = keys_to_delete, .f = ~names(active_keys[.x]))
                purrr::map(.x = keys_to_delete, .f = ~self$remove_key(key_name = names(active_keys[.x])))
              }
            }
            if(self$column_selection_applied()) self$remove_current_column_selection()
            # Need to use private$data here because changing names of data field
            names(private$data)[names(curr_data) == curr_col_name] <- new_col_name
            self$append_to_variables_metadata(new_col_name, name_label, new_col_name)
            # TODO decide if we need to do these 2 lines
            self$append_to_changes(list(Renamed_col, curr_col_name, new_col_name))
            self$data_changed <- TRUE
            self$variables_metadata_changed <- TRUE
          }
        }
        if (label != "") {
          self$append_to_variables_metadata(col_name = new_col_name, property = "label", new_val = label)
          self$variables_metadata_changed <- TRUE
        }
      } else if (type == "multiple") {
        if (!missing(new_column_names_df)) {
          new_col_names <- new_column_names_df[, 1]
          cols_changed_index <- new_column_names_df[, 2]
          curr_col_names <- names(private$data)
          curr_col_names[cols_changed_index] <- new_col_names
          if(any(duplicated(curr_col_names))) stop("Cannot rename columns. Column names must be unique.")
          if(self$column_selection_applied()) self$remove_current_column_selection()
          names(private$data)[cols_changed_index] <- new_col_names
          for (i in seq_along(cols_changed_index)) {
            self$append_to_variables_metadata(new_col_names[i], name_label, new_col_names[i])
          }
        }
        if (!missing(new_labels_df)) {
          new_labels <- new_labels_df[, 1]
          new_labels_index <- new_labels_df[, 2]
          for (i in seq_along(new_labels)) {
            if (isTRUE(new_labels[i] != "")) {
              self$append_to_variables_metadata(col_name = names(private$data)[new_labels_index[i]], property = "label", new_val = new_labels[i])
            }
          }
        }
        self$data_changed <- TRUE
        self$variables_metadata_changed <- TRUE
      } else if (type == "rename_with") {
        if (missing(.fn)) stop(.fn, "is missing with no default.")
        curr_col_names <- names(curr_data)
        private$data <- curr_data |>
          
          dplyr::rename_with(
            .fn = .fn,
            .cols = {{ .cols }}, ...
          )
        if(self$column_selection_applied()) self$remove_current_column_selection()
        new_col_names <- names(private$data)
        if (!all(new_col_names %in% curr_col_names)) {
          new_col_names <- new_col_names[!(new_col_names %in% curr_col_names)]
          for (i in seq_along(new_col_names)) {
            self$append_to_variables_metadata(new_col_names[i], name_label, new_col_names[i])
          }
          self$data_changed <- TRUE
          self$variables_metadata_changed <- TRUE
        }
      }
    },
    
    #' @description
    #' Remove specified columns from the data.
    #'
    #' @param cols Character vector, the names of the columns to remove.
    #' @param allow_delete_all Logical, if TRUE, allows deleting all columns.
    remove_columns_in_data = function(cols=c(), allow_delete_all = FALSE) {
      if(length(cols) == self$get_column_count()) {
        if(allow_delete_all) {
          warning("You are deleting all columns in the data frame.")
        } else {
          stop("Cannot delete all columns through this function. Use delete_dataframe to delete the data.")
        }
      }
      for(col_name in cols) {
        # Column name must be character
        if(!is.character(col_name)) {
          stop("Column name must be of type: character")
        } else if (!(col_name %in% self$get_column_names())) {
          stop(paste0("Column :'", col_name, " was not found in the data."))
        } else {
          get_key <- self$get_variables_metadata() %>% dplyr::filter(Name == col_name)
          if (!is.null(get_key$Is_Key)){
            if (!is.na(get_key$Is_Key) && get_key$Is_Key){
              active_keys <- self$get_keys()
              keys_to_delete <- which(grepl(col_name, active_keys))
              keys_to_delete <- purrr::map_chr(.x = keys_to_delete, .f = ~names(active_keys[.x]))
              purrr::map(.x = keys_to_delete, .f = ~self$remove_key(key_name = names(active_keys[.x])))
            }
          }
          private$data[[col_name]] <- NULL
        }
        self$append_to_changes(list(Removed_col, cols))
        self$data_changed <- TRUE
        self$variables_metadata_changed <- TRUE
      }
    },
    
    #' @description
    #' Replace values in the specified columns and rows.
    #'
    #' @param col_names Character vector, the names of the columns.
    #' @param rows Character vector, the names of the rows.
    #' @param old_value The old value to be replaced.
    #' @param old_is_missing Logical, if TRUE, treats old_value as missing.
    #' @param start_value Numeric, the starting value for the range to replace.
    #' @param end_value Numeric, the ending value for the range to replace.
    #' @param new_value The new value to replace with.
    #' @param new_is_missing Logical, if TRUE, treats new_value as missing.
    #' @param closed_start_value Logical, if TRUE, includes the start value in the range.
    #' @param closed_end_value Logical, if TRUE, includes the end value in the range.
    #' @param locf Logical, if TRUE, uses the last observation carried forward method.
    #' @param from_last Logical, if TRUE, uses the last observation from the end.
    replace_value_in_data = function(col_names, rows, old_value, old_is_missing = FALSE, start_value = NA, end_value = NA, new_value, new_is_missing = FALSE, closed_start_value = TRUE, closed_end_value = TRUE, locf = FALSE, from_last = FALSE) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      # Column name must be character
      if(!all(is.character(col_names))) stop("Column name must be of type: character")
      if (!all(col_names %in% names(curr_data))) stop("Cannot find all columns in the data.")
      if(!missing(rows) && !all(rows %in% row.names(curr_data))) stop("Not all rows found in the data.")
      if(!is.na(start_value) && !is.numeric(start_value)) stop("start_value must be numeric")
      if(!is.na(end_value) && !is.numeric(end_value)) stop("start_value must be numeric")
      if(old_is_missing) {
        if(!missing(old_value)) stop("Specify only one of old_value and old_is_missing")
        old_value <- NA
      }
      if(new_is_missing) {
        if(!missing(new_value)) stop("Specify only one of new_value and new_is_missing")
        new_value <- NA
      }
      data_row_names <- row.names(curr_data)
      filter_applied <- self$filter_applied()
      if(filter_applied) curr_filter <- self$current_filter
      for(col_name in col_names) {
        done = FALSE
        str_data_type <- self$get_variables_metadata(property = data_type_label, column = col_name)
        curr_column <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
        if(locf){
          my_data <- zoo::na.locf(curr_column, fromLast = from_last, na.rm = FALSE)
        }
        else{
          if("factor" %in% str_data_type) {
            if(!missing(rows)) {
              if(!is.na(new_value) && !new_value %in% levels(self$get_columns_from_data(col_name, use_current_filter = FALSE))) {
                stop("new_value must be an existing level of the factor column.")
              }
              replace_rows <- (data_row_names %in% rows)
            }
            else {
              if(filter_applied) stop("Cannot replace values in a factor column when a filter is applied. Remove the filter to do this replacement.")
              if(is.na(old_value)) {
                if(!is.na(new_value) && !new_value %in% levels(self$get_columns_from_data(col_name, use_current_filter = FALSE))) stop(new_value, " is not a level of this factor. Add this as a level of the factor before using replace.")
                replace_rows <- (is.na(curr_column))
              }
              else {
                self$edit_factor_level(col_name = col_name, old_level = old_value, new_level = new_value)
                done = TRUE
              }
            }
          }
          else if(str_data_type == "integer" || str_data_type == "numeric") {
            if(!is.na(new_value)) {
              if(!is.numeric(new_value)) stop(col_name, " is a numeric/integer column. new_value must be of the same type")
              if(str_data_type == "integer" && !(new_value %% 1 == 0)) stop(col_name, " is an integer column. new_value must be an integer")
            }
            if(!missing(rows)) {
              replace_rows <- (data_row_names %in% rows)
              if(!missing(old_value) || !is.na(start_value) || !is.na(end_value)) warning("old_value, start_value and end_value will be ignored because rows has been specified.")
            }
            else {
              if(!is.na(start_value) || !is.na(end_value)) {
                if(!missing(old_value)) warning("old_value will be ignored because start_value or end_value has been specified.")
                if(closed_start_value) start_value_ineq = match.fun(">=")
                else start_value_ineq = match.fun(">")
                if(closed_end_value) end_value_ineq = match.fun("<=")
                else end_value_ineq = match.fun("<")
                
                if(!is.na(start_value) && is.na(end_value)) {
                  replace_rows <- start_value_ineq(curr_column, start_value)
                }
                else if(is.na(start_value) && !is.na(end_value)) {
                  replace_rows <- end_value_ineq(curr_column, end_value)
                }
                else if(!is.na(start_value) && !is.na(end_value)) {
                  replace_rows <- (start_value_ineq(curr_column,start_value) & end_value_ineq(curr_column, end_value))
                }
              }
              else {
                if(is.na(old_value)) replace_rows <- (is.na(curr_column))
                else replace_rows <- (curr_column == old_value)
              }
            }
          }
          else if(str_data_type == "character") {
            if(!missing(rows)) {
              replace_rows <- (data_row_names %in% rows)
              if(!missing(old_value)) warning("old_value will be ignored because rows has been specified.")
            }
            else {
              if(is.na(old_value)) replace_rows <- (is.na(curr_column))
              else replace_rows <- (curr_column == old_value)
            }
            new_value <- as.character(new_value)
          }
          else if(str_data_type == "logical") {
            #Removed because new columns are logical and we need to be able to type in new values
            #if(!is.logical(new_value)) stop(col_name, " is a logical column. new_value must be a logical value")
            if(!missing(rows)) {
              replace_rows <- (data_row_names %in% rows)
              if(!missing(old_value)) warning("old_value will be ignored because rows has been specified.")
            }
            else {
              if(is.na(old_value)) replace_rows <- (is.na(curr_column))
              else replace_rows <- (curr_column == old_value)
            }
          }
          #TODO add other data type cases
          else {
            if(!missing(rows)) {
              replace_rows <- (data_row_names %in% rows)
              if(!missing(old_value)) warning("old_value will be ignored because rows has been specified.")
            }
            else {
              if(is.na(old_value)) replace_rows <- (is.na(curr_column))
              else replace_rows <- (curr_column == old_value)
            }
          }
          
        }
        if(!done) {
          if(locf){
            private$data[[col_name]] <- my_data
          }
          else{
            replace_rows[is.na(replace_rows)] <- FALSE
            if(sum(replace_rows) > 0) {
              if(filter_applied) {
                replace_rows <- replace_rows & curr_filter
              }
              # Need private$data here as replacing values in data
              
              if(sum(replace_rows) > 0) private$data[[col_name]][replace_rows] <- new_value
              else message("No values to replace in ", col_name)
            }
            else message("No values to replace in ", col_name)
          }
          
        }
      }
      #TODO need to think what to add to changes
      self$append_to_changes(list(Replaced_value, col_names))
      self$data_changed <- TRUE
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Paste data from the clipboard into the specified columns and rows.
    #'
    #' @param col_names Character vector, the names of the columns.
    #' @param start_row_pos Numeric, the starting row position.
    #' @param first_clip_row_is_header Logical, if TRUE, treats the first row of the clipboard data as a header.
    #' @param clip_board_text Character, the clipboard text data.
    paste_from_clipboard = function(col_names, start_row_pos = 1, first_clip_row_is_header = FALSE, clip_board_text) {
      #get the clipboard text contents as a data frame
      clip_tbl <- clipr::read_clip_tbl(x = clip_board_text, header = first_clip_row_is_header)
      
      #get the selected data frame
      current_tbl <- self$get_data_frame(use_current_filter = FALSE)
      
      #check if copied data rows are more than current data rows
      if( nrow(clip_tbl) > nrow(current_tbl) ){
        stop(paste("rows copied cannot be more than number of rows in the data frame.",
                   "Current data frame rows:", nrow(current_tbl), ". Copied rows:", nrow(clip_tbl)) )
      }
      
      
      #if column names are missing then just add the clip data as new columns and quit function
      if( missing(col_names) ){
        #append missing values if rows are less than the selected data frame. 
        #new column rows should be equal to existing column rows
        if( nrow(clip_tbl) < nrow(current_tbl) ){
          empty_values_df <- data.frame(data = matrix(data = NA, nrow = ( nrow(current_tbl) - nrow(clip_tbl) ), ncol = ncol(clip_tbl) ))
          names(empty_values_df) <- names(clip_tbl)
          clip_tbl <- rbind(clip_tbl, empty_values_df)
        }
        new_col_names <- colnames(clip_tbl)
        for(index in seq_along(new_col_names)){
          self$add_columns_to_data(col_name = new_col_names[index], col_data = clip_tbl[, index])
        }
        return()
      }
      
      #for existing column names
      #check if number of copied columns and selected columns are equal
      if(ncol(clip_tbl) != length(col_names)){
        stop(paste("number of columns are not the same.",
                   "Selected columns:", length(col_names), ". Copied columns:", ncol(clip_tbl)) )
      }
      
      
      #check copied data integrity
      for(index in seq_along(col_names)){
        col_data <- current_tbl[, col_names[index]]
        #get column type of column from the current table using column name
        col_type <- class(col_data)
        #check copied data integrity based on the data type expected
        if (is.factor(col_data)) {
          #get all the factor levels of the selected column in the current data frame
          expected_factor_levels <- levels(col_data)
          #check if all copied data values are contained in the factor levels
          #if any invalid is found. exit function
          for(val in clip_tbl[,index]){
            if(!is.na(val) && !is.element(val,expected_factor_levels)){
              stop("Invalid column values. Level not found in factor")
            }
          }#end inner for loop
        } else if( !(is.numeric(col_data) || is.logical(col_data) || is.character(col_data)) ) {
          #clipr support above column types only. So pasting to a column not recognised by clipr may result to unpredictible results 
          #if not in any of above column types then exit function
          stop( paste("Cannot paste into columns of type:", col_type) )
        }#end if  
      }#end outer for loop
      
      #replace values in the selected columns
      for(index in seq_along(col_names)){
        #set the row positions and the values
        rows_to_replace <- c(start_row_pos : (start_row_pos + nrow(clip_tbl) - 1 ))
        new_values <- clip_tbl[,index]
        #replace the old values with new values
        self$replace_value_in_data(col_names = col_names[index], rows = rows_to_replace, new_value = new_values)
        #rename header if first row of clip data is header. 
        if(first_clip_row_is_header){
          self$rename_column_in_data(curr_col_name = col_names[index], new_col_name = colnames(clip_tbl)[index]) 
        }
      }#end for loop
    },
    
    #' @description
    #' Append a new value to the metadata of the data.
    #'
    #' @param property Character, the property to append to.
    #' @param new_value The new value to append.
    append_to_metadata = function(property, new_value = "") {
      if(missing(property)) stop("property must be specified.")
      
      if (!is.character(property)) stop("property must be of type: character")
      
      attr(private$data, property) <- new_value
      self$append_to_changes(list(Added_metadata, property, new_value))
      self$metadata_changed <- TRUE
      # Not sure this is correct way to ensure unhidden data frames appear.
      # Possibly better to modify the Grid Link
      if(property == is_hidden_label) self$data_changed <- TRUE
    },
    
    #' @description
    #' Append a new value to the variables metadata.
    #'
    #' @param col_names Character vector, the names of the columns.
    #' @param property Character, the property to append to.
    #' @param new_val The new value to append.
    append_to_variables_metadata = function(col_names, property, new_val = "") {
      if (missing(property)) stop("property must be specified.")
      if (!is.character(property)) stop("property must be a character")
      if (!missing(col_names)) {
        # if(!all(col_names %in% self$get_column_names())) stop("Not all of ", paste(col_names, collapse = ","), " found in data.")
        if (!all(col_names %in% names(private$data))) stop("Not all of ", paste(col_names, collapse = ","), " found in data.")
        for (curr_col in col_names) {
          #see comments in  PR #7247 to understand why ' property == labels_label && new_val == "" ' check was added
          #see comments in issue #7337 to understand why the !is.null(new_val) check was added. 
          if (((property == labels_label && new_val == "") || (property == colour_label && new_val == -1)) && !is.null(new_val)) {
            #reset the column labels or colour property 
            attr(private$data[[curr_col]], property) <- NULL
          } else {
            attr(private$data[[curr_col]], property) <- new_val
          }
          self$append_to_changes(list(Added_variables_metadata, curr_col, property))
        }
      } else {
        for (col_name in self$get_column_names()) {
          #see comments in  PR #7247 to understand why ' property == labels_label && new_val == "" ' check was added
          #see comments in issue #7337 to understand why the !is.null(new_val) check was added. 
          if (((property == labels_label && new_val == "") || (property == colour_label && new_val == -1)) && !is.null(new_val)) {
            #reset the column labels or colour property 
            attr(private$data[[col_name]], property) <- NULL
          } else {
            attr(private$data[[col_name]], property) <- new_val
          }
        }
        self$append_to_changes(list(Added_variables_metadata, property, new_val))
      }
      self$variables_metadata_changed <- TRUE
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Append a value to the changes list.
    #'
    #' @param value The value to append.
    append_to_changes = function(value) {
      #functionality disabled temporarily
      #see PR #8465 and issue #7161 comments
      
      #if(missing(value)) {
      #  stop("value arguements must be specified.")
      #}else {
      #see comments in issue #7161 that explain more about why list() was used
      #primary reason was because of performance when it comes to wide data sets
      #private$changes[[length(private$changes)+1]] <- value 
      #private$changes<-list(private$changes, value)
      #}
    },
    
    #' @description
    #' Check if a string is in the metadata.
    #'
    #' @param str Character, the string to check.
    #'
    #' @return Logical, TRUE if the string is in the metadata, FALSE otherwise.
    is_metadata = function(str) {
      return(str %in% names(attributes(private$data)))
    },
    
    #' @description
    #' Check if a string is in the variables metadata.
    #'
    #' @param str Character, the string to check.
    #' @param col Character, the column to check in.
    #' @param return_vector Logical, if TRUE, returns the result as a vector.
    #'
    #' @return Logical, TRUE if the string is in the variables metadata, FALSE otherwise.
    is_variables_metadata = function(str, col, return_vector = FALSE) {
      if(str == data_type_label) return(TRUE)
      if(missing(col)) {
        dat <- self$get_data_frame(use_current_filter = FALSE)
        return(any(sapply(dat, function(x) str %in% names(attributes(x))), na.rm = TRUE))
      }
      else {
        out <- sapply(col, function(x) str %in% names(attributes(self$get_columns_from_data(x, use_current_filter = FALSE))))
        if(return_vector) return(out)
        else return(all(out))
      }
    },
    
    #' @description
    #' Adds default values to the metadata.
    add_defaults_meta = function() {
      if(!self$is_metadata(is_calculated_label)) self$append_to_metadata(is_calculated_label, FALSE)
      if(!self$is_metadata(is_hidden_label)) self$append_to_metadata(is_hidden_label, FALSE)
      if(!self$is_metadata(label_label)) self$append_to_metadata(label_label, "")
    },
    
    #' @description
    #' Adds default values to the variables metadata for the specified columns.
    #'
    #' @param column_names Character vector, the names of the columns.
    add_defaults_variables_metadata = function(column_names) {
      for(column in column_names) {
        self$append_to_variables_metadata(column, name_label, column)
        if(!self$is_variables_metadata(is_hidden_label, column)) {
          self$append_to_variables_metadata(column, property = is_hidden_label, new_val = FALSE)
        }
        if(!self$is_variables_metadata(label_label, column)) {
          self$append_to_variables_metadata(column, label_label, "")
        }
        if(!self$is_variables_metadata(scientific_label, column)) {
          self$append_to_variables_metadata(column, scientific_label, FALSE)
        }
        if(!self$is_variables_metadata(signif_figures_label, column) || is.na(self$get_variables_metadata(property = signif_figures_label, column = column))) {
          self$append_to_variables_metadata(column, signif_figures_label, get_default_significant_figures(self$get_columns_from_data(column, use_current_filter = FALSE, use_column_selection = FALSE)))
        }
        if(self$is_variables_metadata(labels_label, column)) {
          curr_labels <- self$get_variables_metadata(property = labels_label, column = column, direct_from_attributes = TRUE)
          if(!is.numeric(curr_labels)) {
            numeric_labs <- as.numeric(curr_labels)
            if(any(is.na(numeric_labs))) {
              warning("labels attribute of non numeric values is not currently supported. labels will be removed from column: ", column, " to prevent compatibility issues. removed labels: ", curr_labels)
              self$append_to_variables_metadata(column, labels_label, NULL)
            }
            else {
              adjusted_labels <- numeric_labs
              names(adjusted_labels) <- names(curr_labels)
              self$append_to_variables_metadata(column, labels_label, adjusted_labels)
            }
          }
        }
      }
    },
    
    #' @description
    #' Removes the specified rows from the data.
    #'
    #' @param row_names Character vector, the names of the rows to remove.
    remove_rows_in_data = function(row_names) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      if(!all(row_names %in% rownames(curr_data))) stop("Some of the row_names not found in data")
      rows_to_remove <- which(rownames(curr_data) %in% row_names)
      #Prefer not to use dplyr::slice as it produces a tibble
      #tibbles remove row names e.g. for filtering
      #but cannot use standard curr_data[-rows_to_remove, ] 
      #since it removes column attributes
      
      self$set_data(dplyr::slice(curr_data, -rows_to_remove, .preserve = TRUE))
      self$append_to_changes(list(Removed_row, row_names))
      #Added this line to fix the bug of having the variable names in the metadata changinng to NA
      # This affects factor columns only  - we need to find out why and how to solve it best
      self$add_defaults_variables_metadata(self$get_column_names())
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Gets the next default column name based on the given prefix.
    #'
    #' @param prefix Character, the prefix for the new column name.
    #'
    #' @return Character, the next default column name.
    get_next_default_column_name = function(prefix) {
      return(next_default_item(prefix = prefix, existing_names = self$get_column_names(use_current_column_selection = FALSE)))
    },
    
    #' @description
    #' Reorders the columns in the data based on the given order.
    #'
    #' @param col_order Character vector, the new order of the columns.
    reorder_columns_in_data = function(col_order) {
      if (ncol(self$get_data_frame(use_current_filter = FALSE, use_column_selection = FALSE)) != length(col_order)) stop("Columns to order should be same as columns in the data.")
      
      if(is.numeric(col_order)) {
        if(!(identical(sort(col_order), sort(as.numeric(1:ncol(data)))))) {
          stop("Invalid column order")
        }
      }
      else if(is.character(col_order)) {
        if(!(dplyr::setequal(col_order,names(private$data)))) stop("Invalid column order")
      }
      else stop("column order must be a numeric or character vector")
      old_metadata <- attributes(private$data)
      self$set_data(private$data[ ,col_order])
      for(name in names(old_metadata)) {
        if(!name %in% c("names", "class", "row.names")) {
          self$append_to_metadata(name, old_metadata[[name]])
        }
      }
      self$append_to_changes(list(Col_order, col_order))
    },
    
    #' @description
    #' Inserts new rows into the data at the specified position.
    #'
    #' @param start_row Character, the starting row for the new rows.
    #' @param row_data Data frame, the data for the new rows.
    #' @param number_rows Numeric, the number of new rows to insert.
    #' @param before Logical, if TRUE, inserts the new rows before the specified row.
    insert_row_in_data = function(start_row, row_data = c(), number_rows = 1, before = FALSE) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      curr_row_names <- rownames(curr_data)
      if (!start_row %in% curr_row_names) {
        stop(paste(start_row, " not found in rows"))
      }
      row_position = which(curr_row_names == start_row)
      row_data <- curr_data[0, ]
      for(i in 1:number_rows) {
        row_data[i, ] <- NA
      }
      #row_data <- data.frame(matrix(NA, nrow = number_rows, ncol = ncol(curr_data)))
      #colnames(row_data) <- colnames(curr_data)
      if(length(curr_row_names[!is.na(as.numeric(curr_row_names))]) > 0) {
        rownames(row_data) <- max(as.numeric(curr_row_names), na.rm = TRUE) + 1:number_rows
      }
      else rownames(row_data) <- nrow(curr_data) + 1:(number_rows - 1)
      old_attr <- attributes(private$data)
      # Need to use rbind.fill (not bind_rows) because it preserves column attributes
      if(before && row_position == 1) {
        # This transfers attributes to new data so that they are kept after rbind.fill
        # Only needed when row_data is first argument to rbind.fill
        for(i in seq_along(row_data)) {
          attributes(row_data[[i]]) <- attributes(curr_data[[i]])
        }
        self$set_data(rbind.fill(row_data, curr_data))
      }
      else if(!before && row_position == nrow(curr_data)) {
        self$set_data(rbind.fill(curr_data, row_data))
      }
      else {
        if(before) {
          self$set_data(plyr::rbind.fill(dplyr::slice(curr_data,(1:(row_position - 1))), row_data, dplyr::slice(curr_data,row_position:nrow(curr_data))))
        }
        else {
          self$set_data(plyr::rbind.fill(dplyr::slice(curr_data, (1:row_position)), row_data, dplyr::slice(curr_data,(row_position + 1):nrow(curr_data))))
        }
      }
      for(attr_name in names(old_attr)) {
        if(!attr_name %in% c("names", "class", "row.names")) {
          self$append_to_metadata(attr_name, old_attr[[attr_name]])
        }
      }
      self$append_to_changes(list(Inserted_row, number_rows))
      #Added this line to fix the bug of having the variable names in the metadata changinng to NA
      # This affects factor columns only  - we need to find out why and how to solve it best
      self$add_defaults_variables_metadata(self$get_column_names())
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Gets the length of the data frame.
    #'
    #' @param use_current_filter Logical, if TRUE, uses the current filter.
    #'
    #' @return Numeric, the length of the data frame.
    get_data_frame_length = function(use_current_filter = FALSE) {
      return(nrow(self$get_data_frame(use_current_filter = use_current_filter)))
    },
    
    #' @description
    #' Gets the data frame for a factor column with optional inclusion of levels and NA level.
    #'
    #' @param col_name Character, the name of the factor column.
    #' @param include_levels Logical, if TRUE, includes the levels of the factor.
    #' @param include_NA_level Logical, if TRUE, includes the NA level.
    #'
    #' @return Data frame, the data frame for the factor column.
    get_factor_data_frame = function(col_name = "", include_levels = TRUE, include_NA_level = FALSE) {
      if(!(col_name %in% self$get_column_names())) stop(col_name, " is not a column name,")
      col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!(is.factor(col_data))) stop(col_name, " is not a factor column")
      
      counts <- data.frame(table(col_data))
      counts <- plyr::rename(counts, replace = c("col_data" = "Label"))
      counts[["Label"]] <- as.character(counts[["Label"]])
      counts[["Ord."]] <- 1:nrow(counts)
      if(include_levels) {
        if(self$is_variables_metadata(str = labels_label, col = col_name)) {
          curr_levels <- self$get_variables_metadata(property = labels_label, column = col_name, direct_from_attributes = TRUE)
          curr_levels <- data.frame(Label = names(curr_levels), Level = as.vector(curr_levels), stringsAsFactors = FALSE)
          counts <- dplyr::left_join(counts, curr_levels, by = "Label")
        }
        else {
          curr_levels <- counts[["Ord."]]
          counts[["Level"]] <- curr_levels
        }
        counts <- counts[c("Ord.", "Label", "Level", "Freq")]
      }
      else counts <- counts[c("Ord.", "Label", "Freq")]
      if(include_NA_level) {
        missing_count <- sum(is.na(col_data))
        if(include_levels) counts[nrow(counts) + 1, ] <- c("-", "NA", "-", missing_count)
        else counts[nrow(counts) + 1, ] <- c("-", "(NA)", missing_count)
      }
      return(counts)
    },
    
    #' @description
    #' Gets the factor levels for the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #'
    #' @return Character vector, the factor levels for the column.
    get_column_factor_levels = function(col_name = "") {
      if(!(col_name %in% self$get_column_names())) {
        stop(col_name, " is not a column in", get_metadata(data_name_label))
      }
      
      if(!(is.factor(self$get_columns_from_data(col_name, use_current_filter = FALSE)))){
        stop(col_name, " is not a factor column")
      }
      
      return(levels(self$get_columns_from_data(col_name, use_current_filter = FALSE)))
    },
    
    #' @description
    #' Sorts the data frame based on the specified columns.
    #'
    #' @param col_names Character vector, the names of the columns to sort by.
    #' @param decreasing Logical, if TRUE, sorts in decreasing order.
    #' @param na.last Logical, if TRUE, places NA values last.
    #' @param by_row_names Logical, if TRUE, sorts by row names.
    #' @param row_names_as_numeric Logical, if TRUE, treats row names as numeric values.
    sort_dataframe = function(col_names = c(), decreasing = FALSE, na.last = TRUE, by_row_names = FALSE, row_names_as_numeric = TRUE) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      string <- list()
      if(missing(col_names) || length(col_names) == 0) {
        if(by_row_names) {
          if(row_names_as_numeric) row_names_sort <- as.numeric(row.names(curr_data))
          else row_names_sort <- row.names(curr_data)
          if(decreasing) self$set_data(arrange(curr_data, desc(row_names_sort)))
          else self$set_data(arrange(curr_data, row_names_sort))
        }
        else message("No sorting to be done.")
      }
      else {
        col_names_exp = c()
        i = 1
        for(col_name in col_names){
          if(!(col_name %in% names(curr_data))) {
            stop(col_name, " is not a column in ", get_metadata(data_name_label))
          }
          if(decreasing) col_names_exp[[i]] <- lazyeval::interp(~ desc(var), var = as.name(col_name))
          else col_names_exp[[i]] <- lazyeval::interp(~ var, var = as.name(col_name))
          i = i + 1
        }
        if(by_row_names) warning("Cannot sort by columns and row names. Sorting will be done by given columns only.")
        self$set_data(dplyr::arrange_(curr_data, .dots = col_names_exp))
      }
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Converts the specified columns to the given type.
    #'
    #' @param col_names Character vector, the names of the columns.
    #' @param to_type Character, the type to convert to.
    #' @param factor_values Character, the factor values to use for conversion.
    #' @param set_digits Numeric, the number of digits to use for conversion.
    #' @param set_decimals Logical, if TRUE, sets the number of decimals.
    #' @param keep_attr Logical, if TRUE, keeps the attributes of the columns.
    #' @param ignore_labels Logical, if TRUE, ignores labels during conversion.
    #' @param keep.labels Logical, if TRUE, keeps labels during conversion.
    convert_column_to_type = function(col_names = c(), to_type, factor_values = NULL, set_digits, set_decimals = FALSE, keep_attr = TRUE, ignore_labels = FALSE, keep.labels = TRUE) {
      if(!all(col_names %in% self$get_column_names())) stop("Some column names not found in the data")
      
      if(length(to_type) !=1 ) {
        stop("to_type must be a character of length one")
      }
      
      if(!(to_type %in% c("integer", "factor", "numeric", "character", "ordered_factor", "logical"))) {
        stop(to_type, " is not a valid type to convert to")
      }
      
      if(!is.null(factor_values) && !(factor_values %in% c("force_ordinals", "force_values"))) {
        stop(factor_values, " must be either 'force_ordinals' or 'force_values'")
      }
      
      for(col_name in col_names) {
        curr_col <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
        if(keep_attr) {
          tmp_attr <- get_column_attributes(curr_col)
        }
        if(!is.null(factor_values) && is.factor(curr_col) && to_type %in% c("integer", "numeric")) {
          if(factor_values == "force_ordinals") new_col <- as.numeric(curr_col)
          else if(factor_values == "force_values") new_col <- as.numeric(levels(curr_col))[curr_col]
        }
        else if(to_type %in% c("factor", "ordered_factor")) {
          ordered <- (to_type == "ordered_factor")
          # TODO This looks like it may not work if curr_col is not numeric.
          # If this is not currently used anywhere possibly remove or modify.
          if(set_decimals) curr_col <- round(curr_col, digits = set_digits)
          if(ignore_labels) {
            new_col <- make_factor(curr_col, ordered = ordered)
          }
          else {
            if(self$is_variables_metadata(labels_label, col_name)) {
              new_col <- sjlabelled::as_label(curr_col, add.non.labelled = TRUE)
              # Adds "ordered" to the class in the same way as factor().
              # factor(ordered = TURE) is not used as this drops all attributes of x.
              if(ordered) class(new_col) <- c("ordered", class(new_col))
              else class(new_col) <- class(new_col)[class(new_col) != "ordered"]
            }
            else {
              new_col <- make_factor(curr_col, ordered = ordered)
              if(is.numeric(curr_col) && !self$is_variables_metadata(labels_label, col_name)) {
                labs <- sort(unique(curr_col))
                names(labs) <- labs
                # temporary fix to issue of add_columns not retaining attributes of new columns
                tmp_attr[[labels_label]] <- labs
              }
            }
          }
        }
        else if(to_type == "integer") {
          new_col <- as.integer(curr_col)
        }
        else if(to_type == "numeric") {
          if(ignore_labels) {
            if (is.factor(curr_col)) new_col <- as.numeric(levels(curr_col))[curr_col]
            else new_col <- as.numeric(curr_col)
          }
          else {
            if(self$is_variables_metadata(labels_label, col_name) && !is.numeric(curr_col)) {
              #TODO WARNING: need to test this on columns of different types to check for strange behaviour
              curr_labels <- self$get_variables_metadata(property = labels_label, column = col_name, direct_from_attributes = TRUE)
              if(!all(curr_col %in% names(curr_labels))) {
                additional_names <- sort(unique(na.omit(curr_col[!curr_col %in% names(curr_labels)])))
                additonal <- seq(max(curr_labels, na.rm = TRUE) + 1, length.out = length(additional_names))
                names(additonal) <- additional_names
                curr_labels <- c(curr_labels, additonal)
                # temporary fix to issue of add_columns not retaining attributes of new columns
                tmp_attr[[labels_label]] <- curr_labels
              }
              new_col <- as.numeric(curr_labels[as.character(curr_col)])
            }
            # This ensures that integer columns get type changed to numeric (not done by sjlabelled::as_numeric)
            else if(is.integer(curr_col)) new_col <- as.numeric(curr_col)
            else new_col <- sjlabelled::as_numeric(curr_col, keep.labels = keep.labels)
          }
        }
        else if(to_type == "character") {
          new_col <- sjmisc::to_character(curr_col) 
        }
        else if(to_type == "logical") {
          if(is.logical.like(curr_col)) new_col <- as.logical(curr_col)
          else stop("Column is not numeric or contains values other than 0 and 1. Converting to logical would result in losing information.")
        }
        
        self$add_columns_to_data(col_name = col_name, col_data = new_col)
        
        if(keep_attr) {
          if(to_type %in% c("numeric", "integer") && signif_figures_label %in% names(tmp_attr) && is.na(tmp_attr[[signif_figures_label]])) {
            tmp_attr[[signif_figures_label]] <- NULL
          }
          self$append_column_attributes(col_name = col_name, new_attr = tmp_attr)
        }
      }
      self$data_changed <- TRUE
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Copies the specified columns in the data.
    #'
    #' @param col_names Character vector, the names of the columns to copy.
    copy_columns = function(col_names = "") {
      for(col_name in col_names){
        if(!(col_name %in% self$get_column_names())) {
          stop(col_name, " is not a column in ", get_metadata(data_name_label))
        }
      }
      dat1 <- self$get_columns_from_data(col_names, use_current_filter = FALSE)
      
      for(name in col_names){
        names(dat1)[names(dat1) == name] <- self$get_next_default_column_name(prefix = paste(name, "copy", sep = "_" ) )
      }
      
      self$add_columns_to_data(col_name = names(dat1), col_data = dat1)
      self$append_to_changes(list(Copy_cols, col_names))
    },
    
    #' @description
    #' Drops unused factor levels in the specified column.
    #'
    #' @param col_name Character, the name of the column.
    drop_unused_factor_levels = function(col_name) {
      if(!col_name %in% self$get_column_names()) stop(paste(col_name,"not found in data."))
      col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!is.factor(col_data)) stop(col_name, " is not a factor.")
      level_counts <- table(col_data)
      if(any(level_counts == 0)) {
        if(self$is_variables_metadata(labels_label, col_name)) {
          curr_labels <- self$get_variables_metadata(property = labels_label, column = col_name, direct_from_attributes = TRUE)
          curr_labels <- curr_labels[names(level_counts[level_counts > 0])]
          self$append_to_variables_metadata(property = labels_label, col_names = col_name, new_val = curr_labels)
          col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
        }
        tmp_attr <- get_column_attributes(col_data)
        self$add_columns_to_data(col_name, droplevels(col_data))
        self$append_column_attributes(col_name = col_name, new_attr = tmp_attr)
      }
    },
    
    #' @description
    #' Sets the factor levels for the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #' @param new_labels Character vector, the new labels for the factor levels.
    #' @param new_levels Character vector, the new levels for the factor.
    #' @param set_new_labels Logical, if TRUE, sets the new labels.
    set_factor_levels = function(col_name, new_labels, new_levels, set_new_labels = TRUE) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in data.")
      col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!is.factor(col_data)) stop(col_name, " is not a factor.")
      old_labels <- levels(col_data)
      if(length(new_labels) < length(old_labels)) stop("There must be at least as many new levels as current levels.")
      if(!missing(new_levels) && anyDuplicated(new_levels)) stop("new levels must be unique")
      # Must be private$data because setting an attribute
      levels(private$data[[col_name]]) <- new_labels
      
      if(!missing(new_levels)) {
        labels_list <- new_levels
        names(labels_list) <- new_labels
        self$append_to_variables_metadata(col_name, labels_label, labels_list)
      }
      else if(set_new_labels && self$is_variables_metadata(labels_label, col_name)) {
        labels_list <- self$get_variables_metadata(property = labels_label, column = col_name, direct_from_attributes = TRUE)
        names(labels_list) <- as.character(new_labels[1:length(old_labels)])
        if(length(new_labels) > length(old_lables)) {
          extra_labels <- seq(from = max(labels_list) + 1, length.out = (length(new_labels) - length(old_labels)))
          names(extra_labels) <- new_labels[!new_labels %in% names(labels_list)]
          labels_list <- c(labels_list, extra_labels)
        }
        self$append_to_variables_metadata(col_name, labels_label, labels_list)
      }
      self$data_changed <- TRUE
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Edits the factor level in the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #' @param old_level Character, the old factor level.
    #' @param new_level Character, the new factor level.
    edit_factor_level = function(col_name, old_level, new_level) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in data.")
      if(!is.factor(self$get_columns_from_data(col_name, use_current_filter = FALSE))) stop(col_name, " is not a factor.")
      self$add_columns_to_data(col_name, plyr::mapvalues(x = self$get_columns_from_data(col_name, use_current_filter = FALSE), from = old_level, to = new_level))
      self$data_changed <- TRUE
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Sets the reference level for a factor column.
    #'
    #' @param col_name Character, the name of the column.
    #' @param new_ref_level Character, the new reference level.
    set_factor_reference_level = function(col_name, new_ref_level) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in data.")
      col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!is.factor(col_data)) stop(col_name, " is not a factor.")
      if(!new_ref_level %in% levels(col_data)) stop(new_ref_level, " is not a level of ", col_name)
      tmp_attr <- get_column_attributes(col_data)
      self$add_columns_to_data(col_name, relevel(col_data, new_ref_level))
      self$append_column_attributes(col_name = col_name, new_attr = tmp_attr)
    },
    
    #' @description
    #' Reorders the factor levels in the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #' @param new_level_names Character vector, the new order of the factor levels.
    reorder_factor_levels = function(col_name, new_level_names) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in data.")
      curr_column <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!is.factor(curr_column)) stop(col_name, " is not a factor.")
      curr_levels <- levels(curr_column)
      if(length(new_level_names) != length(curr_levels)) stop("Incorrect number of new levels given.")
      if(!all(new_level_names %in% curr_levels)) stop("new_level_names must be a reordering of the current levels:", paste(levels(curr_column), collapse = ", "))
      new_column <- factor(curr_column, levels = new_level_names, ordered = is.ordered(curr_column))
      #TODO are these the only attributes we don't want to manually set?
      curr_attr <- attributes(curr_column)[!names(attributes(curr_column)) %in% c("levels", "class")]
      for(i in seq_along(curr_attr)) {
        attr(new_column, names(curr_attr)[i]) <- curr_attr[[i]]
      }
      self$add_columns_to_data(col_name = col_name, col_data = new_column)
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Gets the number of columns in the data.
    #'
    #' @param use_column_selection Logical, if TRUE, uses the current column selection.
    #'
    #' @return Numeric, the number of columns in the data.
    get_column_count = function(use_column_selection = FALSE) {
      return(ncol(self$get_data_frame(use_column_selection = use_column_selection)))
    },
    
    #' @description
    #' Gets the names of the columns in the data.
    #'
    #' @param as_list Logical, if TRUE, returns the names as a list.
    #' @param include List, the properties to include.
    #' @param exclude List, the properties to exclude.
    #' @param excluded_items Character vector, the items to exclude.
    #' @param max_no Numeric, the maximum number of columns to return.
    #' @param use_current_column_selection Logical, if TRUE, uses the current column selection.
    #'
    #' @return Character vector or list, the names of the columns in the data.
    get_column_names = function(as_list = FALSE, include = list(), exclude = list(), excluded_items = c(), max_no, use_current_column_selection = TRUE) {
      if(length(include) == 0 && length(exclude) == 0 && (!use_current_column_selection || !self$column_selection_applied())) out <- names(private$data)
      else {
        if(data_type_label %in% names(include) && "numeric" %in% include[[data_type_label]]) {
          include[[data_type_label]] = c(include[[data_type_label]], "integer")
        }
        if(data_type_label %in% names(exclude) && "numeric" %in% exclude[[data_type_label]]) {
          exclude[[data_type_label]] = c(exclude[[data_type_label]], "integer")
        }
        
        if (use_current_column_selection) col_names <- self$current_column_selection
        else col_names <- names(private$data)
        out <- c()
        i <- 1
        for(col in col_names) {
          if(length(include) > 0 || length(exclude) > 0) {
            curr_var_metadata <- self$get_variables_metadata(column = col, direct_from_attributes = TRUE)
            if(!data_type_label %in% names(curr_var_metadata)) curr_var_metadata[[data_type_label]] <- class(private$data[[col]])
            #TODO this is a temp compatibility solution for how the class of ordered factor used to be shown when getting metadata
            if(length(curr_var_metadata[[data_type_label]]) == 2 && all(curr_var_metadata[[data_type_label]] %in% c("ordered", "factor"))) curr_var_metadata[[data_type_label]] <- "ordered,factor"
            if(all(c(names(include), names(exclude)) %in% names(curr_var_metadata)) && all(sapply(names(include), function(prop) any(curr_var_metadata[[prop]] %in% include[[prop]])))
               && all(sapply(names(exclude), function(prop) !any(curr_var_metadata[[prop]] %in% exclude[[prop]])))) {
              out <- c(out, col)
            }
          }
          else out <- c(out, col)
          i = i + 1
        }
        if(!missing(max_no) && max_no < length(out)) out <- out[1:max_no]
      }
      if(length(excluded_items) > 0) {
        ex_ind = which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the data")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(as_list) {
        lst = list()
        lst[[self$get_metadata(data_name_label)]] <- out
        return(lst)
      }
      else return(out)
    },
    
    #' @description
    #' Gets the data type of the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #'
    #' @return Character, the data type of the column.
    get_data_type = function(col_name = "") {
      if(!(col_name %in% self$get_column_names())) {
        stop(paste(col_name, "is not a column in", self$get_metadata(data_name_label)))
      }
      type <- ""
      curr_col <- self$get_columns_from_data(col_name, use_current_filter = TRUE)
      if(is.character(curr_col)) {
        type = "character"
      }
      else if(is.logical(curr_col)) {
        type = "logical"
      }
      # Question: Why is the using private$data[[col_name]] instead of curr_col?
      else if(lubridate::is.Date(private$data[[col_name]])){
        # #TODO
        #we can add options for other forms of dates serch as POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
        type = "Date"
      }
      else if(is.numeric(curr_col)) {
        #TODO vectors with integer values but stored as numeric will return numeric.
        #     Is that desirable?
        if(is.binary(curr_col)) {
          type = "two level numeric"
        }
        else if(all(curr_col == as.integer(curr_col), na.rm = TRUE)) {
          if(all(curr_col > 0, na.rm = TRUE)) {
            type = "positive integer"
          }
          else type = "integer"
        }
        else type = "numeric"
      }
      else if(is.factor(curr_col)) {
        if(nlevels(curr_col) == 2 || nlevels(factor(curr_col)) == 2) type = "two level factor"
        else if(length(levels(curr_col)) > 2) type = "multilevel factor"
        else type = "factor"
      }
      return(type)
    },
    
    #' @description
    #' Set the hidden columns in the data.
    #'
    #' @param col_names Character vector, the names of the columns to hide.
    set_hidden_columns = function(col_names = c()) {
      if(length(col_names) == 0) self$unhide_all_columns()
      else {
        if(!all(col_names %in% self$get_column_names())) stop("Not all col_names found in data")
        
        self$append_to_variables_metadata(col_names, is_hidden_label, TRUE)
        hidden_cols = self$get_column_names()[!self$get_column_names() %in% col_names]
        self$append_to_variables_metadata(hidden_cols, is_hidden_label, FALSE)
      }
    },
    
    #' @description
    #' Unhide all columns in the data.
    unhide_all_columns = function() {
      self$append_to_variables_metadata(self$get_column_names(), is_hidden_label, FALSE)
    },
    
    #' @description
    #' Set the row names of the data frame.
    #'
    #' @param row_names Character vector, the new row names.
    set_row_names = function(row_names) {
      if(missing(row_names)) row_names = 1:nrow(self$get_data_frame(use_current_filter = FALSE))
      if(length(row_names) != nrow(self$get_data_frame(use_current_filter = FALSE))) stop("row_names must be a vector of same length as the data")
      if(anyDuplicated(row_names) != 0) stop("row_names must be unique")
      rownames(private$data) <- row_names
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Set the column names of the data frame.
    #'
    #' @param col_names Character vector, the new column names.
    set_col_names = function(col_names) {
      if(missing(col_names)) col_names = 1:ncol(self$get_data_frame(use_current_filter = FALSE))
      if(length(col_names) != ncol(self$get_data_frame(use_current_filter = FALSE))) stop("col_names must be a vector of same length as the data")
      if(anyDuplicated(col_names) != 0) stop("col_names must be unique")
      names(private$data) <- make.names(iconv(col_names, to = "ASCII//TRANSLIT", sub = "."))
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Get the row names of the data frame.
    #'
    #' @return Character vector, the row names of the data frame.
    get_row_names = function() {
      return(rownames(private$data))
    },
    
    #' @description
    #' Get the dimensions of the data frame.
    #'
    #' @return Numeric vector, the dimensions of the data frame.
    get_dim_dataframe = function() {
      return(dim(self$get_data_frame(use_current_filter = FALSE)))
    },
    
    #' @description
    #' Set the protected columns in the data.
    #'
    #' @param col_names Character vector, the names of the columns to protect.
    set_protected_columns = function(col_names) {
      if(!all(col_names %in% self$get_column_names())) stop("Not all col_names found in data")
      
      self$append_to_variables_metadata(col_names, is_protected_label, TRUE)
      other_cols = self$get_column_names()[!self$get_column_names() %in% col_names]
      self$append_to_variables_metadata(other_cols, is_protected_label, FALSE)
    },
    
    #' @description
    #' Add a filter to the data.
    #'
    #' @param filter List, the filter conditions.
    #' @param filter_name Character, the name of the filter.
    #' @param replace Logical, if TRUE, replaces an existing filter with the same name.
    #' @param set_as_current Logical, if TRUE, sets the filter as the current filter.
    #' @param na.rm Logical, if TRUE, removes NA values.
    #' @param is_no_filter Logical, if TRUE, specifies that no filter is applied.
    #' @param and_or Character, specifies the logical operator for combining conditions.
    #' @param inner_not Logical, if TRUE, applies negation to the inner condition.
    #' @param outer_not Logical, if TRUE, applies negation to the outer condition.
    add_filter = function(filter, filter_name = "", replace = TRUE, set_as_current = FALSE, na.rm = TRUE, is_no_filter = FALSE, and_or = "&", inner_not = FALSE, outer_not = FALSE) {
      if(missing(filter)) stop("filter is required")
      if(filter_name == "") filter_name = next_default_item("Filter", names(private$filters))
      
      for(condition in filter) {
        if(length(condition) < 2 || length(condition) > 3 || !all(names(condition) %in% c("column", "operation", "value"))) {
          stop("filter must be a list of conditions containing: column, operation and (sometimes) value")
        }
        if(!condition[["column"]] %in% self$get_column_names()) stop(condition[["column"]], " not found in data.")
      }
      if(filter_name %in% names(private$filters) && !replace) {
        warning("A filter named ", filter_name, " already exists. It will not be replaced.")
      }
      else {
        if(filter_name %in% names(private$filters)) message("A filter named ", filter_name, " already exists. It will be replaced by the new filter.")
        filter_calc = calculation$new(type = "filter", filter_conditions = filter, name = filter_name, parameters = list(na.rm = na.rm, is_no_filter = is_no_filter, and_or = and_or, inner_not = inner_not, outer_not = outer_not))
        private$filters[[filter_name]] <- filter_calc
        self$append_to_changes(list(Added_filter, filter_name))
        if(set_as_current) {
          self$current_filter <- filter_calc
          self$data_changed <- TRUE
        }
      }
    },
    
    #' @description
    #' Add filters based on levels of a column.
    #'
    #' @param filter_levels Character vector, the levels to create filters for.
    #' @param column Character, the name of the column.
    add_filter_as_levels = function(filter_levels, column) {
      for (i in seq_along(filter_levels)) {
        filter_cond <- list(C0 = list(column = column, operation = "==", value = filter_levels[i]))
        self$add_filter(filter = filter_cond, filter_name = filter_levels[i])
      }
    },
    
    #' @description
    #' Get the current filter.
    #'
    #' @return List, the current filter.
    get_current_filter = function() {
      return(private$.current_filter)
    },
    
    #' @description
    #' Set the current filter by name.
    #'
    #' @param filter_name Character, the name of the filter to set as current.
    set_current_filter = function(filter_name = "") {
      if(!filter_name %in% names(private$filters)) stop(filter_name, " not found.")
      self$current_filter <- private$filters[[filter_name]]
    },
    
    #' @description
    #' Get the names of all filters.
    #'
    #' @param as_list Logical, if TRUE, returns the names as a list.
    #' @param include List, the properties to include.
    #' @param exclude List, the properties to exclude.
    #' @param excluded_items Character vector, the items to exclude.
    #'
    #' @return Character vector or list, the names of the filters.
    get_filter_names = function(as_list = FALSE, include = list(), exclude = list(), excluded_items = c()) {
      out = names(private$filters)
      if(length(excluded_items) > 0) {
        ex_ind = which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of filters")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(as_list) {
        lst = list()
        lst[[self$get_metadata(data_name_label)]] <- out
        return(lst)
      }
      else return(out)
    },
    
    #' @description
    #' Get a specific filter by name.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return List, the specified filter.
    get_filter = function(filter_name) {
      if(missing(filter_name)) return(private$filters)
      if(!filter_name %in% names(private$filters)) stop(filter_name, " not found.")
      return(private$filters[[filter_name]])
    },
    
    #' @description
    #' Get the filter as a logical vector.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return Logical vector, the filter applied as a logical vector.
    get_filter_as_logical = function(filter_name) {
      curr_filter <- self$get_filter(filter_name)
      and_or <- curr_filter$parameters[["and_or"]]
      # This should no longer be needed as default will be set in check_filter()
      if (is.null(and_or)) and_or <- "&"
      outer_not <- curr_filter$parameters[["outer_not"]]
      i <- 1
      if (!isTRUE(outer_not)) {
        if (length(curr_filter$filter_conditions) == 0) {
          out <- rep(TRUE, nrow(self$get_data_frame(use_current_filter = FALSE)))
        } else {
          result <- matrix(nrow = nrow(self$get_data_frame(use_current_filter = FALSE)), ncol = length(curr_filter$filter_conditions))
          for (condition in curr_filter$filter_conditions) {
            # Prevents crash if column no longer exists
            # TODO still shows filter is applied
            if (!condition[["column"]] %in% self$get_column_names()) {
              return(TRUE)
            }
            if (condition[["operation"]] == "is.na" || condition[["operation"]] == "! is.na") {
              col_is_na <- is.na(self$get_columns_from_data(condition[["column"]], use_current_filter = FALSE))
              if (condition[["operation"]] == "is.na") {
                result[, i] <- col_is_na
              } else {
                result[, i] <- !col_is_na
              }
            } else if (condition[["operation"]] == "is.empty" || condition[["operation"]] == "! is.empty"){
              col_is_empty <- self$get_columns_from_data(condition[["column"]], use_current_filter = FALSE) == ""
              if (condition[["operation"]] == "is.empty") {
                result[, i] <- col_is_empty
              } else {
                result[, i] <- !col_is_empty
              }
            }
            else {
              func <- match.fun(condition[["operation"]])
              if (any(is.na(condition[["value"]])) && condition[["operation"]] != "%in%") {
                stop("Cannot create a filter on missing values with operation: ", condition[["operation"]])
              } else {
                logical_vec <- func(self$get_columns_from_data(condition[["column"]], use_current_filter = FALSE), condition[["value"]])
              }
              if (! isTRUE(curr_filter$parameters[["inner_not"]])) {
                result[, i] <- logical_vec
              } else {
                result[, i] <- !logical_vec
              }
            }
            i <- i + 1
          }
          if (and_or == "&") {
            out <- apply(result, 1, all)
          } else if (and_or == "|") {
            out <- apply(result, 1, any)
          } else {
            stop(and_or, " should be & or |.")
          }
          out[is.na(out)] <- !curr_filter$parameters[["na.rm"]]
        }
      } else {
        dat <- self$get_data_frame(use_current_filter = FALSE)
        str_out <- "("
        for (condition in curr_filter$filter_conditions) {
          str_out <- paste0(str_out, paste0("dat", "$", condition[["column"]], condition[["operation"]], ifelse(is.numeric(condition[["value"]]), condition[["value"]], paste0("'", condition[["value"]], "'"))))
          if (i != length(curr_filter$filter_conditions)) str_out <- paste0(str_out, curr_filter$parameters[["and_or"]])
          i <- i + 1
        }
        str_out <- paste0("!", str_out, ")")
        out <- eval(parse(text = str_out))
      }
      return(out)
    },
    
    #' @description
    #' Get the column names used in a specific filter.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return Character vector, the column names used in the filter.
    get_filter_column_names = function(filter_name) {
      curr_filter <- self$get_filter(filter_name)
      column_names <- c()
      for(i in seq_along(curr_filter$filter_conditions)) {
        column_names <- c(column_names, curr_filter$filter_conditions[[i]][["column"]])
      }
      return(column_names)
    },
    
    #' @description
    #' Get the column names used in the current filter.
    #'
    #' @return Character vector, the column names used in the current filter.
    get_current_filter_column_names = function() {
      return(self$get_filter_column_names(private$.current_filter$name))
    },
    
    #' @description
    #' Check if a filter is applied.
    #'
    #' @return Logical, TRUE if a filter is applied, FALSE otherwise.
    filter_applied = function() {
      return(!private$.current_filter$parameters[["is_no_filter"]])
    },
    
    #' @description
    #' Remove the current filter.
    remove_current_filter = function() {
      self$set_current_filter("no_filter")
    },
    
    #' @description
    #' Get the filter as a string.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return Character, the filter as a string.
    filter_string = function(filter_name) {
      if (!filter_name %in% names(private$filters)) stop(filter_name, " not found.")
      curr_filter <- self$get_filter(filter_name)
      out <- "("
      i <- 1
      for (condition in curr_filter$filter_conditions) {
        if (i != 1) out <- paste(out, curr_filter$parameters[["and_or"]])
        out <- ifelse(!curr_filter$parameters[["inner_not"]], paste0(out, " (", condition[["column"]], " ", condition[["operation"]]), paste0(out, " !(", condition[["column"]], " ", condition[["operation"]]))
        if (condition[["operation"]] == "%in%") {
          out <- paste0(out, " c(", paste(paste0("'", condition[["value"]], "'"), collapse = ","), ")")
        } else {
          out <- paste(out, condition[["value"]])
        }
        out <- paste0(out, ")")
        i <- i + 1
      }
      out <- paste(out, ")")
      if (isTRUE(curr_filter$parameters[["outer_not"]])) {
        out <- gsub("[!()]", "", out)
        out <- paste0("!(", out, ")")
      }
      return(out)
    },
    
    #' @description
    #' Get the filter as an instat calculation.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return Instat calculation, the filter as an instat calculation.
    get_filter_as_instat_calculation = function(filter_name) {
      if(!filter_name %in% names(private$filters)) stop(filter_name, " not found.")
      curr_filter <- self$get_filter(filter_name)
      filter_string <- self$filter_string(filter_name)
      calc_from <- list()
      for(condition in curr_filter$filter_conditions) {
        calc_from[[length(calc_from) + 1]] <- condition[["column"]]
      }
      names(calc_from) <- rep(self$get_metadata(data_name_label), length(calc_from))
      calc <- instat_calculation$new(type="filter", function_exp = filter_string, calculated_from = calc_from)
      return(calc)
    },
    
    #' @description
    #' Add a column selection to the data.
    #'
    #' @param column_selection List, the column selection conditions.
    #' @param name Character, the name of the column selection.
    #' @param replace Logical, if TRUE, replaces an existing column selection with the same name.
    #' @param set_as_current Logical, if TRUE, sets the column selection as the current selection.
    #' @param is_everything Logical, if TRUE, selects all columns.
    #' @param and_or Character, specifies the logical operator for combining conditions.
    add_column_selection = function(column_selection, name = "", replace = TRUE, set_as_current = FALSE, is_everything = FALSE, and_or = "|") {
      if(missing(column_selection)) stop("column_selection is required")
      if(name == "") name <- next_default_item("sel", names(private$column_selections))
      if(name %in% names(private$column_selections) && !replace) {
        warning("The column selection was not added. A column selection named ", name, " already exists. Specify replace = TRUE to overwrite it.")
        return()
      }
      for(condition in column_selection) {
        if(!length(condition) %in% c(2, 3) || !all(names(condition) %in% c("operation", "parameters", "negation"))) {
          stop("column_selection must be a list of conditions containing: operation and parameters (list)")
        }
        if (!condition[["operation"]] %in% column_selection_operations) stop("Unkown operation. Operation must be one of ", paste(column_selection_operations, collapse = ", "))
        if (!is.list(condition[["parameters"]])) stop("parameters must be a list.")
        if (is.null(condition[["negation"]])) condition[["negation"]] <- FALSE
        if (!is.logical(condition[["negation"]])) stop("negative must be either TRUE or FALSE.")
      }
      if(name %in% names(private$column_selection)) message("A column selection named ", name, " already exists. It will be replaced by the new column selection.")
      column_selection_obj <- list(name = name,
                                   conditions = column_selection,
                                   is_everything = is_everything,
                                   and_or = and_or
      )
      private$column_selections[[name]] <- column_selection_obj
      self$append_to_changes(list(Added_column_selection, name))
      if(set_as_current) {
        self$current_column_selection <- column_selection_obj
        self$data_changed <- TRUE
      }
    },
    
    #' @description
    #' Get the current column selection.
    #'
    #' @return List, the current column selection.
    get_current_column_selection = function() {
      return(private$.current_column_selection)
    },
    
    #' @description
    #' Set the current column selection by name.
    #'
    #' @param name Character, the name of the column selection to set as current.
    set_current_column_selection = function(name = "") {
      if (!name %in% names(private$column_selections)) stop(name, " not found as a column selection.")
      if (length(self$get_column_selection_column_names(name)) == 0) {
        cat(name, " has no columns selected.")
      } else {
        self$current_column_selection <- private$column_selections[[name]]
      }
    },
    
    #' @description
    #' Get the names of all column selections.
    #'
    #' @param as_list Logical, if TRUE, returns the names as a list.
    #' @param include List, the properties to include.
    #' @param exclude List, the properties to exclude.
    #' @param excluded_items Character vector, the items to exclude.
    #'
    #' @return Character vector or list, the names of the column selections.
    get_column_selection_names = function(as_list = FALSE, include = list(), exclude = list(), excluded_items = c()) {
      out <- names(private$column_selections)
      if(length(excluded_items) > 0) {
        ex_ind <- which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of column selections.")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(as_list) {
        lst = list()
        lst[[self$get_metadata(data_name_label)]] <- out
        return(lst)
      }
      else return(out)
    },
    
    #' @description
    #' Get a specific column selection by name.
    #'
    #' @param name Character, the name of the column selection.
    #'
    #' @return List, the specified column selection.
    get_column_selection = function(name) {
      if(missing(name)) return(private$column_selections)
      if(!name %in% names(private$column_selections)) stop(name, " not found as a column selection.")
      return(private$column_selections[[name]])
    },
    
    #' @description
    #' Get the column names selected by a specific column selection.
    #'
    #' @param name Character, the name of the column selection.
    #'
    #' @return Character vector, the column names selected by the column selection.
    get_column_selection_column_names = function(name) {
      curr_column_selection <- self$get_column_selection(name)
      all_column_names <- names(private$data)
      if (length(curr_column_selection[["conditions"]]) == 0) return(all_column_names)
      and_or <- curr_column_selection[["and_or"]]
      i <- 1
      res <- vector("list", length(curr_column_selection[["conditions"]]))
      for (condition in curr_column_selection[["conditions"]]) {
        op <- condition[["operation"]]
        args <- condition[["parameters"]]
        neg <- condition[["negation"]]
        if (is.null(neg)) neg <- FALSE
        fn <- switch(op,
                     "base::match" = base::match,
                     "tidyselect::starts_with" = tidyselect::starts_with,
                     "tidyselect::ends_with" = tidyselect::ends_with,
                     "tidyselect::contains" = tidyselect::contains,
                     "tidyselect::matches" = tidyselect::matches,
                     "tidyselect::num_range" = tidyselect::num_range,
                     "tidyselect::last_col" =  tidyselect::last_col,
                     "tidyselect::where" = NULL,
                     NULL
        )
        if (op == "base::match") {
          args$table <- all_column_names
          res[[i]] <- do.call(fn, args)
        }else if (op == "tidyselect::where"){
          selected_columns <- private$data |> 
            dplyr::select(where(args$fn)) |> 
            colnames()
          res[[i]] <- which(all_column_names %in% selected_columns)
        }else{
          args$vars <- all_column_names
          res[[i]] <- do.call(fn, args)
        }
        if (neg) res[[i]] <- setdiff(1:length(all_column_names), res[[i]])
        i <- i + 1
      }
      if (and_or == "&") {
        out <- Reduce(intersect, res)
      } else if (and_or == "|") {
        out <- Reduce(union, res)
      } else {
        stop("and_or must be & or |")
      }
      return(all_column_names[out])
    },
    
    #' @description
    #' Get the column names selected by the current column selection.
    #'
    #' @param column_selection_name Character, the name of the column selection.
    #'
    #' @return Character vector, the column names selected by the current column selection.
    get_column_selected_column_names = function(column_selection_name = "") {
      if(column_selection_name != "") {
        selected_columns <- self$get_column_selection_column_names(column_selection_name)
        return(selected_columns)
      }
    },
    
    #' @description
    #' Check if a column selection is applied.
    #'
    #' @return Logical, TRUE if a column selection is applied, FALSE otherwise.
    column_selection_applied = function() {
      curr_sel <- private$.current_column_selection
      if (is.null(curr_sel) || length(curr_sel) == 0) {
        return(FALSE)
      } else return(!curr_sel[["is_everything"]])
    },
    
    #' @description
    #' Remove the current column selection.
    remove_current_column_selection = function() {
      self$set_current_column_selection(".everything")
      self$append_to_variables_metadata(self$get_column_names(), is_hidden_label, FALSE)
      private$.variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Get the fields of the variables metadata.
    #'
    #' @param as_list Logical, if TRUE, returns the fields as a list.
    #' @param include Character vector, the fields to include.
    #' @param exclude Character vector, the fields to exclude.
    #' @param excluded_items Character vector, the items to exclude.
    #'
    #' @return Character vector or list, the fields of the variables metadata.
    get_variables_metadata_fields = function(as_list = FALSE, include = c(), exclude = c(), excluded_items = c()) {
      out = names(self$get_variables_metadata())
      if(length(excluded_items) > 0){
        ex_ind = which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of objects")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(as_list) {
        lst = list()
        lst[[self$get_metadata(data_name_label)]] <- out
        return(lst)
      }
      else return(out)
    },
    
    #' @description
    #' Add an object to the data.
    #'
    #' @param object_name Character, the name of the object.
    #' @param object_type_label Character, the type label of the object.
    #' @param object_format Character, the format of the object.
    #' @param object Any, the object to add.
    add_object = function(object_name, object_type_label, object_format, object) {
      if(missing(object_name)){
        object_name <- next_default_item("object", names(private$objects))
      } 
      
      if(object_name %in% names(private$objects)){
        message("An object called ", object_name, " already exists. It will be replaced.")
      }
      
      #add the object with its metadata to the list of objects and add an "Added_object" change 
      private$objects[[object_name]] <- list(object_type_label = object_type_label, object_format = object_format, object = object)
      self$append_to_changes(list(Added_object, object_name))
    },
    
    #' @description
    #' Get the names of objects.
    #'
    #' @param object_type_label Character, the type label of the objects to get names for.
    #' @param as_list Logical, if TRUE, returns the names as a list.
    #'
    #' @return Character vector or list, the names of the objects.
    get_object_names = function(object_type_label = NULL, as_list = FALSE) {
      out <- get_data_book_output_object_names(output_object_list = private$objects, 
                                               object_type_label = object_type_label,  
                                               as_list = as_list, 
                                               list_label= self$get_metadata(data_name_label) )
      return(out)
      
    },
    
    #' @description
    #' Get objects by type label.
    #'
    #' @param object_type_label Character, the type label of the objects to get.
    #'
    #' @return List, the objects with the specified type label.
    get_objects = function(object_type_label = NULL) {
      out <-
        private$objects[self$get_object_names(object_type_label = object_type_label)]
      return(out)
    },
    
    #' @description
    #' Get a specific object by name.
    #'
    #' @param object_name Character, the name of the object.
    #'
    #' @return Any, the specified object.
    get_object = function(object_name) {
      #make sure supplied object name is a character, prevents return of unexpected object
      if(is.character(object_name) ){
        return(private$objects[[object_name]])
      }else{
        return(NULL)
      }
    },
    
    #' @description
    #' Rename an object.
    #'
    #' @param object_name Character, the current name of the object.
    #' @param new_name Character, the new name for the object.
    #' @param object_type Character, the type of the object.
    rename_object = function(object_name, new_name, object_type = "object") {
      if(!object_type %in% c("object", "filter", "calculation", "graph", "table","model","structure","summary", "column_selection")) stop(object_type, " must be either object (graph, table or model), filter, column_selection or a calculation.")
      
      #Temp fix:: added graph, table and model so as to distinguish this when implementing it in the dialog. Otherwise they remain as objects
      if (object_type %in% c("object", "graph", "table","model","structure","summary")){
        
        if(!object_name %in% names(private$objects)) stop(object_name, " not found in objects list")
        if(new_name %in% names(private$objects)) stop(new_name, " is already an object name. Cannot rename ", object_name, " to ", new_name)
        names(private$objects)[names(private$objects) == object_name] <- new_name
      } 
      else if (object_type == "filter"){
        if(!object_name %in% names(private$filters)) stop(object_name, " not found in filters list")
        if(new_name %in% names(private$filters)) stop(new_name, " is already a filter name. Cannot rename ", object_name, " to ", new_name)
        if("no_filter" == object_name) stop("Renaming no_filter is not allowed.")
        names(private$filters)[names(private$filters) == object_name] <- new_name
        if(private$.current_filter$name == object_name){private$.current_filter$name <- new_name}
      } 
      else if (object_type == "calculation") {
        if(!object_name %in% names(private$calculations)) stop(object_name, " not found in calculations list")
        if(new_name %in% names(private$calculations)) stop(new_name, " is already a calculation name. Cannot rename ", object_name, " to ", new_name)
        names(private$calculations)[names(private$calculations) == object_name] <- new_name
      }
      else if (object_type == "column_selection"){
        if(!object_name %in% names(private$column_selections)) stop(object_name, " not found in column selections list")
        if(new_name %in% names(private$column_selections)) stop(new_name, " is already a column selection name. Cannot rename ", object_name, " to ", new_name)
        if(".everything" == object_name) stop("Renaming .everything is not allowed.")
        names(private$column_selections)[names(private$column_selections) == object_name] <- new_name
        if(private$.current_column_selection$name == object_name){private$.current_column_selection$name <- new_name}
      } 
    },
    
    #' @description
    #' Delete objects.
    #'
    #' @param data_name Character, the name of the data.
    #' @param object_names Character vector, the names of the objects to delete.
    #' @param object_type Character, the type of the objects to delete.
    delete_objects = function(data_name, object_names, object_type = "object") {
      if(!object_type %in% c("object", "graph", "table","model","structure","summary","filter", "calculation", "column_selection")) stop(object_type, " must be either object (graph, table or model), filter, column selection or a calculation.")
      
      if(any(object_type %in% c("object", "graph", "table","model","structure","summary"))){
        
        if(!all(object_names %in% names(private$objects))) stop("Not all object_names found in overall objects list.")
        private$objects[names(private$objects) %in% object_names] <- NULL
      }else if(object_type == "filter"){
        if(!all(object_names %in% names(private$filters))) stop(object_names, " not found in filters list.")
        if("no_filter" %in% object_names) stop("no_filter cannot be deleted.")
        if(any(private$.current_filter$name %in% object_names))stop(private$.current_filter$name, " is currently in use and cannot be deleted.")
        private$filters[names(private$filters) %in% object_names] <- NULL
      }else if(object_type == "calculation"){
        if(!object_names %in% names(private$calculations)) stop(object_names, " not found in calculations list.")
        private$calculations[names(private$calculations) %in% object_names] <- NULL
      }else if(object_type == "column_selection"){
        if(!all(object_names %in% names(private$column_selections))) stop(object_names, " not found in column selections list.")
        if(".everything" %in% object_names) stop(".everything cannot be deleted.")
        if(any(private$.current_column_selection$name %in% object_names))stop(private$.current_column_selection$name, " is currently in use and cannot be deleted.")
        private$column_selections[names(private$column_selections) %in% object_names] <- NULL
      }
      if(!is.null(private$.last_graph) && length(private$.last_graph) == 2 && private$.last_graph[1] == data_name && private$.last_graph[2] %in% object_names) {
        private$.last_graph <- NULL
      }
    },
    
    #' @description
    #' Reorder objects.
    #'
    #' @param new_order Character vector, the new order of the objects.
    reorder_objects = function(new_order) {
      if(length(new_order) != length(private$objects) || !setequal(new_order, names(private$objects))) stop("new_order must be a permutation of the current object names.")
      self$set_objects(private$objects[new_order])
    },
    
    #' @description
    #' Clone the data sheet.
    #'
    #' @param include_objects Logical, if TRUE, includes objects in the clone.
    #' @param include_metadata Logical, if TRUE, includes metadata in the clone.
    #' @param include_logs Logical, if TRUE, includes logs in the clone.
    #' @param include_filters Logical, if TRUE, includes filters in the clone.
    #' @param include_column_selections Logical, if TRUE, includes column selections in the clone.
    #' @param include_calculations Logical, if TRUE, includes calculations in the clone.
    #' @param include_comments Logical, if TRUE, includes comments in the clone.
    #' @param ... Additional arguments.
    #'
    #' @return DataSheet, the cloned data sheet.
    data_clone = function(include_objects = TRUE, include_metadata = TRUE, include_logs = TRUE, include_filters = TRUE, include_column_selections = TRUE, include_calculations = TRUE, include_comments = TRUE, ...) {
      if(include_objects) new_objects <- private$objects
      else new_objects <- list()
      if(include_filters) new_filters <- lapply(private$filters, function(x) x$data_clone())
      else new_filters <- list()
      if(include_column_selections) new_column_selections <- private$column_selections
      else new_column_selections <- list()
      if(include_calculations) new_calculations <- lapply(private$calculations, function(x) x$data_clone())
      else new_calculations <- list()
      if(include_comments) new_comments <- lapply(private$comments, function(x) x$data_clone())
      else new_comments <- list()
      
      ret <- DataSheet$new(data = private$data, data_name = self$get_metadata(data_name_label), filters = new_filters, column_selections = new_column_selections, objects = new_objects, calculations = new_calculations, keys = private$keys, comments = new_comments, keep_attributes = include_metadata)
      if(include_logs) ret$set_changes(private$changes)
      else ret$set_changes(list())
      if(include_filters) ret$current_filter <- self$get_current_filter()
      else {
        ret$remove_current_filter()
      }
      if(include_column_selections) ret$current_column_selection <- self$get_current_column_selection()
      else {
        ret$remove_current_column_selection()
      }
      if(!include_metadata) {
        self$clear_metadata()
        self$clear_variables_metadata()
      }
      ret$data_changed <- TRUE
      ret$metadata_changed <- TRUE
      ret$variables_metadata_changed <- TRUE
      return(ret)
    },
    
    #' @description
    #' Freeze columns in the data.
    #'
    #' @param column Character, the name of the column to freeze.
    freeze_columns = function(column) {
      self$unfreeze_columns()
      self$append_to_variables_metadata(column, is_frozen_label, TRUE)
    },
    
    #' @description
    #' Unfreeze all columns in the data.
    unfreeze_columns = function() {
      self$append_to_variables_metadata(self$get_column_names(), is_frozen_label, FALSE)
    },
    
    #' @description
    #' Add a key to the data.
    #'
    #' @param col_names Character vector, the names of the columns to use as the key.
    #' @param key_name Character, the name of the key.
    add_key = function(col_names, key_name) {
      cols <- self$get_columns_from_data(col_names, use_current_filter = FALSE)
      if(anyDuplicated(cols) > 0) {
        stop("key columns must have unique combinations")
      }
      if(self$is_key(col_names)) {
        warning("A key with these columns already exists. No action will be taken.")
      }
      else {
        if(missing(key_name)) key_name <- next_default_item("key", names(private$keys))
        if(key_name %in% names(private$keys)) warning("A key called", key_name, "already exists. It will be replaced.")
        private$keys[[key_name]] <- col_names
        self$append_to_variables_metadata(col_names, is_key_label, TRUE)
        if(length(private$keys) == 1) self$append_to_variables_metadata(setdiff(self$get_column_names(), col_names), is_key_label, FALSE)
        self$append_to_metadata(is_linkable, TRUE)
        self$append_to_metadata(key_label, paste(private$keys[[key_name]], collapse = ","))
        cat(paste("Key name:", key_name),
            paste("Key columns:", paste(private$keys[[key_name]], collapse = ", ")),
            sep = "\n")
      }
    },
    
    #' @description
    #' Check if columns are a key.
    #'
    #' @param col_names Character vector, the names of the columns to check.
    #'
    #' @return Logical, TRUE if the columns are a key, FALSE otherwise.
    is_key = function(col_names) {
      return(any(sapply(private$keys, function(x) setequal(col_names,x))))
    },
    
    #' @description
    #' Check if the data has a key.
    #'
    #' @return Logical, TRUE if the data has a key, FALSE otherwise.
    has_key = function() {
      return(length(private$keys) > 0)
    },
    
    #' @description
    #' Get the keys in the data.
    #'
    #' @param key_name Character, the name of the key to get.
    #'
    #' @return List, the keys in the data.
    get_keys = function(key_name) {
      if(!missing(key_name)) {
        if(!key_name %in% names(private$keys)) stop(key_name, " not found.")
        cat(paste("Key name:", key_name),
            paste("Key columns:", paste(private$keys[[key_name]], collapse = ", ")),
            sep = "\n")
      }
      else return(private$keys)
    },
    
    #' @description
    #' Remove a key from the data.
    #'
    #' @param key_name Character, the name of the key to remove.
    remove_key = function(key_name) {
      if(!key_name %in% names(private$keys)) stop(key_name, " not found.")
      self$append_to_variables_metadata(private$keys[[key_name]], is_key_label, FALSE)
      private$keys[[key_name]] <- NULL
      self$append_to_metadata(key_label, NULL)
      cat("Key removed:", key_name)
    },
    
    #' @description
    #' Get comments in the data.
    #'
    #' @param comment_id Character, the ID of the comment to get.
    #'
    #' @return List, the comments in the data.
    get_comments = function(comment_id) {
      if(!missing(comment_id)) {
        if(!comment_id %in% self$get_comment_ids()) stop("Could not find comment with id: ", comment_id)
        return(private$comments[[comment_id]])
      }
      else return(private$comments)
    },
    
    #' @description
    #' Remove a comment from the data.
    #'
    #' @param key_name Character, the name of the key to remove the comment from.
    remove_comment = function(key_name) {
      if(!key_name %in% names(private$keys)) stop(key_name, " not found.")
      private$keys[[key_name]] <- NULL
    },
    
    #' @description
    #' Set the structure columns in the data.
    #'
    #' @param struc_type_1 Character vector, the names of the columns for structure type 1.
    #' @param struc_type_2 Character vector, the names of the columns for structure type 2.
    #' @param struc_type_3 Character vector, the names of the columns for structure type 3.
    set_structure_columns = function(struc_type_1, struc_type_2, struc_type_3) {
      if(!all(c(struc_type_1,struc_type_2,struc_type_3) %in% self$get_column_names())) stop("Some column names not recognised.")
      if(length(intersect(struc_type_1,struc_type_2)) > 0 || length(intersect(struc_type_1,struc_type_3)) > 0 || length(intersect(struc_type_2,struc_type_3)) > 0) {
        stop("Each column can only be assign one structure type.")
      }
      if(length(struc_type_1) > 0) self$append_to_variables_metadata(struc_type_1, structure_label, structure_type_1_label)
      if(length(struc_type_2) > 0) self$append_to_variables_metadata(struc_type_2, structure_label, structure_type_2_label)
      if(length(struc_type_3) > 0) self$append_to_variables_metadata(struc_type_3, structure_label, structure_type_3_label)
      all <- union(union(struc_type_1, struc_type_2), struc_type_3)
      other <- setdiff(self$get_column_names(), all)
      self$append_to_variables_metadata(other, structure_label, NA)
    },
    
    #' @description
    #' Add dependent columns to the data.
    #'
    #' @param columns Character vector, the names of the columns.
    #' @param dependent_cols List, the dependent columns.
    add_dependent_columns = function(columns, dependent_cols) {
      for(col in columns) {
        if(self$is_variables_metadata(dependent_columns_label, col)) {
          curr_dependents <- self$get_variables_metadata(property = dependent_columns_label, column = col, direct_from_attributes = TRUE)
          for(data_frame in names(dependent_cols)) {
            if(data_frame %in% names(curr_dependents)) {
              curr_dependents[[data_frame]] <- union(curr_dependents[[data_frame]], dependent_cols[[data_frame]])
            }
            else {
              curr_dependents[[data_frame]] <- dependent_cols[[data_frame]]
            }
          }
        }
        else curr_dependents <- as.list(dependent_cols)
        self$append_to_variables_metadata(col, dependent_columns_label, curr_dependents)
      }
    },
    
    #' @description
    #' Set the colors of the columns in the data.
    #'
    #' @param columns Character vector, the names of the columns.
    #' @param colours Character vector, the colors to set.
    set_column_colours = function(columns, colours) {
      if(missing(columns)) columns <- self$get_column_names()
      if(length(columns) != length(colours)) stop("columns must be the same length as colours")
      
      for(i in 1:length(columns)) {
        self$append_to_variables_metadata(columns[i], colour_label, colours[i])
      }
      other_cols <- self$get_column_names()[!self$get_column_names() %in% columns]
      self$append_to_variables_metadata(other_cols, colour_label, -1)
    },
    
    #' @description
    #' Check if columns have colors.
    #'
    #' @param columns Character vector, the names of the columns.
    #'
    #' @return Logical, TRUE if the columns have colors, FALSE otherwise.
    has_colours = function(columns) {
      return(self$is_variables_metadata(str = colour_label))
    },
    
    #' @description
    #' Set the colors of the columns based on metadata.
    #'
    #' @param data_name Character, the name of the data.
    #' @param columns Character vector, the names of the columns.
    #' @param property Character, the property to base the colors on.
    set_column_colours_by_metadata = function(data_name, columns, property) {
      if(!missing(data_name) && missing(columns)) columns <- names(self$get_data_frame(data_name = data_name))
      if(missing(columns)) property_values <- self$get_variables_metadata(property = property)
      else property_values <- self$get_variables_metadata(property = property, column = columns)
      
      new_colours <- as.numeric(make_factor(property_values))
      new_colours[is.na(new_colours)] <- -1
      if(missing(columns)) self$set_column_colours(colours = new_colours)
      else self$set_column_colours(columns = columns, colours = new_colours)
    },
    
    #' @description
    #' Remove the colors from all columns.
    remove_column_colours = function() {
      if(self$is_variables_metadata(str = colour_label)) {
        self$append_to_variables_metadata(property = colour_label, new_val = -1)
      }
    },
    
    #' @description
    #' Create a graph for one variable.
    #'
    #' @param columns Character vector, the names of the columns.
    #' @param numeric Character, the geom for numeric columns.
    #' @param categorical Character, the geom for categorical columns.
    #' @param output Character, the output type ("facets", "combine", "single").
    #' @param free_scale_axis Logical, if TRUE, uses a free scale for the axis.
    #' @param ncol Numeric, the number of columns for facets.
    #' @param coord_flip Logical, if TRUE, flips the coordinates.
    #' @param ... Additional arguments for the geom functions.
    #'
    #' @return ggplot2 object, the graph.
    graph_one_variable = function(columns, numeric = "geom_boxplot", categorical = "geom_bar", output = "facets", free_scale_axis = FALSE, ncol = NULL, coord_flip = FALSE, ...) {
      if(!all(columns %in% self$get_column_names())) {
        stop("Not all columns found in the data")
      }
      if(!output %in% c("facets", "combine", "single")) {
        stop("output must be one of: facets, combine or single")
      }
      if(!numeric %in% c("box_jitter", "violin_jitter", "violin_box")) {
        numeric_geom <- match.fun(numeric)
      }
      else {
        numeric_geom <- numeric
      }
      if(categorical %in% c("pie_chart")) {
        cat_geom <- categorical
      }
      else {
        cat_geom <- match.fun(categorical)
      }
      curr_data <- self$get_data_frame()
      column_types <- c()
      for(col in columns) {
        # TODO this could be method to avoid needing to get full data frame in this method
        # Everything non numeric is treated as categorical
        if(is.numeric(curr_data[[col]])) {
          column_types <- c(column_types, "numeric")
        }
        else {
          column_types <- c(column_types, "cat")
        }
      }
      if(output == "facets") {
        if(length(unique(column_types)) > 1) {
          warning("Cannot do facets with graphs of different types. Combine graphs will be used instead.")
          output <- "combine"
        }
        else column_types <- unique(column_types)
      }
      if(output == "facets") {
        # column_types will be unique by this point
        column_types <- column_types[1]
        if(column_types == "numeric") {
          curr_geom <- numeric_geom
          curr_geom_name <- numeric
        }
        else if(column_types == "cat") {
          curr_geom <- cat_geom
          curr_geom_name <- categorical
        }
        else {
          stop("Cannot plot columns of type:", column_types[i])
        }    
        curr_data <- self$get_data_frame(stack_data = TRUE, measure.vars = columns)
        if(curr_geom_name == "geom_boxplot" || curr_geom_name == "geom_point" || curr_geom_name == "geom_violin" || curr_geom_name == "geom_jitter" || curr_geom_name == "box_jitter" || curr_geom_name == "violin_jitter" || curr_geom_name == "violin_box") {
          g <- ggplot2::ggplot(data = curr_data, mapping = aes(x = "", y = value)) + xlab("")
        }
        else {
          g <- ggplot2::ggplot(data = curr_data, mapping = aes(x = value)) + ylab("")
        }
        
        if(curr_geom_name == "box_jitter") {
          g <- g + ggplot2::geom_boxplot() + ggplot2::geom_jitter(width = 0.2, height = 0.2)
        }
        else if(curr_geom_name == "violin_jitter") {
          g <- g + ggplot2::geom_violin() + ggplot2::geom_jitter(width = 0.2, height = 0.2)
        }
        else if(curr_geom_name == "violin_box") {
          g <- g + ggplot2::geom_violin() + ggplot2::geom_boxplot() 
        }
        else if(curr_geom_name == "pie_chart") {
          g <- g + ggplot2::geom_bar() + ggplot2::coord_polar(theta = "x")
        }
        else {
          g <- g + curr_geom()
        }
        
        if (coord_flip) {
          g <- g + ggplot2::coord_flip()
        }   
        if(free_scale_axis) {
          g <- g + ggplot2::facet_wrap(facets = ~ variable, scales = "free", ncol = ncol)
        }
        else { 
          g <- g + ggplot2::facet_wrap(facets = ~ variable, scales = "free_x", ncol = ncol)
        }
        
        return(g)    
      }
      else {
        graphs <- list()
        i = 1
        for(column in columns) {
          if(column_types[i] == "numeric") {
            curr_geom <- numeric_geom
            curr_geom_name <- numeric
          }
          else if(column_types[i] == "cat") {
            curr_geom <- cat_geom
            curr_geom_name <- categorical
          }
          else {
            stop("Cannot plot columns of type:", column_types[i])
          }
          if(curr_geom_name == "geom_boxplot" || curr_geom_name == "geom_violin" || curr_geom_name == "geom_point" || curr_geom_name == "geom_jitter" || curr_geom_name == "box_jitter" || curr_geom_name == "violin_jitter" || curr_geom_name == "violin_box") {
            g <- ggplot2::ggplot(data = curr_data, mapping = aes_(x = "", y = as.name(column))) + xlab("")
          }
          else {
            g <- ggplot2::ggplot(data = curr_data, mapping = aes_(x = as.name(column))) + ylab("")
          }
          if (coord_flip) {
            g <- g + ggplot2::coord_flip()
          } 
          if(curr_geom_name == "box_jitter") {
            g <- g + ggplot2::geom_boxplot() + ggplot2::geom_jitter(width = 0.2, height = 0.2)
          }
          else if(curr_geom_name == "violin_jitter") {
            g <- g + ggplot2::geom_violin() + ggplot2::geom_jitter(width = 0.2, height = 0.2)
          }
          else if(curr_geom_name == "violin_box") {
            g <- g + ggplot2::geom_violin() + ggplot2::geom_boxplot()
          }
          else if(curr_geom_name == "pie_chart") {
            g <- g + ggplot2::geom_bar() + ggplot2::coord_polar(theta = "x")
          }
          else {
            g <- g + curr_geom()
          }
          graphs[[i]] <- g
          i = i + 1
        }
        if(output == "combine") {
          return(patchwork::wrap_plots(graphs, ncol = ncol))
        }
        else {
          return(graphs)
        }
      }
    },
    
    #' @description
    #' Create a date from year, month, and day columns.
    #'
    #' @param year Character, the name of the year column.
    #' @param month Character, the name of the month column.
    #' @param day Character, the name of the day column.
    #' @param f_year Numeric vector, the year values.
    #' @param f_month Numeric vector, the month values.
    #' @param f_day Numeric vector, the day values.
    #' @param year_format Character, the format of the year.
    #' @param month_format Character, the format of the month.
    #'
    #' @return Date, the created date.
    make_date_yearmonthday = function(year, month, day, f_year, f_month, f_day, year_format = "%Y", month_format = "%m") {
      if(!missing(year)) year_col <- self$get_columns_from_data(year, use_current_filter = FALSE)
      else if(!missing(f_year)) year_col <- f_year
      else stop("One of year or f_year must be specified.")
      if(!missing(month)) month_col <- self$get_columns_from_data(month, use_current_filter = FALSE)
      else if(!missing(f_month)) month_col <- f_month
      else stop("One of month or f_month must be specified.")
      if(!missing(day)) day_col <- self$get_columns_from_data(day, use_current_filter = FALSE)
      else if(!missing(f_day)) day_col <- f_day
      else stop("One of day or f_day must be specified.")
      
      if(missing(year_format)) {
        year_counts <- stringr::str_count(year_col)
        if(length(unique(year_counts)) > 1) stop("Year column has inconsistent year formats")
        else {
          year_length <- year_counts[1]
          if(year_length == 2) year_format = "%y"
          else if(year_length == 4) year_format = "%Y"
          else stop("Cannot detect year format with ", year_length, " digits.")
        }
      }
      if(missing(month_format)) {
        if(all(month_col %in% 1:12)) month_format = "%m"
        else if(all(month_col %in% month.abb)) month_format = "%b"
        else if(all(month_col %in% month.name)) month_format = "%B"
        else stop("Cannot detect month format")
      }
      return(as.Date(paste(year_col, month_col, day_col), format = paste(year_format, month_format, "%d")))
    },
    
    #' @description
    #' Create a date from year and day-of-year columns.
    #'
    #' @param year Character, the name of the year column.
    #' @param doy Character, the name of the day-of-year column.
    #' @param base Numeric, the base year.
    #' @param doy_typical_length Character, the typical length of the day-of-year ("365" or "366").
    #'
    #' @return Date, the created date.
    make_date_yeardoy = function(year, doy, base, doy_typical_length = "366") {
      if(!missing(year)) year_col <- self$get_columns_from_data(year, use_current_filter = FALSE)
      if(!missing(doy)) doy_col <- self$get_columns_from_data(doy, use_current_filter = FALSE)
      
      year_counts <- stringr::str_count(year_col)
      year_length <- year_counts[1]
      if(year_length == 2){
        if(missing(base)) stop("Base must be specified.")
        year_col <- dplyr::if_else(year_col <= base, year_col + 2000, year_col + 1900)
      }
      if(doy_typical_length == "366") {
        if(is.factor(year_col)) {
          year_col <- as.numeric(levels(year_col))[year_col]
        }
        #Replacing day 60 with 0 for non-leap years.This will result into NA dates
        doy_col[(!lubridate::leap_year(year_col)) & doy_col == 60] <- 0
        doy_col[(!lubridate::leap_year(year_col)) & doy_col > 60] <- doy_col[(!lubridate::leap_year(year_col)) & doy_col > 60] - 1
      }
      return(temp_date <- as.Date(paste(as.character(year_col), "-", doy_col), format = "%Y - %j"))
    }
    
    
  ),
  
  private = list(
    data = data.frame(),
    filters = list(),
    column_selections = list(),
    objects = list(),
    keys = list(),
    comments = list(),
    calculations = list(),
    changes = list(), 
    .current_filter = list(),
    .current_column_selection = list(),
    .data_changed = FALSE,
    .metadata_changed = FALSE, 
    .variables_metadata_changed = FALSE,
    .last_graph = NULL
  ),
  
  active = list(
    #' @field data_changed Logical, indicates if the data has changed. 
    #' If setting a value, new_value must be TRUE or FALSE.
    data_changed = function(new_value) {
      if (missing(new_value)) return(private$.data_changed)
      else {
        if (new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.data_changed <- new_value
        self$append_to_changes(list(Set_property, "data_changed"))
      }
    },
    
    #' @field metadata_changed Logical, indicates if the metadata has changed. 
    #' If setting a value, new_value must be TRUE or FALSE.
    metadata_changed = function(new_value) {
      if (missing(new_value)) return(private$.metadata_changed)
      else {
        if (new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.metadata_changed <- new_value
        self$append_to_changes(list(Set_property, "metadata_changed"))
      }
    },
    
    #' @field variables_metadata_changed Logical, indicates if the variables metadata has changed. 
    #' If setting a value, new_value must be TRUE or FALSE.
    variables_metadata_changed = function(new_value) {
      if (missing(new_value)) return(private$.variables_metadata_changed)
      else {
        if (new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.variables_metadata_changed <- new_value
        self$append_to_changes(list(Set_property, "variable_data_changed"))
      }
    },
    
    #' @field current_filter A list representing the current filter. 
    #' If setting a value, filter must be a list.
    current_filter = function(filter) {
      if (missing(filter)) {
        return(self$get_filter_as_logical(private$.current_filter$name))
      } else {
        private$.current_filter <- filter
        self$data_changed <- TRUE
        self$append_to_changes(list(Set_property, "current_filter"))
      }
    },
    
    #' @field current_column_selection A list representing the current column selection. 
    #' If setting a value, column_selection must be a list.
    current_column_selection = function(column_selection) {
      if (missing(column_selection)) {
        if (!is.null(private$.current_column_selection)) {
          return(self$get_column_selection_column_names(private$.current_column_selection$name))
        } else return(names(private$data))
      } else {
        private$.current_column_selection <- column_selection
        self$data_changed <- TRUE
        self$append_to_changes(list(Set_property, "current_column_selection"))
      }
    }
  )
)

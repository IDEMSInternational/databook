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

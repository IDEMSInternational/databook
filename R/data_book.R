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

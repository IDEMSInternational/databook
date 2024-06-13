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
#' @field data A data frame to be managed.
#' @field filters A list of filters to be applied to the data.
#' @field column_selections A list of column selections.
#' @field objects A list of objects associated with the data.
#' @field keys A list of keys for the data.
#' @field comments A list of comments associated with the data.
#' @field calculations A list of calculations to be performed on the data.
#' @field changes A list of changes applied to the data.
#' @field .current_filter The current filter being applied.
#' @field .current_column_selection The current column selection being applied.
#' @field .data_changed Logical, indicates if the data has changed.
#' @field .metadata_changed Logical, indicates if the metadata has changed.
#' @field .variables_metadata_changed Logical, indicates if the variables metadata has changed.
#' @field .last_graph The last graph generated.
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
                          messages = TRUE, convert=TRUE, create = TRUE, 
                          start_point=1, filters = list(), column_selections = list(), objects = list(),
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
    }
  ),
  
  private = list(
    #' @field data A data frame to be managed.
    data = data.frame(),
    #' @field filters A list of filters to be applied to the data.
    filters = list(),
    #' @field column_selections A list of column selections.
    column_selections = list(),
    #' @field objects A list of objects associated with the data.
    objects = list(),
    #' @field keys A list of keys for the data.
    keys = list(),
    #' @field comments A list of comments associated with the data.
    comments = list(),
    #' @field calculations A list of calculations to be performed on the data.
    calculations = list(),
    #' @field changes A list of changes applied to the data.
    changes = list(), 
    #' @field .current_filter The current filter being applied.
    .current_filter = list(),
    #' @field .current_column_selection The current column selection being applied.
    .current_column_selection = list(),
    #' @field .data_changed Logical, indicates if the data has changed.
    .data_changed = FALSE,
    #' @field .metadata_changed Logical, indicates if the metadata has changed.
    .metadata_changed = FALSE, 
    #' @field .variables_metadata_changed Logical, indicates if the variables metadata has changed.
    .variables_metadata_changed = FALSE,
    #' @field .last_graph The last graph generated.
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

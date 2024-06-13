#' DataSheet Class
#'
#' An R6 class to handle and manage a data frame with associated metadata, filters, and various settings.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{set_data(data, messages)}}{Sets the data for the DataSheet object.}
#'   \item{\code{set_changes(changes)}}{Sets the changes for the DataSheet object.}
#'   \item{\code{set_filters(filters)}}{Sets the filters for the DataSheet object.}
#'   \item{\code{set_column_selections(column_selections)}}{Sets the column selections for the DataSheet object.}
#'   \item{\code{set_meta(meta)}}{Sets the metadata for the DataSheet object.}
#'   \item{\code{clear_variables_metadata()}}{Clears the variables metadata for the DataSheet object.}
#'   \item{\code{add_defaults_meta()}}{Adds default metadata to the DataSheet object.}
#'   \item{\code{add_defaults_variables_metadata(column_names)}}{Adds default variables metadata to the DataSheet object.}
#'   \item{\code{set_objects(objects)}}{Sets the objects for the DataSheet object.}
#'   \item{\code{set_calculations(calculations)}}{Sets the calculations for the DataSheet object.}
#'   \item{\code{set_keys(keys)}}{Sets the keys for the DataSheet object.}
#'   \item{\code{set_comments(comments)}}{Sets the comments for the DataSheet object.}
#'   \item{\code{append_to_metadata(label, value)}}{Appends to the metadata of the DataSheet object.}
#'   \item{\code{is_metadata(label)}}{Checks if a label is in the metadata of the DataSheet object.}
#' }
#'
#' @section Active bindings:
#' \describe{
#'   \item{\code{data_changed}}{Indicates if the data has changed. When setting, the new value must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{metadata_changed}}{Indicates if the metadata has changed. When setting, the new value must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{variables_metadata_changed}}{Indicates if the variables metadata has changed. When setting, the new value must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{current_filter}}{Represents the current filter.}
#'   \item{\code{current_column_selection}}{Represents the current column selection.}
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
      if(keep_attributes) {
        self$set_meta(c(attributes(private$data), metadata))
      }
      else {
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
      if ( !(is.null(data_name) || data_name == "" || missing(data_name))) {
        if(data_name != make.names(iconv(data_name, to = "ASCII//TRANSLIT", sub = "."))) {
          message("data_name is invalid. It will be made valid automatically.")
          data_name <- make.names(iconv(data_name, to = "ASCII//TRANSLIT", sub = "."))
        }
        self$append_to_metadata(data_name_label, data_name)
      }
      else if (!self$is_metadata(data_name_label)) {
        if (( is.null(data_name) || data_name == "" || missing(data_name))) {
          self$append_to_metadata(data_name_label,paste0("data_set_",sprintf("%03d", start_point)))
          if (messages) {
            message(paste0("No name specified in data_tables list for data frame ", start_point, ". 
                       Data frame will have default name: ", "data_set_",sprintf("%03d", start_point)))
          }
        }
        else self$append_to_metadata(data_name_label, data_name)     
      }
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
    #' @param new_value Logical, if \code{TRUE} data has changed, if \code{FALSE} it has not.
    data_changed = function(new_value) {
      if(missing(new_value)) return(private$.data_changed)
      else {
        if(new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.data_changed <- new_value
        self$append_to_changes(list(Set_property, "data_changed"))
      }
    },
    #' @field metadata_changed Logical, indicates if the metadata has changed.
    #' @param new_value Logical, if \code{TRUE} metadata has changed, if \code{FALSE} it has not.
    metadata_changed = function(new_value) {
      if(missing(new_value)) return(private$.metadata_changed)
      else {
        if(new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.metadata_changed <- new_value
        self$append_to_changes(list(Set_property, "metadata_changed"))
      }
    },
    #' @field variables_metadata_changed Logical, indicates if the variables metadata has changed.
    #' @param new_value Logical, if \code{TRUE} variables metadata has changed, if \code{FALSE} it has not.
    variables_metadata_changed = function(new_value) {
      if(missing(new_value)) return(private$.variables_metadata_changed)
      else {
        if(new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.variables_metadata_changed <- new_value
        self$append_to_changes(list(Set_property, "variable_data_changed"))
      }
    },
    #' @field current_filter A list representing the current filter.
    #' @param filter A list specifying the filter to be set.
    current_filter = function(filter) {
      if(missing(filter)) {
        return(self$get_filter_as_logical(private$.current_filter$name))
      }
      else {
        private$.current_filter <- filter
        self$data_changed <- TRUE
        self$append_to_changes(list(Set_property, "current_filter"))
      }
    },
    #' @field current_column_selection A list representing the current column selection.
    #' @param column_selection A list specifying the column selection to be set.
    current_column_selection = function(column_selection) {
      if(missing(column_selection)) {
        if (!is.null(private$.current_column_selection)) {
          return(self$get_column_selection_column_names(private$.current_column_selection$name))
        } else return(names(private$data))
      }
      else {
        private$.current_column_selection <- column_selection
        self$data_changed <- TRUE
        self$append_to_changes(list(Set_property, "current_column_selection"))
      }
    }
  )
)

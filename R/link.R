#' Link Class
#'
#' @description
#' The `link` R6 class represents a relationship between two data frames, defined by link attributes and the columns used to link them.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{data_clone(...)}}{Creates a deep clone of the current `link` object, including all its fields.}
#'   \item{\code{rename_data_frame_in_link(old_data_name, new_data_name)}}{Renames one of the data frames involved in the link.}
#'   \item{\code{rename_column_in_link(data_name, old_column_name, new_column_name)}}{Renames a column involved in the link between data frames.}
#' }
#' @export
link <- R6::R6Class("link",
                    public = list(
                      
                      #' @description
                      #' Create a new `link` object.
                      #' Defines a relationship between two data frames and specifies linking columns.
                      #' 
                      #' @param from_data_frame A character string representing the name of the first data frame in the link.
                      #' @param to_data_frame A character string representing the name of the second data frame in the link.
                      #' @param type A character string representing the type of link, e.g., "keyed".
                      #' @param link_columns A list where each element defines a way to link the data frames, with each element as a named character vector. The names are columns in `from_data_frame` and the values are corresponding columns in `to_data_frame`.
                      initialize = function(from_data_frame = "",
                                            to_data_frame = "",
                                            type = "",
                                            link_columns = list()) {
                        self$from_data_frame <- from_data_frame
                        self$to_data_frame <- to_data_frame
                        self$type <- type
                        self$link_columns <- link_columns
                      },
                      
                      from_data_frame = "",
                      to_data_frame = "",
                      type = "",
                      link_columns = list(),
                      
                      #' @title Clone `link` Object
                      #' @description Creates a deep clone of the current `link` object, including all its fields.
                      #' @return A new `link` object with the same field values as the original.
                      data_clone = function(...) {
                        ret <- link$new(
                          from_data_frame = self$from_data_frame,
                          to_data_frame = self$to_data_frame,
                          type = self$type,
                          link_columns = self$link_columns
                        )
                        return(ret)
                      },
                      
                      #' @title Rename Data Frame in Link
                      #' @description Renames the specified data frame in the link.
                      #' @param old_data_name The current name of the data frame to be renamed.
                      #' @param new_data_name The new name for the data frame.
                      rename_data_frame_in_link = function(old_data_name, new_data_name) {
                        if (self$from_data_frame == old_data_name) self$from_data_frame <- new_data_name
                        if (self$to_data_frame == old_data_name) self$to_data_frame <- new_data_name
                      },
                      
                      #' @title Rename Column in Link
                      #' @description Renames a column involved in the link between data frames.
                      #' @param data_name The name of the data frame where the column is located.
                      #' @param old_column_name The current name of the column to be renamed.
                      #' @param new_column_name The new name for the column.
                      rename_column_in_link = function(data_name, old_column_name, new_column_name) {
                        if (self$from_data_frame == data_name) {
                          for (i in seq_along(self$link_columns)) {
                            names(self$link_columns[[i]])[which(old_column_name %in% names(self$link_columns[[i]]))] <- new_column_name
                          }
                        }
                        if (self$to_data_frame == data_name) {
                          for (i in seq_along(self$link_columns)) {
                            self$link_columns[[i]][which(old_column_name %in% self$link_columns[[i]])] <- new_column_name
                          }
                        }
                      }
                    ),
                    private = list(),
                    active = list()
)

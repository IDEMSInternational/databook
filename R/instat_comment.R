#' Instat Comment Class
#'
#' @description
#' The `instat_comment` R6 class represents a comment in a data sheet, with various properties including identifiers, key-value pairs, comment details, timestamps, and status flags for resolution and activity.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{data_clone(...)}}{Creates a deep clone of the current `instat_comment` object, including all of its fields and nested `instat_comment` replies.}
#' }
#' @export
instat_comment <- R6::R6Class("instat_comment",
                              public = list(
                                
                                #' @description
                                #' Create a new `instat_comment` object.
                                #' A comment is metadata for a row or cell of a data frame
                                #' A DataSheet will contain a list of instat_comment objects as part of the metadata for the data frame
                                #' 
                                #' @param id A numeric/character string representing the unique identifier for the comment. This must be unique within a data frame.
                                #' @param key_values A character vector storing key-value pairs associated with the comment. This identifies the row the comment is on.
                                #' @param column If the comment is on a cell, this is the name of the column of the cell
                                #' @param value If the comment is on a cell, this is the value in the cell at the time the comment was created.
                                #' @param type The type of comment (`"critical"`, `"warning"`, `"message"`, or `""`).
                                #' @param comment A character string for the comment text or message.
                                #' @param label A character variable. A label or grouping for the comment e.g. if comments are produced by an operation they may all have the same label. This then allows similar comments to be identified e.g. for editing/deleting
                                #' @param calculation A character variable. If the comment was created through a calculation e.g. filtering the data frame, this shows how the calculation done on the data frame
                                #' @param time_stamp The date and time (`POSIXct`, `POSIXt`) the comment was created, defaulting to the current system time if empty.
                                #' @param replies A list of replies to the comment. A reply could be a comment itself
                                #' @param resolved Logical value indicating if the comment is marked as resolved (`TRUE` or `FALSE`).
                                #' @param active Logical value indicating if the comment is marked as active (`TRUE` or `FALSE`).
                                #' @param attributes A named list of additional information about the comment.
                                initialize = function(id = "",
                                                      key_values = c(),
                                                      column = "",
                                                      value = "",
                                                      type = "",
                                                      comment = "",
                                                      label = "",
                                                      calculation = "",
                                                      time_stamp = "",
                                                      replies = list(),
                                                      resolved = FALSE,
                                                      active = TRUE,
                                                      attributes = list()) {
                                  self$id <- id
                                  self$key_values <- key_values
                                  self$column <- column
                                  self$value <- value
                                  if(!type %in% c("critical", "warning", "message", "")) stop("type must be blank or one of: ", paste(c("critical", "warning", "message", ""), collapse = ","))
                                  self$type <- type
                                  self$comment <- comment
                                  self$label <- label
                                  self$calculation <- calculation
                                  if(time_stamp == "") time_stamp <- Sys.time()
                                  self$time_stamp <- time_stamp
                                  self$replies <- replies
                                  self$resolved <- resolved
                                  self$active <- active
                                  self$attributes <- attributes
                                },
                                id = "",
                                key_values = c(),
                                column = "",
                                value = "",
                                type = "",
                                comment = "",
                                label = "",
                                calculation = "",
                                time_stamp = "",
                                replies = list(),
                                resolved = FALSE,
                                active = TRUE,
                                attributes = list(),
                                
                                #' @title Clone `instat_comment` Object
                                #' @description Creates a deep clone of the current `instat_comment` object, including all of its fields and nested `instat_comment` replies.
                                #' @details The `data_clone` method duplicates the current `instat_comment` object, ensuring any `instat_comment` instances within the `replies` field are recursively cloned. Non-`instat_comment` replies are directly copied without cloning.
                                #' @return A new `instat_comment` object with the same field values as the original, including a cloned list of `replies`.
                                #' 
                                data_clone = function(...) {
                                  replies <- list()
                                  
                                  # Clone each reply if it is an `instat_comment` object, otherwise copy as-is
                                  for (curr_reply in self$replies) {
                                    if ("instat_comment" %in% class(curr_reply)) {
                                      replies[[length(replies) + 1]] <- curr_reply$data_clone()
                                    } else {
                                      replies[[length(replies) + 1]] <- curr_reply
                                    }
                                  }
                                  
                                  # Create a new `instat_comment` instance with cloned fields
                                  ret <- instat_comment$new(
                                    id = self$id,
                                    key_values = self$key_values,
                                    column = self$column,
                                    value = self$value,
                                    type = self$type,
                                    comment = self$comment,
                                    label = self$label,
                                    calculation = self$calculation,
                                    time_stamp = self$time_stamp,
                                    replies = replies,
                                    resolved = self$resolved,
                                    active = self$active,
                                    attributes = self$attributes
                                  )
                                  
                                  return(ret)
                                }
                              ),
                              private = list(),
                              active = list()
)
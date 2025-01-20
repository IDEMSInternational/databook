## From calculations.R file:

#' Convert calculation list to a specific format
#'
#' @param x A list of calculations.
#' @return A formatted list of calculations.
#' @export
calc_from_convert <- function(x) {
  calc_list <- list()
  for (i in seq_along(x)) {
    for (j in seq_along(x[[i]])) {
      calc_list[[length(calc_list) + 1]] <- x[[i]][j]
      names(calc_list)[length(calc_list)] <- names(x)[i]
    }
  }
  return(calc_list)
}


#' Check and update filter object parameters
#'
#' @param filter_obj A filter object to check and update.
#' @return The updated filter object.
#' @export
check_filter <- function(filter_obj) {
  if (is.null(filter_obj$parameters[["and_or"]])) filter_obj$parameters[["and_or"]] <- "&"
  if (is.null(filter_obj$parameters[["outer_not"]])) filter_obj$parameters[["outer_not"]] <- FALSE
  if (is.null(filter_obj$parameters[["inner_not"]])) filter_obj$parameters[["inner_not"]] <- FALSE
  return(filter_obj)
}


#' Find data frame from calculation list
#'
#' @param x A list of calculations.
#' @param column The column name to search for.
#' @return The name of the data frame associated with the column.
#' @export
find_df_from_calc_from <- function(x, column) {
  for (i in seq_along(x)) {
    if (column %in% x[[i]]) return(names(x)[i])
  }
  return("")
}

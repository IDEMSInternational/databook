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
#'
#' @examples
#' # Extract names excluding specific items
#' get_data_book_scalar_names(list(a = 1, b = 2, c = 3), excluded_items = c("b"))
#'
#' # Return the names as a list with a label
#' get_data_book_scalar_names(list(a = 1, b = 2), as_list = TRUE, list_label = "Scalars")
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

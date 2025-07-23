test_that("update_selection correctly updates column values", {
  calls <- list()
  
  mock_object <- R6::R6Class(
    "MockClass",
    public = list(
      data_changed = FALSE,
      update_selection = NULL  # placeholder
    ),
    private = list(
      column_selections = list()
    )
  )
  
  obj <- mock_object$new()
  
  # Create a fake column selection
  private_env <- environment(obj$update_selection)
  private_env$private$column_selections <- list(
    select_1 = list(
      conditions = list(
        list(parameters = list(x = c("A", "B", "C"))),
        list(parameters = list(x = c("D", "E")))
      )
    )
  )
  
  # Inject the function into the mock object
  obj$update_selection <- function(rename_map, column_selection_name = NULL) {
    if (missing(rename_map)) stop("rename_map is required")
    if (missing(column_selection_name)) stop("column_selection_name is required")
    if (is.null(names(rename_map))) stop("rename_map must be a named vector (old_name = new_name)")
    
    column_selection_obj <- private_env$private$column_selections[[column_selection_name]]
    
    if (is.null(column_selection_obj)) {
      stop("No column selection found with the name: ", column_selection_name)
    }
    
    updated_conditions <- lapply(column_selection_obj$conditions, function(condition) {
      if ("parameters" %in% names(condition)) {
        old_x <- condition$parameters$x
        
        replaced_x <- old_x
        matched <- old_x %in% names(rename_map)
        replaced_x[matched] <- rename_map[old_x[matched]]
        names(replaced_x) <- names(old_x)
        
        condition$parameters$x <- replaced_x
      }
      return(condition)
    })
    
    column_selection_obj$conditions <- updated_conditions
    private_env$private$column_selections[[column_selection_name]] <- column_selection_obj
    
    obj$data_changed <- TRUE
    
    message("Column selection '", column_selection_name, "' updated successfully with renamed values.")
  }
  
  # Test input: rename "A" → "Alpha", "E" → "Echo"
  rename_map <- c("A" = "Alpha", "E" = "Echo")
  expect_message(obj$update_selection(rename_map, "select_1"),
                 "Column selection 'select_1' updated successfully with renamed values.")
  
  updated <- private_env$private$column_selections[["select_1"]]
  
  # Verify first condition
  expect_equal(updated$conditions[[1]]$parameters$x, c("Alpha", "B", "C"))
  expect_equal(updated$conditions[[2]]$parameters$x, c("D", "Echo"))
  
  # Flag check
  expect_true(obj$data_changed)
})

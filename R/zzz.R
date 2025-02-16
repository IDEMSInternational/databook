#' @keywords internal
#' @description Runs automatically when the package is loaded and initialises `data_book`.
#' @export
.onLoad <- function(libname, pkgname) {
  data_book <<- DataBook$new()
}
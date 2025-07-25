DataSheet <- R6::R6Class("DataSheet",
                         public = list(
                           initialize = function(data = data.frame()) {
                             private$data <- data
                           },
                           get_data_frame = function(use_current_filter = FALSE) {
                             return(private$data)
                           },
                           get_dim_dataframe = function() {
                             return(dim(self$get_data_frame(use_current_filter = FALSE)))
                           }
                         ),
                         private = list(
                           data = NULL
                         )
)
test_that("get_dim_dataframe returns correct dimensions", {
  df <- data.frame(A = 1:5, B = letters[1:5])
  sheet <- DataSheet$new(df)
  expect_equal(sheet$get_dim_dataframe(), dim(df))
})

DataSheet <- R6::R6Class("DataSheet",
                     private = list(
                       changes = list()
                     ),
                     public = list(
                       append_to_changes = function(change) {
                         private$changes <- append(private$changes, list(change))
                       },
                       get_changes = function() {
                         return(private$changes)
                       }
                     )
)

test_that("get_changes returns correct list of changes", {
  ds <- DataSheet$new()
  ds$append_to_changes(list("Set_property", "comments"))
  ds$append_to_changes(list("Delete_column", "age"))
  
  result <- ds$get_changes()
  
  expected <- list(
    list("Set_property", "comments"),
    list("Delete_column", "age")
  )
  
  expect_equal(result, expected)
})

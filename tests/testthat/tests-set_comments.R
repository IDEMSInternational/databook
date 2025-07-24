test_that("set_comments sets comments correctly and logs the change", {
  # Mock Set_property constant
  Set_property <- "SET_PROPERTY"
  
  # Create a mock DataSheet class
  MockDataSheet <- R6::R6Class("MockDataSheet",
                               private = list(
                                 comments = NULL
                               ),
                               public = list(
                                 changes = list(),
                                 
                                 append_to_changes = function(change) {
                                   self$changes <- append(self$changes, list(change))
                                 },
                                 
                                 set_comments = function(new_comments) {
                                   if (!is.list(new_comments)) stop("new_comments must be of type: list")
                                   self$append_to_changes(list(Set_property, "comments"))  
                                   private$comments <- new_comments
                                 },
                                 
                                 get_comments = function() private$comments
                               )
  )
  
  # Create an instance
  sheet <- MockDataSheet$new()
  
  # Valid input
  comments_input <- list(author = "Jane", text = "Important comment.")
  sheet$set_comments(comments_input)
  
  # Check that comments were set
  expect_equal(sheet$get_comments(), comments_input)
  
  # Check that change was logged
  expect_true(any(sapply(sheet$changes, function(change) identical(change, list(Set_property, "comments")))))
})

test_that("set_comments throws error for non-list input", {
  Set_property <- "SET_PROPERTY"
  
  sheet <- R6::R6Class("MockDataSheet",
                       private = list(
                         comments = NULL
                       ),
                       public = list(
                         append_to_changes = function(change) {},
                         set_comments = function(new_comments) {
                           if (!is.list(new_comments)) stop("new_comments must be of type: list")
                           self$append_to_changes(list(Set_property, "comments"))  
                           private$comments <- new_comments
                         }
                       )
  )$new()
  
  # Invalid input (not a list)
  expect_error(sheet$set_comments("This is a string"), "new_comments must be of type: list")
})

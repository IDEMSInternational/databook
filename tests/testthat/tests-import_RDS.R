# tests/testthat/test-import_RDS.R

library(testthat)
library(R6)

# 1. Mock RDS object that mimics a DataBook with class "instat_object"
MockRDS <- R6Class("MockRDS",
                   inherit = DataBook, # so all methods exist
                   public = list(
                     initialize = function() {
                       self$set_data_objects(list())
                       self$set_meta(list())
                       self$set_objects(list())
                       self$set_links(list())
                     }
                   )
)

# 2. Add the required class manually
rds_obj <- MockRDS$new()
class(rds_obj) <- c("instat_object", class(rds_obj))

# 3. Test
test_that("import_RDS works with a valid instat_object", {
  db <- DataBook$new()
  expect_silent(
    db$import_RDS(rds_obj,
                  keep_existing = FALSE,
                  include_objects = TRUE,
                  include_metadata = TRUE,
                  include_logs = TRUE,
                  include_filters = TRUE,
                  include_column_selections = TRUE,
                  include_calculations = TRUE,
                  include_comments = TRUE)
  )
  expect_true(db$data_objects_changed)
})

test_that("import_RDS imports a data.frame directly", {
  db <- DataBook$new()
  df <- data.frame(a = 1:3, b = c("x", "y", "z"), stringsAsFactors = FALSE)

  expect_silent(db$import_RDS(df))
  expect_true("data_RDS" %in% db$get_data_names())
  expect_equal(db$get_data_frame("data_RDS"), df, ignore_attr = TRUE)
})

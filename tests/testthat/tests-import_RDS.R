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

test_that("import_RDS replaces existing data when keep_existing is FALSE", {
  db <- DataBook$new()
  db$import_data(list(old = data.frame(a = 1:2)))

  source <- DataBook$new()
  source$import_data(list(new = data.frame(b = 3:4)))

  expect_silent(
    db$import_RDS(
      source,
      keep_existing = FALSE,
      include_objects = FALSE,
      include_metadata = FALSE,
      include_logs = FALSE,
      include_filters = FALSE,
      include_column_selections = FALSE,
      include_calculations = FALSE,
      include_comments = FALSE
    )
  )

  expect_true(db$data_objects_changed)
  expect_equal(db$get_data_names(), "new")
})

test_that("import_RDS renames data on case-insensitive collision", {
  db <- DataBook$new()
  db$import_data(list(df = data.frame(a = 1:2)))

  source <- DataBook$new()
  source$import_data(list(DF = data.frame(b = 3:4)))

  expect_warning(
    db$import_RDS(
      source,
      keep_existing = TRUE,
      overwrite_existing = FALSE,
      include_objects = FALSE,
      include_metadata = FALSE,
      include_logs = FALSE,
      include_filters = FALSE,
      include_column_selections = FALSE,
      include_calculations = FALSE,
      include_comments = FALSE
    ),
    "renamed"
  )

  data_names <- db$get_data_names()
  expect_equal(length(data_names), 2)
  expect_equal(sum(tolower(data_names) == "df"), 1)
})

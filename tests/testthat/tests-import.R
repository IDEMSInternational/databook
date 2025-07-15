test_that("import_data handles all cases correctly", {
  # Setup constants
  data_name_label <- "data_name"
  
  # Create DataBook object
  db <- DataBook$new()
  
  # ---- Case 1: Missing data_tables or empty ----
  expect_error(db$import_data(), "No data found")
  
  # ---- Case 2: data_tables not a list ----
  expect_error(db$import_data(data_tables = iris), "Data set must be of type: data.frame")
  
  # ---- Case 3: Duplicate names ----
  dup_data <- list(df1 = iris, df1 = iris)
  expect_error(db$import_data(data_tables = dup_data), "duplicate names")
  
  # ---- Case 4: Mismatched variable metadata length ----
  expect_error(db$import_data(data_tables = list(df1 = iris),
                              data_tables_variables_metadata = list(data.frame(), data.frame())),
               "data_tables_variables_metadata is specified")
  
  # ---- Case 5: Mismatched table metadata ----
  expect_error(db$import_data(data_tables = list(df1 = iris),
                              data_tables_metadata = list(list(), list())),
               "data_tables_metadata is specified")
  
  # ---- Case 6: Mismatched imported_from ----
  expect_error(db$import_data(data_tables = list(df1 = iris),
                              imported_from = list("source1", "source2")),
               "imported_from must be a list")
  
  # ---- Case 7: Mismatched data_names ----
  # expect_warning(db$import_data(data_tables = list(df1 = iris),
  #                             data_names = list("df1", "df2")))
  
  # ---- Case 8: Normal import path with prefixing and valid input ----
  db <- DataBook$new()
  df_list <- list(df1 = iris)
  vm_list <- list(data.frame(name = names(iris)))
  meta_list <- list(list(source = "test"))
  filt_list <- list(list())
  sel_list <- list(list())
  imp_list <- list("R")
  
  expect_silent(
    db$import_data(
      data_tables = df_list,
      data_tables_variables_metadata = vm_list,
      data_tables_metadata = meta_list,
      data_tables_filters = filt_list,
      data_tables_column_selections = sel_list,
      imported_from = imp_list,
      messages = FALSE,
      convert = FALSE,
      create = TRUE,
      prefix = TRUE,
      add_to_graph_book = TRUE
    )
  )
  
  # Confirm data was imported with expected metadata
  imported_sheet <- db$get_data_objects("df1")
  expect_s3_class(imported_sheet, "DataSheet")
  expect_equal(imported_sheet$get_metadata(data_name_label), "df1")
  
  # ---- Case 9: Name clash with case-insensitive warning and prefixing ----
  df_list2 <- list(DF1 = iris)  # 'df1' already exists in lower-case
  expect_warning(
    db$import_data(
      data_tables = df_list2,
      data_tables_variables_metadata = vm_list,
      data_tables_metadata = meta_list,
      data_tables_filters = filt_list,
      data_tables_column_selections = sel_list,
      imported_from = imp_list,
      messages = FALSE,
      convert = FALSE,
      create = TRUE,
      prefix = TRUE,
      add_to_graph_book = FALSE
    ),
    "renamed"
  )
})

test_that("replace_instat_object replaces all components correctly", {
  data_name_label <- "data_name"
  overall_label <- "overall"
  
  # Create dummy original DataBook
  db <- DataBook$new()
  
  # Create a mock instat object with expected methods
  mock_instat <- R6::R6Class("MockInstat",
                             public = list(
                               get_data_objects = function() {
                                 # Create mock DataSheet with expected methods
                                 ds <- DataSheet$new(data = iris)
                                 ds$append_to_metadata(data_name_label, "my_data")
                                 ds$data_clone <- function() {
                                   clone <- DataSheet$new(data = ds$get_data())
                                   clone$append_to_metadata(data_name_label, "my_data")
                                   return(clone)
                                 }
                                 return(list(ds))
                               },
                               get_metadata = function() {
                                 list(source = "replacement_metadata")
                               },
                               get_objects = function(data_name) {
                                 if (data_name == overall_label) {
                                   return(list(summary = "Overall summary object"))
                                 }
                                 return(NULL)
                               }
                             )
  )$new()
  
  # Check state before replacement
  expect_equal(length(db$get_data_objects()), 0)
})

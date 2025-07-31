library(instatCalculations)

test_that("clone_instat_calculation clones a basic instat_calculation", {
  original_calc <- instat_calculation$new(
    function_exp = quote(a + b),
    type = "standard",
    name = "calc1",
    result_name = "result1",
    calculated_from = list("a", "b"),
    save = TRUE
  )
  
  cloner <- DataBook$new()
  cloned_calc <- cloner$clone_instat_calculation(original_calc)
  
  expect_s3_class(cloned_calc, "instat_calculation")
  expect_equal(cloned_calc$function_exp, original_calc$function_exp)
  expect_equal(cloned_calc$type, original_calc$type)
  expect_equal(cloned_calc$name, original_calc$name)
  expect_equal(cloned_calc$result_name, original_calc$result_name)
  expect_equal(cloned_calc$calculated_from, original_calc$calculated_from)
  expect_equal(cloned_calc$save, original_calc$save)
})

test_that("clone_instat_calculation clones nested manipulations and sub_calculations", {
  sub_calc <- instat_calculation$new(
    function_exp = quote(c + d),
    type = "sub",
    name = "sub1",
    result_name = "result_sub",
    calculated_from = list("c", "d"),
    save = FALSE
  )
  
  parent_calc <- instat_calculation$new(
    function_exp = quote(a + b),
    type = "main",
    name = "main",
    result_name = "result_main",
    manipulations = list(sub_calc),
    sub_calculations = list(sub_calc),
    calculated_from = list("a", "b"),
    save = TRUE
  )
  
  cloner <- DataBook$new()
  cloned_calc <- cloner$clone_instat_calculation(parent_calc)
  
  expect_equal(length(cloned_calc$manipulations), 1)
  expect_equal(length(cloned_calc$sub_calculations), 1)
  expect_equal(cloned_calc$manipulations[[1]]$result_name, "result_sub")
  expect_equal(cloned_calc$sub_calculations[[1]]$result_name, "result_sub")
  expect_false(identical(cloned_calc$manipulations[[1]], sub_calc)) # Deep clone check
})

# Dummy R6 class for testing
MyClass <- R6::R6Class("MyClass",
                       public = list(
                         data_objects_changed = FALSE,
                         set_data_objects = function(objs) {
                           private$.data_sheets <- objs
                         },
                         reorder_dataframes = function(data_frames_order) {
                           if(length(data_frames_order) != length(names(private$.data_sheets))) 
                             stop("number data frames to order should be equal to number of dataframes in the object")
                           if(!setequal(data_frames_order, names(private$.data_sheets))) 
                             stop("data_frames_order must be a permutation of the dataframe names.")
                           self$set_data_objects(private$.data_sheets[data_frames_order])
                           self$data_objects_changed <- TRUE
                         }
                       ),
                       private = list(
                         .data_sheets = NULL
                       )
)

# Test case
test_that("reorder_dataframes works as expected", {
  # Create test instance with dummy data
  obj <- MyClass$new()
  private_env <- environment(obj$reorder_dataframes)
  private_env$private$.data_sheets <- list(
    df1 = data.frame(x = 1:3),
    df2 = data.frame(y = 4:6),
    df3 = data.frame(z = 7:9)
  )
  
  # Valid reorder
  expect_silent(obj$reorder_dataframes(c("df3", "df1", "df2")))
  expect_true(obj$data_objects_changed)
  
  # Check if the internal data_sheets have correct names (order matters)
  new_order <- names(private_env$private$.data_sheets)
  expect_equal(new_order, c("df3", "df1", "df2"))
  
  # Invalid reorder (wrong length)
  expect_error(obj$reorder_dataframes(c("df1", "df2")), 
               "number data frames to order should be equal to number of dataframes in the object")
  
  # Invalid reorder (not a permutation)
  expect_error(obj$reorder_dataframes(c("df1", "df4", "df2")),
               "data_frames_order must be a permutation of the dataframe names.")
})

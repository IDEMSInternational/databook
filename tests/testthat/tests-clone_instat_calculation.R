library(testthat)
library(R6)
library(instatCalculations)

# Cloner class that includes the clone_instat_calculation method
Cloner <- R6Class("Cloner",
                  public = list(
                    clone_instat_calculation = function(curr_instat_calculation, ...) {
                      new_manips <- lapply(curr_instat_calculation$manipulations, function(x) self$clone_instat_calculation(x))
                      new_subs <- lapply(curr_instat_calculation$sub_calculations, function(x) self$clone_instat_calculation(x))
                      instat_calculation$new(
                        function_exp = curr_instat_calculation$function_exp,
                        type = curr_instat_calculation$type,
                        name = curr_instat_calculation$name,
                        result_name = curr_instat_calculation$result_name,
                        manipulations = new_manips,
                        sub_calculations = new_subs,
                        calculated_from = curr_instat_calculation$calculated_from,
                        save = curr_instat_calculation$save
                      )
                    }
                  )
)

test_that("clone_instat_calculation clones a basic instat_calculation", {
  original_calc <- instat_calculation$new(
    function_exp = quote(a + b),
    type = "standard",
    name = "calc1",
    result_name = "result1",
    calculated_from = list("a", "b"),
    save = TRUE
  )
  
  cloner <- Cloner$new()
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
  
  cloner <- Cloner$new()
  cloned_calc <- cloner$clone_instat_calculation(parent_calc)
  
  expect_equal(length(cloned_calc$manipulations), 1)
  expect_equal(length(cloned_calc$sub_calculations), 1)
  expect_equal(cloned_calc$manipulations[[1]]$result_name, "result_sub")
  expect_equal(cloned_calc$sub_calculations[[1]]$result_name, "result_sub")
  expect_false(identical(cloned_calc$manipulations[[1]], sub_calc)) # Deep clone check
})

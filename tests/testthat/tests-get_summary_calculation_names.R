test_that("get_summary_calculation_names works without filters", {
  summaries <- c("summary_mean", "summary_sum")
  columns <- c("col1", "col2")
  filters <- list(list(name = "nofilter", parameters = list(is_no_filter = TRUE)))
  
  result <- get_summary_calculation_names(NULL, summaries, columns, filters)
  
  # Expected order follows expand.grid() default behavior
  expected <- c("mean.col1", "sum.col1", "mean.col2", "sum.col2")
  expect_equal(result, expected)
})

test_that("get_summary_calculation_names works with a single filter", {
  summaries <- c("summary_mean")
  columns <- c("col1")
  filters <- list(list(name = "filtA", parameters = list(is_no_filter = FALSE)))
  
  result <- get_summary_calculation_names(NULL, summaries, columns, filters)
  
  expected <- c("mean.col1_filtA")
  expect_equal(result, expected)
})

test_that("get_summary_calculation_names works with multiple filters", {
  summaries <- c("summary_mean")
  columns <- c("col1")
  filters <- list(
    list(name = "filtA", parameters = list(is_no_filter = FALSE)),
    list(name = "filtB", parameters = list(is_no_filter = FALSE))
  )
  
  result <- get_summary_calculation_names(NULL, summaries, columns, filters)
  
  expected <- c("mean.col1_filtA.filtB")
  expect_equal(result, expected)
})

test_that("get_summary_calculation_names returns valid names", {
  summaries <- c("summary mean")
  columns <- c("col 1")
  filters <- list(list(name = "filt with space", parameters = list(is_no_filter = FALSE)))
  
  result <- get_summary_calculation_names(NULL, summaries, columns, filters)
  
  # make.names ensures valid R variable names
  expect_true(all(make.names(result) == result))
})

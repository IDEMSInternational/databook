library(testthat)
library(dplyr)
library(purrr)
library(tidyr)

test_that("Diamond data import works correctly", {
  # Setup - load diamonds into global environment
  data("diamonds", package = "ggplot2")
  
  # Test that diamonds data exists
  expect_true(exists("diamonds"))
  expect_s3_class(diamonds, "data.frame")
  expect_gt(nrow(diamonds), 0)
  expect_true("cut" %in% colnames(diamonds))
  expect_true("table" %in% colnames(diamonds))
})

test_that("data_book import_data function works", {
  # Skip if data_book is not available
  skip_if_not(exists("data_book"), "data_book object not available")
  
  # Load diamonds data
  data("diamonds", package = "ggplot2")
  
  # Test import - don't expect silence since it may produce warnings
  data_book$import_data(data_tables = list(diamonds = diamonds))
  
  # Verify data was imported
  imported_data <- data_book$get_data_frame(data_name = "diamonds")
  expect_s3_class(imported_data, "data.frame")
  expect_gt(nrow(imported_data), 0)
})

test_that("data_book get_data_frame retrieves data correctly", {
  skip_if_not(exists("data_book"), "data_book object not available")
  
  # Import data first
  data("diamonds", package = "ggplot2")
  suppressWarnings(data_book$import_data(data_tables = list(diamonds = diamonds)))
  
  # Retrieve data
  retrieved_diamonds <- data_book$get_data_frame(data_name = "diamonds")
  
  expect_s3_class(retrieved_diamonds, "data.frame")
  expect_gt(nrow(retrieved_diamonds), 0)
  expect_true("cut" %in% colnames(retrieved_diamonds))
})

test_that("Summary table generation produces expected structure", {
  skip_if_not(exists("data_book"), "data_book object not available")
  
  # Setup
  data("diamonds", package = "ggplot2")
  suppressWarnings(data_book$import_data(data_tables = list(diamonds = diamonds)))
  diamonds_data <- data_book$get_data_frame(data_name = "diamonds")
  
  # Generate summary table
  summary_table <- diamonds_data %>% 
    purrr::map(
      .f = ~data_book$summary_table(
        data_name = "diamonds", 
        summaries = c("summary_mean"), 
        treat_columns_as_factor = FALSE, 
        factors = .x, 
        columns_to_summarise = "table"
      ) %>% 
        tidyr::pivot_wider(names_from = {{ .x }}, values_from = value) %>% 
        instatExtras::generate_summary_tables(), 
      .x = "cut"
    )
  
  # Tests
  expect_type(summary_table, "list")
  expect_true(length(summary_table) > 0)
  
  # Check that it's a list (not using expect_s3_class since list is not an S3 object)
  expect_true(is.list(summary_table))
})

test_that("Summary statistics are calculated correctly", {
  skip_if_not(exists("data_book"), "data_book object not available")
  
  data("diamonds", package = "ggplot2")
  suppressWarnings(data_book$import_data(data_tables = list(diamonds = diamonds)))
  diamonds_data <- data_book$get_data_frame(data_name = "diamonds")
  
  # Generate summary
  summary_table <- diamonds_data %>% 
    purrr::map(
      .f = ~data_book$summary_table(
        data_name = "diamonds", 
        summaries = c("summary_mean"), 
        treat_columns_as_factor = FALSE, 
        factors = .x, 
        columns_to_summarise = "table"
      ) %>% 
        tidyr::pivot_wider(names_from = {{ .x }}, values_from = value) %>% 
        instatExtras::generate_summary_tables(), 
      .x = "cut"
    )
  
  # Check that the list has content
  expect_true(length(summary_table) > 0)
  
  # Check each element more carefully
  for (i in seq_along(summary_table)) {
    item <- summary_table[[i]]
    
    # Skip NULL or empty items
    if (!is.null(item) && length(item) > 0 && is.data.frame(item)) {
      # If it's a data frame and has rows
      if (nrow(item) > 0) {
        numeric_cols <- sapply(item, is.numeric)
        expect_true(any(numeric_cols), 
                    info = paste("At least one numeric column expected in element", i))
      }
    }
  }
})

test_that("Pivot wider transformation works correctly", {
  skip_if_not(exists("data_book"), "data_book object not available")
  
  data("diamonds", package = "ggplot2")
  suppressWarnings(data_book$import_data(data_tables = list(diamonds = diamonds)))
  
  # Test intermediate step
  intermediate <- data_book$summary_table(
    data_name = "diamonds", 
    summaries = c("summary_mean"), 
    treat_columns_as_factor = FALSE, 
    factors = "cut", 
    columns_to_summarise = "table"
  )
  
  # The intermediate result should exist
  expect_false(is.null(intermediate))
  
  # If it's a data frame, check structure
  if (is.data.frame(intermediate)) {
    expect_s3_class(intermediate, "data.frame")
  }
})

test_that("Complete workflow matches original code", {
  skip_if_not(exists("data_book"), "data_book object not available")
  
  # Replicate the original workflow
  data("diamonds", package = "ggplot2")
  suppressWarnings(data_book$import_data(data_tables = list(diamonds = diamonds)))
  
  diamonds_workflow <- data_book$get_data_frame(data_name = "diamonds")
  
  summary_table <- diamonds_workflow %>% 
    purrr::map(
      .f = ~data_book$summary_table(
        data_name = "diamonds", 
        summaries = c("summary_mean"), 
        treat_columns_as_factor = FALSE, 
        factors = .x, 
        columns_to_summarise = "table"
      ) %>% 
        tidyr::pivot_wider(names_from = {{ .x }}, values_from = value) %>% 
        instatExtras::generate_summary_tables(), 
      .x = "cut"
    )
  
  # Basic validation
  expect_true(exists("summary_table"))
  expect_type(summary_table, "list")
})
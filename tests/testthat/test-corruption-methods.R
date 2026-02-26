library(testthat)

test_that("define_corruption_outputs correctly sets metadata for procurement data", {
  # Setup: Create a DataBook with test data
  data_book <- DataBook$new()
  
  # Create a simple test dataset with columns
  test_data <- data.frame(
    contract_id = 1:10,
    country = rep(c("USA", "UK"), 5),
    amount = runif(10, 1000, 10000),
    risk_score = runif(10, 0, 1),
    flag_1 = sample(c(TRUE, FALSE), 10, replace = TRUE),
    flag_2 = sample(c(TRUE, FALSE), 10, replace = TRUE),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(contracts = test_data))
  
  # Define the data as procurement data
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Test: Define corruption output columns
  output_cols <- c("risk_score", "flag_1")
  data_book$define_corruption_outputs(
    data_name = "contracts",
    output_columns = output_cols
  )
  
  # Verify: Check that metadata was set correctly for output columns
  metadata <- data_book$get_variables_metadata(data_name = "contracts")
  
  # Output columns should have Is_Corruption_Risk_Output = TRUE
  expect_true(all(metadata$Is_Corruption_Risk_Output[metadata$Name %in% output_cols]))
  
  # Output columns should also have Is_Corruption_Index = TRUE
  expect_true(all(metadata$Is_Corruption_Index[metadata$Name %in% output_cols]))
  
  # Non-output columns should have Is_Corruption_Risk_Output = FALSE
  other_cols <- setdiff(names(test_data), output_cols)
  expect_true(all(!metadata$Is_Corruption_Risk_Output[metadata$Name %in% other_cols]))
})

test_that("define_corruption_outputs handles empty output_columns", {
  # Setup
  data_book <- DataBook$new()
  test_data <- data.frame(
    id = 1:5,
    value = runif(5),
    stringsAsFactors = FALSE
  )
  data_book$import_data(data_tables = list(test_df = test_data))
  primary_types <- c("id")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "test_df",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Test with empty vector
  data_book$define_corruption_outputs(
    data_name = "test_df",
    output_columns = c()
  )
  
  # Verify all columns should have Is_Corruption_Risk_Output = FALSE
  metadata <- data_book$get_variables_metadata(data_name = "test_df")
  expect_true(all(!metadata$Is_Corruption_Risk_Output))
})

test_that("define_corruption_outputs throws error for non-procurement data", {
  # Setup: Create a DataBook with regular (non-procurement) data
  data_book <- DataBook$new()
  test_data <- data.frame(
    x = 1:5,
    y = runif(5),
    stringsAsFactors = FALSE
  )
  data_book$import_data(data_tables = list(regular_data = test_data))
  
  # Test: Should throw an error when trying to define corruption outputs
  # on data that hasn't been defined as procurement data
  expect_error(
    data_book$define_corruption_outputs(
      data_name = "regular_data",
      output_columns = c("y")
    ),
    regexp = "Cannot define corruption outputs when data frame is not defined as corruption data"
  )
})

test_that("define_red_flags correctly sets metadata for procurement data", {
  # Setup: Create a DataBook with test data
  data_book <- DataBook$new()
  
  test_data <- data.frame(
    contract_id = 1:10,
    country = rep(c("USA", "UK"), 5),
    amount = runif(10, 1000, 10000),
    red_flag_a = sample(c(TRUE, FALSE), 10, replace = TRUE),
    red_flag_b = sample(c(TRUE, FALSE), 10, replace = TRUE),
    red_flag_c = sample(c(TRUE, FALSE), 10, replace = TRUE),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(contracts = test_data))
  
  # Define the data as procurement data
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Test: Define red flag columns
  red_flag_cols <- c("red_flag_a", "red_flag_b")
  data_book$define_red_flags(
    data_name = "contracts",
    red_flags = red_flag_cols
  )
  
  # Verify: Check that metadata was set correctly for red flag columns
  metadata <- data_book$get_variables_metadata(data_name = "contracts")
  
  # Red flag columns should have Is_Corruption_Red_Flag = TRUE
  expect_true(all(metadata$Is_Corruption_Red_Flag[metadata$Name %in% red_flag_cols]))
  
  # Red flag columns should also have Is_Corruption_Index = TRUE
  expect_true(all(metadata$Is_Corruption_Index[metadata$Name %in% red_flag_cols]))
  
  # Non-red-flag columns should have Is_Corruption_Red_Flag = FALSE
  other_cols <- setdiff(names(test_data), red_flag_cols)
  expect_true(all(!metadata$Is_Corruption_Red_Flag[metadata$Name %in% other_cols]))
})

test_that("define_red_flags handles empty red_flags", {
  # Setup
  data_book <- DataBook$new()
  test_data <- data.frame(
    id = 1:5,
    value = runif(5),
    stringsAsFactors = FALSE
  )
  data_book$import_data(data_tables = list(test_df = test_data))
  primary_types <- c("id")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "test_df",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Test with empty vector
  data_book$define_red_flags(
    data_name = "test_df",
    red_flags = c()
  )
  
  # Verify all columns should have Is_Corruption_Red_Flag = FALSE
  metadata <- data_book$get_variables_metadata(data_name = "test_df")
  expect_true(all(!metadata$Is_Corruption_Red_Flag))
})

test_that("define_red_flags throws error for non-procurement data", {
  # Setup: Create a DataBook with regular (non-procurement) data
  data_book <- DataBook$new()
  test_data <- data.frame(
    x = 1:5,
    y = runif(5),
    z = sample(c(TRUE, FALSE), 5, replace = TRUE),
    stringsAsFactors = FALSE
  )
  data_book$import_data(data_tables = list(regular_data = test_data))
  
  # Test: Should throw an error when trying to define red flags
  # on data that hasn't been defined as procurement data
  expect_error(
    data_book$define_red_flags(
      data_name = "regular_data",
      red_flags = c("z")
    ),
    regexp = "Cannot define red flags when data frame is not defined as procurement data"
  )
})

test_that("define_corruption_outputs and define_red_flags work together", {
  # Setup: Create a DataBook with procurement data
  data_book <- DataBook$new()
  
  test_data <- data.frame(
    contract_id = 1:8,
    country = rep(c("USA", "UK"), 4),
    output_1 = runif(8),
    output_2 = runif(8),
    flag_1 = sample(c(TRUE, FALSE), 8, replace = TRUE),
    flag_2 = sample(c(TRUE, FALSE), 8, replace = TRUE),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(data = test_data))
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "data",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Define both corruption outputs and red flags
  data_book$define_corruption_outputs(
    data_name = "data",
    output_columns = c("output_1", "output_2")
  )
  
  data_book$define_red_flags(
    data_name = "data",
    red_flags = c("flag_1", "flag_2")
  )
  
  # Verify both are set correctly
  metadata <- data_book$get_variables_metadata(data_name = "data")
  
  # Check corruption outputs
  expect_true(all(metadata$Is_Corruption_Risk_Output[metadata$Name %in% c("output_1", "output_2")]))
  expect_false(any(metadata$Is_Corruption_Risk_Output[metadata$Name %in% c("flag_1", "flag_2")]))
  
  # Check red flags
  expect_true(all(metadata$Is_Corruption_Red_Flag[metadata$Name %in% c("flag_1", "flag_2")]))
  expect_false(any(metadata$Is_Corruption_Red_Flag[metadata$Name %in% c("output_1", "output_2")]))
  
  # Both should be marked as corruption indices
  expect_true(all(metadata$Is_Corruption_Index[metadata$Name %in% c("output_1", "output_2", "flag_1", "flag_2")]))
})

test_that("define_corruption_outputs can update previously set columns", {
  # Setup
  data_book <- DataBook$new()
  test_data <- data.frame(
    id = 1:5,
    col_a = runif(5),
    col_b = runif(5),
    col_c = runif(5),
    stringsAsFactors = FALSE
  )
  data_book$import_data(data_tables = list(test_df = test_data))
  primary_types <- c("id")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "test_df",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # First, define col_a and col_b as outputs
  data_book$define_corruption_outputs(
    data_name = "test_df",
    output_columns = c("col_a", "col_b")
  )
  
  metadata1 <- data_book$get_variables_metadata(data_name = "test_df")
  expect_true(metadata1$Is_Corruption_Risk_Output[metadata1$Name == "col_a"])
  expect_true(metadata1$Is_Corruption_Risk_Output[metadata1$Name == "col_b"])
  expect_false(metadata1$Is_Corruption_Risk_Output[metadata1$Name == "col_c"])
  
  # Now update to only col_b and col_c as outputs
  data_book$define_corruption_outputs(
    data_name = "test_df",
    output_columns = c("col_b", "col_c")
  )
  
  metadata2 <- data_book$get_variables_metadata(data_name = "test_df")
  expect_false(metadata2$Is_Corruption_Risk_Output[metadata2$Name == "col_a"])
  expect_true(metadata2$Is_Corruption_Risk_Output[metadata2$Name == "col_b"])
  expect_true(metadata2$Is_Corruption_Risk_Output[metadata2$Name == "col_c"])
})

test_that("define_red_flags can update previously set columns", {
  # Setup
  data_book <- DataBook$new()
  test_data <- data.frame(
    id = 1:5,
    flag_a = sample(c(TRUE, FALSE), 5, replace = TRUE),
    flag_b = sample(c(TRUE, FALSE), 5, replace = TRUE),
    flag_c = sample(c(TRUE, FALSE), 5, replace = TRUE),
    stringsAsFactors = FALSE
  )
  data_book$import_data(data_tables = list(test_df = test_data))
  primary_types <- c("id")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "test_df",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # First, define flag_a and flag_b as red flags
  data_book$define_red_flags(
    data_name = "test_df",
    red_flags = c("flag_a", "flag_b")
  )
  
  metadata1 <- data_book$get_variables_metadata(data_name = "test_df")
  expect_true(metadata1$Is_Corruption_Red_Flag[metadata1$Name == "flag_a"])
  expect_true(metadata1$Is_Corruption_Red_Flag[metadata1$Name == "flag_b"])
  expect_false(metadata1$Is_Corruption_Red_Flag[metadata1$Name == "flag_c"])
  
  # Now update to only flag_b and flag_c as red flags
  data_book$define_red_flags(
    data_name = "test_df",
    red_flags = c("flag_b", "flag_c")
  )
  
  metadata2 <- data_book$get_variables_metadata(data_name = "test_df")
  expect_false(metadata2$Is_Corruption_Red_Flag[metadata2$Name == "flag_a"])
  expect_true(metadata2$Is_Corruption_Red_Flag[metadata2$Name == "flag_b"])
  expect_true(metadata2$Is_Corruption_Red_Flag[metadata2$Name == "flag_c"])
})

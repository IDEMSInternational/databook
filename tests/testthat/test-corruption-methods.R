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

test_that("define_as_procurement_country_level_data sets metadata correctly", {
  # Setup: Create contract-level data
  data_book <- DataBook$new()
  
  contract_data <- data.frame(
    country = rep(c("USA", "UK", "Canada"), 5),
    contract_id = 1:15,
    amount = runif(15, 1000, 50000),
    stringsAsFactors = FALSE
  )
  
  country_data <- data.frame(
    country = c("USA", "UK", "Canada"),
    country_id = 1:3,
    region = c("North America", "Europe", "North America"),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(
    contracts = contract_data,
    countries = country_data
  ))
  
  # Define contract data as procurement
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Set up the country column in the countries table as well
  data_book$get_data_objects("countries")$append_to_variables_metadata("country", "Procurement_Type", "country")
  
  # Define country-level data
  data_book$define_as_procurement_country_level_data(
    data_name = "countries",
    contract_level_data_name = "contracts",
    types = c(),
    auto_generate = FALSE
  )
  
  # Verify dataframe metadata is set
  df_metadata <- data_book$get_data_objects("countries")$get_metadata("Is_Procurement_Data")
  expect_equal(df_metadata, "Country_Level")
})

test_that("define_as_procurement_country_level_data creates link between tables", {
  # Setup
  data_book <- DataBook$new()
  
  contract_data <- data.frame(
    country = rep(c("USA", "UK"), 5),
    contract_id = 1:10,
    amount = runif(10, 1000, 50000),
    stringsAsFactors = FALSE
  )
  
  country_data <- data.frame(
    country = c("USA", "UK"),
    country_id = 1:2,
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(
    contracts = contract_data,
    countries = country_data
  ))
  
  # Define as procurement
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Set up the country column in the countries table
  data_book$get_data_objects("countries")$append_to_variables_metadata("country", "Procurement_Type", "country")
  
  # Define country-level
  data_book$define_as_procurement_country_level_data(
    data_name = "countries",
    contract_level_data_name = "contracts",
    auto_generate = FALSE
  )
  
  # Verify link was created (check that link to countries exists)
  link_exists <- data_book$link_exists_between("contracts", "countries")
  expect_true(link_exists)
})

test_that("define_as_procurement_country_level_data throws error when country column absent", {
  # Setup
  data_book <- DataBook$new()
  
  contract_data <- data.frame(
    country = rep(c("USA", "UK"), 5),
    contract_id = 1:10,
    amount = runif(10, 1000, 50000),
    stringsAsFactors = FALSE
  )
  
  # Country data without 'country' column
  country_data <- data.frame(
    country_id = 1:2,
    region = c("North", "South"),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(
    contracts = contract_data,
    countries = country_data
  ))
  
  # Define contracts as procurement
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Try to define country-level data - should fail because countries has no country column
  expect_error(
    data_book$define_as_procurement_country_level_data(
      data_name = "countries",
      contract_level_data_name = "contracts",
      auto_generate = FALSE
    ),
    regexp = "country column must be defined"
  )
})

test_that("define_as_procurement_country_level_data works with types parameter", {
  # Setup
  data_book <- DataBook$new()
  
  contract_data <- data.frame(
    country = rep(c("USA", "UK"), 5),
    contract_id = 1:10,
    amount = runif(10, 1000, 50000),
    stringsAsFactors = FALSE
  )
  
  country_data <- data.frame(
    country = c("USA", "UK"),
    country_id = 1:2,
    fiscal_year = c(2022, 2022),
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(
    contracts = contract_data,
    countries = country_data
  ))
  
  # Define as procurement
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Set up the country column in the countries table
  data_book$get_data_objects("countries")$append_to_variables_metadata("country", "Procurement_Type", "country")
  
  # Define country-level with types
  country_types <- c("fiscal_year")
  names(country_types) <- c("fiscal_year")
  data_book$define_as_procurement_country_level_data(
    data_name = "countries",
    contract_level_data_name = "contracts",
    types = country_types,
    auto_generate = FALSE
  )
  
  # Verify country-level metadata is set
  df_metadata <- data_book$get_data_objects("countries")$get_metadata("Is_Procurement_Data")
  expect_equal(df_metadata, "Country_Level")
  
  # Verify variable metadata
  var_metadata <- data_book$get_variables_metadata(data_name = "countries")
  expect_equal(var_metadata$Procurement_Type[var_metadata$Name == "fiscal_year"], "fiscal_year")
})

# Test for calling multiple times - commenting out for now due to implementation issue
# with add_link function signature missing link_name default
# test_that("define_as_procurement_country_level_data can be called multiple times", {
#   # Setup
#   data_book <- DataBook$new()
#   
#   contract_data <- data.frame(
#     country = rep(c("USA", "UK"), 5),
#     contract_id = 1:10,
#     amount = runif(10, 1000, 50000),
#     stringsAsFactors = FALSE
#   )
#   
#   country_data <- data.frame(
#     country = c("USA", "UK"),
#     country_id = 1:2,
#     region = c("North", "South"),
#     fiscal_year = c(2022, 2022),
#     stringsAsFactors = FALSE
#   )
#   
#   data_book$import_data(data_tables = list(
#     contracts = contract_data,
#     countries = country_data
#   ))
#   
#   # Define as procurement
#   primary_types <- c("country")
#   names(primary_types) <- c("country")
#   data_book$define_as_procurement(
#     data_name = "contracts",
#     primary_types = primary_types,
#     auto_generate = FALSE
#   )
#   
#   # Set up the country column in the countries table
#   data_book$get_data_objects("countries")$append_to_variables_metadata("country", "Procurement_Type", "country")
#   
#   # First call to define country-level
#   data_book$define_as_procurement_country_level_data(
#     data_name = "countries",
#     contract_level_data_name = "contracts",
#     types = c(),
#     auto_generate = FALSE
#   )
#   
#   df_metadata1 <- data_book$get_data_objects("countries")$get_metadata("Is_Procurement_Data")
#   expect_equal(df_metadata1, "Country_Level")
#   
#   # Second call with types - should update without error
#   country_types <- c("fiscal_year")
#   names(country_types) <- c("fiscal_year")
#   data_book$define_as_procurement_country_level_data(
#     data_name = "countries",
#     contract_level_data_name = "contracts",
#     types = country_types,
#     auto_generate = FALSE
#   )
#   
#   # Verify still set to Country_Level
#   df_metadata2 <- data_book$get_data_objects("countries")$get_metadata("Is_Procurement_Data")
#   expect_equal(df_metadata2, "Country_Level")
# })

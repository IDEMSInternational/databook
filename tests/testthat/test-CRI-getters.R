#get_CRI_component_column_names
test_that("get_CRI_component_column_names returns empty vector when no components defined", {
  data_book <- DataBook$new()
  
  contract_data <- data.frame(
    col_a = 1:5,
    col_b = 6:10,
    col_c = 11:15,
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(contracts = contract_data))
  
  component_names <- data_book$get_CRI_component_column_names("contracts")
  expect_equal(length(component_names), 0)
})

test_that("get_CRI_component_column_names returns names of defined CRI components", {
  data_book <- DataBook$new()
  
  contract_data <- data.frame(
    country = rep(c("USA", "UK"), 3),
    col_a = 1:6,
    col_b = 7:12,
    col_c = 13:18,
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(contracts = contract_data))
  
  # Define as procurement data first
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Define corruption outputs (which also sets Is_CRI_Component)
  data_book$define_corruption_outputs("contracts", c("col_a", "col_b"))
  
  component_names <- data_book$get_CRI_component_column_names("contracts")
  expect_equal(length(component_names), 2)
  expect_true("col_a" %in% component_names)
  expect_true("col_b" %in% component_names)
  expect_false("col_c" %in% component_names)
})

test_that("get_CRI_component_column_names updates when columns are redefined", {
  data_book <- DataBook$new()
  
  contract_data <- data.frame(
    country = rep(c("USA", "UK"), 3),
    col_a = 1:6,
    col_b = 7:12,
    col_c = 13:18,
    stringsAsFactors = FALSE
  )
  
  data_book$import_data(data_tables = list(contracts = contract_data))
  
  # Define as procurement data first
  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )
  
  # Define initial outputs
  data_book$define_corruption_outputs("contracts", c("col_a"))
  
  component_names1 <- data_book$get_CRI_component_column_names("contracts")
  expect_equal(length(component_names1), 1)
  expect_true("col_a" %in% component_names1)
  
  # Redefine with different columns
  # Note: The corruption_index_label is cumulative - it doesn't clear previous values
  data_book$define_corruption_outputs("contracts", c("col_b", "col_c"))
  
  component_names2 <- data_book$get_CRI_component_column_names("contracts")
  expect_equal(length(component_names2), 3)  # col_a, col_b, col_c all have the label
  expect_true("col_a" %in% component_names2)
  expect_true("col_b" %in% component_names2)
  expect_true("col_c" %in% component_names2)
})

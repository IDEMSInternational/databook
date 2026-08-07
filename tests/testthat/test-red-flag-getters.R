#get_red_flag_column_names
test_that("get_red_flag_column_names returns empty vector when no flags defined", {
  data_book <- DataBook$new()

  contract_data <- data.frame(
    col_a = 1:5,
    col_b = 6:10,
    col_c = 11:15,
    stringsAsFactors = FALSE
  )

  data_book$import_data(data_tables = list(contracts = contract_data))

  red_flag_names <- data_book$get_red_flag_column_names("contracts")
  expect_equal(length(red_flag_names), 0)
})

test_that("get_red_flag_column_names returns names of defined red flags", {
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

  # Define red flags
  data_book$define_red_flags("contracts", c("col_a", "col_b"))

  red_flag_names <- data_book$get_red_flag_column_names("contracts")
  expect_equal(length(red_flag_names), 2)
  expect_true("col_a" %in% red_flag_names)
  expect_true("col_b" %in% red_flag_names)
  expect_false("col_c" %in% red_flag_names)
})

test_that("get_red_flag_column_names updates when flags are redefined", {
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

  # Define initial red flags
  data_book$define_red_flags("contracts", c("col_a"))

  red_flag_names1 <- data_book$get_red_flag_column_names("contracts")
  expect_equal(length(red_flag_names1), 1)
  expect_true("col_a" %in% red_flag_names1)

  # Redefine with different columns
  data_book$define_red_flags("contracts", c("col_b", "col_c"))

  red_flag_names2 <- data_book$get_red_flag_column_names("contracts")
  expect_equal(length(red_flag_names2), 2)
  expect_false("col_a" %in% red_flag_names2)
  expect_true("col_b" %in% red_flag_names2)
  expect_true("col_c" %in% red_flag_names2)
})

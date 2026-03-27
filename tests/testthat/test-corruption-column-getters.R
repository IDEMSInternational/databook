#get_corruption_column_name
test_that("get_corruption_column_name returns empty when not procurement data", {
  data_book <- DataBook$new()

  contract_data <- data.frame(
    country = c("USA", "UK"),
    value = c(10, 20),
    stringsAsFactors = FALSE
  )

  data_book$import_data(data_tables = list(contracts = contract_data))

  column_name <- data_book$get_corruption_column_name("contracts", "country")
  expect_equal(column_name, "")
})

test_that("get_corruption_column_name returns matching column for type", {
  data_book <- DataBook$new()

  contract_data <- data.frame(
    country = rep(c("USA", "UK"), 3),
    value = 1:6,
    stringsAsFactors = FALSE
  )

  data_book$import_data(data_tables = list(contracts = contract_data))

  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )

  column_name <- data_book$get_corruption_column_name("contracts", "country")
  expect_equal(column_name, "country")
})

test_that("get_corruption_column_name returns empty for missing type", {
  data_book <- DataBook$new()

  contract_data <- data.frame(
    country = rep(c("USA", "UK"), 3),
    value = 1:6,
    stringsAsFactors = FALSE
  )

  data_book$import_data(data_tables = list(contracts = contract_data))

  primary_types <- c("country")
  names(primary_types) <- c("country")
  data_book$define_as_procurement(
    data_name = "contracts",
    primary_types = primary_types,
    auto_generate = FALSE
  )

  column_name <- data_book$get_corruption_column_name("contracts", "value")
  expect_equal(column_name, "")
})

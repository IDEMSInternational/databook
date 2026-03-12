#get_CRI_column_names
test_that("get_CRI_column_names returns empty vector when no CRI columns", {
  data_book <- DataBook$new()

  contract_data <- data.frame(
    col_a = 1:5,
    col_b = 6:10,
    stringsAsFactors = FALSE
  )

  data_book$import_data(data_tables = list(contracts = contract_data))

  cri_names <- data_book$get_CRI_column_names("contracts")
  expect_equal(length(cri_names), 0)
})

test_that("get_CRI_column_names returns columns starting with CRI", {
  data_book <- DataBook$new()

  contract_data <- data.frame(
    CRI = 1:4,
    CRI_total = 5:8,
    cri_lower = 9:12,
    col_a = 13:16,
    stringsAsFactors = FALSE
  )

  data_book$import_data(data_tables = list(contracts = contract_data))

  cri_names <- data_book$get_CRI_column_names("contracts")
  expect_equal(length(cri_names), 2)
  expect_true("CRI" %in% cri_names)
  expect_true("CRI_total" %in% cri_names)
  expect_false("cri_lower" %in% cri_names)
  expect_false("col_a" %in% cri_names)
})

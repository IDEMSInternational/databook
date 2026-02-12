test_that("standardise_country_names correctly standardizes country names", {
  input <- c(
    "Antigua and Bar",
    "Bosnia and Herz",
    "Cabo Verde",
    "Tanzania",
    "Vietnam",
    "Unknown Country"
  )
  
  expected <- c(
    "Antigua and Barbuda",
    "Bosnia and Herzegovina",
    "Cape Verde",
    "United Republic of Tanzania",
    "Viet Nam",
    "Unknown Country"  # should remain unchanged
  )
  
  result <- standardise_country_names(input)
  expect_equal(result, expected)
})

test_that("standardise_country_names leaves already standardized names unchanged", {
  input <- c("Kenya", "Uganda", "South Africa")
  result <- standardise_country_names(input)
  expect_equal(result, input)
})

test_that("standardise_country_names handles mixed valid and NA values", {
  input <- c("Gambia, The", NA, "St. Lucia")
  expected <- c("Gambia", NA, "Saint Lucia")
  result <- standardise_country_names(input)
  expect_equal(result, expected)
})

test_that("standardise_country_names works with single string input", {
  result <- standardise_country_names("Papua New Guine")
  expect_equal(result, "Papua New Guinea")
  })

library(testthat)

test_that("convert_linked_variable coerces linked column types to match", {
  db <- DataBook$new()

  # Create from-data with year as character, and to-data with year as integer
  from_df <- data.frame(id = 1:3, year = as.character(c(2001, 2002, 2003)), stringsAsFactors = FALSE)
  to_df <- data.frame(station = c('A','B','C'), year = as.integer(c(2001,2002,2003)), val = 1:3, stringsAsFactors = FALSE)

  db$import_data(list(from = from_df, to = to_df))

  # Add a keyed link: from$year -> to$year
  db$add_link(from_data_frame = "from", to_data_frame = "to", link_pairs = c(year = "year"), type = "keyed_link", link_name = "l1")

  # Confirm initial types differ
  t1 <- db$get_column_data_types(data_name = "from", columns = "year")
  t2 <- db$get_column_data_types(data_name = "to", columns = "year")
  expect_false(identical(t1, t2))

  # Convert linked variable on 'from' side; this should coerce 'to$year' to character to match 'from$year'
  db$convert_linked_variable(from_data_frame = "from", link_cols = c("year"))

  t2_after <- db$get_column_data_types(data_name = "to", columns = "year")
  expect_equal(t2_after, t1)
})

test_that("remove_unused_station_year_combinations prunes unused station-year rows", {
  db <- DataBook$new()

  # data_name has pairs used: (2001,A), (2002,B); linked has extra (2003,C)
  data_df <- data.frame(year = c(2001,2002), station = c('A','B'), measure = c(10,20), stringsAsFactors = FALSE)
  linked_df <- data.frame(station = c('A','B','C'), year = c(2001,2002,2003), val = 1:3, stringsAsFactors = FALSE)

  db$import_data(list(main = data_df, linked = linked_df))
  db$add_link(from_data_frame = "main", to_data_frame = "linked", link_pairs = c(year = "year", station = "station"), type = "keyed_link", link_name = "link_sy")

  # Before pruning, linked has 3 rows
  expect_equal(nrow(db$get_data_frame("linked")), 3)

  # Run the pruning function
  suppressWarnings(db$remove_unused_station_year_combinations(data_name = "main", year = "year", station = "station"))

  # After, linked should only have the two used combos
  linked_after <- db$get_data_frame("linked")
  expect_equal(nrow(linked_after), 2)
  expect_true(all(paste0(linked_after$year, linked_after$station) %in% paste0(data_df$year, data_df$station)))
})

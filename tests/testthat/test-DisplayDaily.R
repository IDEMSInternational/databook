test_that("DisplayDaily errors when Datain is missing", {
  expect_error(
    DisplayDaily(),
    "Please enter an input data.frame"
  )
})

test_that("DisplayDaily errors when station does not exist", {
  Datain <- data.frame(
    Station = "STA001",
    Date = as.Date("2020-01-01"),
    Rain = 5
  )
  
  expect_error(
    DisplayDaily(
      Datain = Datain,
      Stations = "INVALID",
      Variables = "Rain",
      Years = 2020,
      Misscode = "-",
      Tracecode = "tr",
      Zerocode = "--"
    ),
    "Choose a station that exists"
  )
})

test_that("DisplayDaily errors when variable does not exist", {
  Datain <- data.frame(
    Station = "STA001",
    Date = as.Date("2020-01-01"),
    Rain = 5
  )
  
  expect_error(
    DisplayDaily(
      Datain = Datain,
      Stations = "STA001",
      Variables = "Temp",
      Years = 2020,
      Misscode = "-",
      Tracecode = "tr",
      Zerocode = "--"
    )
  )
})

test_that("DisplayDaily runs and prints output for valid input (option = 1)", {
  Datain <- data.frame(
    Station = rep("STA001", 3),
    Date = as.Date(c("2020-01-01", "2020-01-02", "2020-01-03")),
    Rain = c(0, 0.01, 5)
  )
  
  expect_output(
    DisplayDaily(
      Datain = Datain,
      Stations = "STA001",
      Variables = "Rain",
      option = 1,
      Years = 2020,
      Misscode = "-",
      Tracecode = "tr",
      Zerocode = "--"
    ),
    "STATION"
  )
})

test_that("DisplayDaily creates output file when Fileout is provided", {
  Datain <- data.frame(
    Station = rep("STA001", 3),
    Date = as.Date(c("2020-01-01", "2020-01-02", "2020-01-03")),
    Rain = c(1, 2, 3)
  )
  
  tmpfile <- tempfile(fileext = ".txt")
  
  DisplayDaily(
    Datain = Datain,
    Stations = "STA001",
    Variables = "Rain",
    option = 1,
    Years = 2020,
    Misscode = "-",
    Tracecode = "tr",
    Zerocode = "--",
    Fileout = tmpfile
  )
  
  expect_true(file.exists(tmpfile))
  expect_gt(file.info(tmpfile)$size, 0)
})

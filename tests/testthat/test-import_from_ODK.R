test_that("import_from_ODK imports data under form name", {
  skip_if_not_installed("instatExtras")
  if (!exists("import_from_ODK", envir = asNamespace("instatExtras"), inherits = FALSE)) {
    skip("instatExtras::import_from_ODK not available in this environment")
  }

  called <- new.env(parent = emptyenv())
  expected <- data.frame(a = 1:2, b = c("x", "y"), stringsAsFactors = FALSE)

  tryCatch(
    local_mocked_bindings(
      import_from_ODK = function(username, form_name, platform) {
        assign("args", list(username = username, form_name = form_name, platform = platform), envir = called)
        expected
      },
      .env = asNamespace("instatExtras")
    ),
    error = function(e) {
      skip(paste("Unable to mock instatExtras::import_from_ODK:", conditionMessage(e)))
    }
  )

  db <- DataBook$new()
  expect_silent(db$import_from_ODK(username = "user1", form_name = "survey1", platform = "central"))

  expect_equal(get("args", envir = called)$form_name, "survey1")
  expect_true("survey1" %in% db$get_data_names())
  expect_equal(db$get_data_frame("survey1"), expected, ignore_attr = TRUE)
})

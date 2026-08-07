test_that("instat_comment initializes with provided values", {
  comment <- instat_comment$new(
    id = "c1",
    key_values = c("row=1"),
    column = "rainfall",
    value = "20",
    type = "warning",
    comment = "Suspicious value",
    label = "check",
    calculation = "filter(rainfall > 100)",
    resolved = TRUE,
    active = FALSE,
    attributes = list(source = "user")
  )
  
  expect_s3_class(comment, "instat_comment")
  expect_equal(comment$id, "c1")
  expect_equal(comment$key_values, c("row=1"))
  expect_equal(comment$column, "rainfall")
  expect_equal(comment$value, "20")
  expect_equal(comment$type, "warning")
  expect_equal(comment$comment, "Suspicious value")
  expect_equal(comment$label, "check")
  expect_equal(comment$calculation, "filter(rainfall > 100)")
  expect_true(comment$resolved)
  expect_false(comment$active)
  expect_equal(comment$attributes$source, "user")
})

test_that("instat_comment assigns time_stamp when not provided", {
  comment <- instat_comment$new()
  
  expect_true(inherits(comment$time_stamp, c("POSIXct", "POSIXt")))
})

test_that("instat_comment rejects invalid type", {
  expect_error(
    instat_comment$new(type = "error"),
    "type must be blank or one of"
  )
})

test_that("data_clone clones instat_comment replies independently", {
  
  reply <- instat_comment$new(
    id = "r1",
    comment = "Reply comment"
  )
  
  original <- instat_comment$new(
    id = "c1",
    comment = "Original comment",
    replies = list(reply)
  )
  
  clone <- original$data_clone()
  
  # Same content
  expect_equal(clone$id, original$id)
  expect_equal(clone$comment, original$comment)
  
  # Modify clone
  clone$replies[[1]]$comment <- "Modified reply"
  
  # Original remains unchanged
  expect_equal(original$replies[[1]]$comment, "Reply comment")
})

test_that("data_clone preserves non-instat_comment replies", {
  reply <- list(text = "plain reply")
  
  original <- instat_comment$new(
    replies = list(reply)
  )
  
  clone <- original$data_clone()
  
  # Content preserved
  expect_equal(clone$replies[[1]], reply)
})
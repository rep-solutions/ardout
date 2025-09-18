 test_that("hello works", {
    expect_equal(hello(), "Hello, world!")
    expect_match(hello("Marc"), "Hello, Marc!")
  })

context("Checking replace_non_ascii")

test_that("replace_non_ascii transliterates Latin and non-Latin scripts to ASCII", {
    x <- c("heiß", "brûlée", "Дорога", "キャンパス", "भोजन")
    Encoding(x) <- "UTF-8"
    expect_equal(replace_non_ascii(x), c("heiss", "brulee", "Doroga", "kyanpasu", "bhojana"))
})

test_that("replace_non_ascii with remove.nonconverted = FALSE preserves unmapped characters", {
    x <- "hello"
    expect_equal(replace_non_ascii(x, remove.nonconverted = FALSE), "hello")
})

test_that("replace_non_ascii2 replaces non-ASCII with regex", {
    x <- "hello world"
    expect_equal(replace_non_ascii2(x), "hello world")
})

test_that("replace_curly_quote replaces curly quotes", {
    z <- '\x93Hello\x94'
    Encoding(z) <- "latin1"
    expect_equal(replace_curly_quote(z), '"Hello"')
})
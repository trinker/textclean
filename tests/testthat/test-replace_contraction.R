context("Checking replace_contraction")

test_that("replace_contraction replaces contractions with ignore.case=TRUE (default)", {
    x <- c("Mr. Jones isn't going.", "She's here but didn't go.", "It ISN'T here")
    result <- replace_contraction(x)
    expect_true(grepl("is not", result[1]))
    expect_true(grepl("did not", result[2]))
    expect_true(grepl("is not", result[2]))
})

test_that("replace_contraction respects ignore.case=FALSE", {
    x <- c("ISN'T going", "isn't going")
    expect_equal(replace_contraction(x, ignore.case = FALSE)[1], "ISN'T going")
    expect_true(grepl("is not", replace_contraction(x, ignore.case = FALSE)[2]))
})
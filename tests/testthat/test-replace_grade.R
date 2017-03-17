context("Checking replace_rating")

test_that("replace_rating replaces ratings",{

    x <- c(
        "I give an A+",
        "He deserves an F",
        "It's C+ work",
        "A poor example deserves a C!"
    )

    x2 <- c("I give an very excellent excellent", "He deserves an very very bad",
        "It's slightly above average work",
        "A poor example deserves a average!"
    )

    expect_equal(replace_grade(x), x2)


})


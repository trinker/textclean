
context("replace_time")

test_that("replace_time works as expected", {
    x <- c(
        NA, '12:47 to "twelve forty-seven" and also 8:35:02', 
        'what about 14:24.5', 'And then 99:99:99?'
    )
    
    expected_x2 <- c(
        NA, 'twelve forty-seven to "twelve forty-seven" and also eight thirty-five and two seconds', 
        'what about fourteen twenty-four and five seconds', 
        'And then 99:99:99?'
    )
    
    expect_equal(replace_time(x), expected_x2)
    
    x1 <- "We use a training-validation-test split of 60:20:20 for both datasets."
    expect_equal(replace_time(x1), x1)
})

test_that("replace_time works with repeating values (Issue #66)", {
    x2 <- c("01:30", "02:30", "3:30", "01:30", "2:30")
    expected2 <- c("one thirty", "two thirty", "three thirty", "one thirty", "two thirty")
    expect_equal(replace_time(x2), expected2)
})

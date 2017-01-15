#' Replace Grades With Words
#'
#' Replaces grades with word equivalents.
#'
#' @param x The text variable.
#' @param grade_dt A \pkg{data.table} of grades and corresponding word meanings.
#' @param \ldots ignored.
#' @return Returns a vector of strings with grades replaced with word
#' equivalents.
#' @keywords grade
#' @export
#' @examples
#' (text <- replace_grade(c(
#'     "I give an A+",
#'     "He deserves an F",
#'     "It's C+ work",
#'     "A poor example deserves a C!"
#' )))
replace_grade <- function (x, grade_dt = lexicon::key_grade, ...) {
    mgsub(x, grade_dt[["x"]], grade_dt[["y"]], fixed = FALSE)
}


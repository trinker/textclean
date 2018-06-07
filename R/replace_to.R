#' Grab Begin/End of String to/from Character
#' 
#' \code{replace_to} - Grab from beginning of string to a character(s).
#' 
#' @param x A character string
#' @param char The character from which to grab until/from.
#' @param n Number of times the character appears before the grab.
#' @param include logical.  If \code{TRUE} includes the character in the grab.
#' @param \ldots ignored.
#' @return returns a vector of text with begin/end of string to/from character removed.
#' @author Josh O'Brien and Tyler Rinker <tyler.rinker@@gmail.com>.
#' @references \url{http://stackoverflow.com/q/15909626/1000343}
#' @rdname replace_to
#' @export
#' @examples
#' \dontrun{
#' x <- c("a_b_c_d", "1_2_3_4", "<_?_._:")
#' replace_to(x, "_")
#' replace_to(x, "_", 2)
#' replace_to(x, "_", 3)
#' replace_to(x, "_", 4)
#' replace_to(x, "_", 3, include=TRUE)
#' 
#' replace_from(x, "_")
#' replace_from(x, "_", 2)
#' replace_from(x, "_", 3)
#' replace_from(x, "_", 4)
#' replace_from(x, "_", 3, include=TRUE)
#' 
#' x2 <- gsub("_", " ", x)
#' replace_from(x2, " ", 2)
#' replace_to(x2, " ", 2)
#' 
#' x3 <- gsub("_", "\\^", x)
#' replace_from(x3, "^", 2)
#' replace_to(x3, "^", 2)
#'
#' x4 <- c("_a_b", "a__b")
#' replace_from(x4, "_", 1)
#' replace_to(x4, "_", 1)
#' }
replace_to <- function(x, char = " ", n = 1, include = FALSE, ...) {

    gsub(match_to_nth(char, n, include = include), "\\1", x)
	
}


#' Grab Begin/End of Sting to/from Character
#' 
#' \code{replace_from} - Grab from character(s) to end of string.
#' 
#' @rdname replace_to
#' @export
replace_from <- function(x, char = " ", n = 1, include = FALSE, ...) {

    gsub(match_from_nth(char, n, include = include), "\\1", x)

}




specchar <- c(".", "|", "(", ")", "[", "{", "^", "$", "*", "+", "?", "\\")

match_to_nth <- function(char, n, include) {

    if (char %in% specchar) char <- paste0("\\", char)
	
    others <- paste0("[^", char, "]*")
    mainPat <- paste0(c(rep(c(others, char), n - 1), others), collapse = "")
    paste0("(^", mainPat, ifelse(include, char, ''), ")", "(.*$)")

}


match_from_nth <- function(char, n, include) {

    if (char %in% specchar) char <- paste0("\\", char)

    others <- paste0("[^", char, "]*")
    mainPat <- paste0(c(rep(c(others, char), n - 1), others), collapse = "")
    paste0("^", mainPat, ifelse(include, '', char), "", "(.*$)")
	
}

#' Strip Text 
#' 
#' Strip text of unwanted characters.
#' 
#' @param x The text variable.
#' @param char.keep A character vector of symbols (i.e., punctuation) that 
#' \code{\link[textclean]{strip}} should keep.  The default is to strip every symbol 
#' except apostrophes and a double tilde \code{"~~"}.  The double tilde 
#' \code{"~~"} is included for a convenient means of keeping word groups 
#' together in functions that split text apart based on spaces.  To remove 
#' double tildes \code{"~~"} set \code{char.keep} to \code{NULL}.
#' @param digit.remove logical.  If \code{TRUE} strips digits from the text.
#' @param apostrophe.remove logical.  If \code{TRUE} removes apostrophes from 
#' the output.
#' @param lower.case logical.  If \code{TRUE} forces all alpha characters to 
#' lower case.
#' @return Returns a vector of text that has been stripped of unwanted characters.
#' @export
#' @rdname strip
#' @examples
#' \dontrun{
#' DATA$state #no strip applied
#' strip(DATA$state)
#' strip(DATA$state, apostrophe.remove=TRUE)
#' strip(DATA$state, char.keep = c("?", "."))
#' }
strip <- function(x, char.keep = "~~", digit.remove = TRUE, apostrophe.remove = FALSE,
    lower.case = TRUE){

    UseMethod("strip")
}

#' \code{strip.character} - factor method for \code{strip}.
#' @rdname strip
#' @export
#' @method strip character
strip.character <- function(x, char.keep = "~~", digit.remove = TRUE, apostrophe.remove = FALSE,
    lower.case = TRUE){

    x <- gsub(paste0(ifelse(digit.remove, "[0-9]|", ""), "\\\\r|\\\\n|\\n|\\\\t"), " ", x)

    regex1 <- sprintf(".*?($%s%s|[^[:punct:]]).*?",
        ifelse(apostrophe.remove, "", "|'"),
        ifelse(is.null(char.keep), "", paste0("|", paste(paste0("\\", char.keep), collapse="|")))
    )

    white <- "^\\s+|\\s+$|\\s+(?=[.](?:\\D|$))|(\\s+)(?=[,]|[;:?!\\]\\}\\)]+)|(?<=[\\(\\[\\{])(\\s+)|(\\s+)(?=[\\s])"

    x <- gsub(regex1, "\\1", ifelse(lower.case, tolower, c)(x))
    gsub("\\s+", " ", gsub("^\\s+|\\s+$", "", x))
}


#' \code{strip.factor} - factor method for \code{strip}.
#' @rdname strip
#' @export
#' @method strip factor 
strip.factor <- function(x, char.keep = "~~", digit.remove = TRUE, apostrophe.remove = TRUE,
    lower.case = TRUE){

    strip(as.character(x), char.keep = char.keep, digit.remove = digit.remove, 
        apostrophe.remove = apostrophe.remove, lower.case = lower.case)
}

#' \code{strip.default} - factor method for \code{strip}.
#' @rdname strip
#' @export
#' @method strip default
strip.default <- function(x, char.keep = "~~", digit.remove = TRUE, apostrophe.remove = TRUE,
    lower.case = TRUE){

    strip(as.character(x), char.keep = char.keep, digit.remove = digit.remove, 
        apostrophe.remove = apostrophe.remove, lower.case = lower.case)
}

#' \code{strip.list} - factor method for \code{strip}.
#' @rdname strip
#' @export
#' @method strip list
strip.list <- function(x, char.keep = "~~", digit.remove = TRUE, apostrophe.remove = TRUE,
    lower.case = TRUE){

    unlist(lapply(x, strip))
}


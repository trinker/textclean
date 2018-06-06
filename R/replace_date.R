#' Replace Dates With Words
#'
#' Replaces dates with word equivalents.
#'
#' @param x The text variable.
#' @param pattern Character date regex string to be matched in the given 
#' character vector. 
#' @param replacement A function to operate on the extracted matches or a 
#' character string which is a replacement for the matched pattern.
#' @param \ldots ignored.
#' @return Returns a vector with the pattern replaced.
#' @export
#' @examples
#' x <- c(
#'     NA, '11-16-1980 and 11/16/1980', 
#'     "and 2017-02-08 but then there's 2/8/2017 too"
#' )
#' 
#' replace_date(x)
#' replace_date(x, replacement = '<<DATE>>')
replace_date <- function(x, 
    pattern = NULL, 
    replacement = NULL, ...){

    if (is.null(pattern)) pattern <- replace_date_pattern
    if (is.null(replacement)) replacement <- replace_date_fun 
    
    if (is.function(replacement)) {
        f_gsub <- fgsub
    } else { 
        f_gsub <- stringi::stri_replace_all_regex
    }

    f_gsub(x, pattern, replacement)

}

replace_date_pattern <- paste0(
    '([01]?[0-9])[/-]([0-2]?[0-9]|3[01])[/-]\\d{4}|\\d{4}[/-]', 
    '([01]?[0-9])[/-]([0-2]?[0-9]|3[01])'
)

replace_date_fun <- function(x){

        parts <- strsplit(
            gsub('(^.+)([/-])(\\d{4})', '\\3\\2\\1', x, perl = TRUE), 
            '[/-]'
        )[[1]]

        y <- replace_number(parts[1])
        m <- month.name[as.integer(parts[2])]
        d <- english::ordinal(as.integer(parts[3]))
        paste0(m, ' ', d, ', ', y)

}

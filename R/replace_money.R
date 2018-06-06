#' Replace Money With Words
#'
#' Replaces money with word equivalents.
#'
#' @param x The text variable.
#' @param pattern Character money regex string to be matched in the given 
#' character vector. 
#' @param replacement A function to operate on the extracted matches or a 
#' character string which is a replacement for the matched pattern.
#' @param \ldots ignored.
#' @return Returns a vector with the pattern replaced.
#' @export
#' @examples
#' x <- c(
#'     NA, 
#'     '$3.16 into "three dollars, sixteen cents"', 
#'     "-$20,333.18 too", 'fff'
#' )
#' 
#' replace_money(x)
#' replace_money(x, replacement = '<<MONEY>>')
replace_money <- function(x, pattern = '(-?)([$])([0-9,]+)(\\.\\d{2})?', 
    replacement = NULL, ...){

    #if (is.null(pattern)) pattern <- replace_money_pattern
    if (is.null(replacement)) replacement <- replace_money_fun 
    
    if (is.function(replacement)) {
        f_gsub <- fgsub
    } else { 
        f_gsub <- stringi::stri_replace_all_regex
    }

    f_gsub(x, pattern, replacement)

}

replace_money_fun <- function(x, decimal = ' and '){

    sign <- ifelse(grepl('^-', x), 'negative ', '')
    if (grepl('\\.', x)) {
        number <- replace_number(
            gsub(
                '\\.', 
                paste0(' dollars', decimal), 
                gsub('(-?)([$])', '', x)
            )
        )
        paste0(sign, number, ' cents')
    } else {
        number <- replace_number(gsub('(-?)([$])', '', x))
        paste0(sign, number)
    }

}

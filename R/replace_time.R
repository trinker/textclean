#' Replace Time Stamps With Words
#'
#' Replaces time stamps with word equivalents.
#'
#' @param x The text variable.
#' @param pattern Character time regex string to be matched in the given 
#' character vector. 
#' @param replacement A function to operate on the extracted matches or a 
#' character string which is a replacement for the matched pattern.
#' @param \ldots ignored.
#' @return Returns a vector with the pattern replaced.
#' @export
#' @examples
#' x <- c(
#'     NA, '12:47 to "twelve forty-seven" and also 8:35:02', 
#'     'what about 14:24.5', 'And then 99:99:99?'
#' )
#' 
#' replace_time(x)
#' 
#' 
#' replace_time(x, replacement = '<<TIME>>')
#' 
#' replace_time(x, replacement = function(y){
#'         z <- unlist(strsplit(y, '[:.]'))
#'         z[1] <- 'hh'
#'         z[2] <- 'mm'
#'         if(!is.na(z[3])) z[3] <- 'ss'
#'         collapse(z, ':')
#'     }
#' )
#' 
#' replace_time(x, replacement = function(y){
#'         z <- replace_number(unlist(strsplit(y, '[:.]')))
#'         z[3] <- paste0('and ', ifelse(is.na(z[3]), '0', z[3]), ' seconds')
#'         paste(z, collapse = ' ')
#'     }
#' )
#' 
#' replace_time(x, replacement = function(y){
#'         z <- unlist(strsplit(y, '[:.]'))
#'         z[1] <- 'hh'
#'         z[2] <- 'mm'
#'         z[3] <- 'ss'
#'         collapse(z, ':')
#'     }
#' )
replace_time <- function(x, pattern = '(2[0-3]|[01]?[0-9]):([0-5][0-9])[.:]?([0-5]?[0-9])?', 
    replacement = NULL, ...){

    if (is.null(replacement)) replacement <- replace_time_fun 
    
    if (is.function(replacement)) {
        f_gsub <- fgsub
    } else { 
        f_gsub <- stringi::stri_replace_all_regex
    }

    f_gsub(x, pattern, replacement)

}

replace_time_fun <- function(y){
    z <- replace_number(unlist(strsplit(y, '[:.]')))
    if(!is.na(z[3])) z[3] <- paste0('and ', z[3], ' seconds')
    paste(z, collapse = ' ')
}

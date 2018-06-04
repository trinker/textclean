#' Replace Email Addresses
#' 
#' Replaces email addresses.  
#' 
#' @param x The text variable.
#' @param pattern Character time regex string to be matched in the given 
#' character vector. 
#' @param replacement A function to operate on the extracted matches or a 
#' character string which is a replacement for the matched pattern.
#' @param \ldots ignored.
#' @return Returns a vector with email addresses replaced.
#' @export
#' @importFrom qdapRegex grab
#' @examples
#' x <- c(
#'     "fred is fred@@foo.com and joe is joe@@example.com - but @@this is a", 
#'     "twitter handle for twit@@here.com or foo+bar@@google.com/fred@@foo.fnord", 
#'     "hello world", 
#'     NA
#' )
#' 
#' replace_email(x)
#' replace_email(x, replacement = '<<EMAIL>>')
#' replace_email(x, replacement = '<a href="mailto:$1" target="_blank">$1</a>')
#' 
#' ## Replacement with a function
#' replace_email(x, 
#'     replacement = function(x){
#'         sprintf('<a href="mailto:%s" target="_blank">%s</a>', x, x)
#'     }
#' )
#' 
#' 
#' replace_email(x, 
#'     replacement = function(x){
#'         gsub('@@.+$', ' {{at domain}}', x)
#'     }
#' )
replace_email <- function(x, pattern = qdapRegex::grab('rm_email'), 
    replacement = '', ...){

    if (is.function(replacement)) {
        f_gsub <- fgsub
    } else { 
        f_gsub <- stringi::stri_replace_all_regex
    }

    f_gsub(x, pattern, replacement)

}

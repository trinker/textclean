#' Replace Hashes
#' 
#' Replaces Twitter style hash tags (e.g., '#rstats').  
#' 
#' @param x The text variable.
#' @param pattern Character time regex string to be matched in the given 
#' character vector. 
#' @param replacement A function to operate on the extracted matches or a 
#' character string which is a replacement for the matched pattern.
#' @param \ldots ignored.
#' @return Returns a vector with hashes replaced.
#' @export
#' @importFrom qdapRegex grab
#' @examples
#' x <- c("@@hadley I like #rstats for #ggplot2 work.",
#'     "Difference between #magrittr and #pipeR, both implement pipeline operators for #rstats: 
#'         http://renkun.me/r/2014/07/26/difference-between-magrittr-and-pipeR.html @@timelyportfolio",
#'     "Slides from great talk: @@ramnath_vaidya: Interactive slides from Interactive Visualization 
#'         presentation #user2014. http://ramnathv.github.io/user2014-rcharts/#1"
#' )
#' 
#' replace_hash(x)
#' replace_hash(x, replacement = '<<HASH>>')
#' replace_hash(x, replacement = '$3')
#' 
#' ## Replacement with a function
#' replace_hash(x, 
#'     replacement = function(x){
#'         paste0('{{', gsub('^#', 'TOPIC: ', x), '}}')
#'     }
#' )
replace_hash <- function(x, pattern = qdapRegex::grab('rm_hash'), 
    replacement = '', ...){

    if (is.function(replacement)) {
        f_gsub <- fgsub
    } else { 
        f_gsub <- stringi::stri_replace_all_regex
    }

    f_gsub(x, pattern, replacement)

}

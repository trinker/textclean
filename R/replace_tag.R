#' Replace Handle Tags
#' 
#' Replaces Twitter style handle tags (e.g., '@@trinker').  
#' 
#' @param x The text variable.
#' @param pattern Character time regex string to be matched in the given 
#' character vector. 
#' @param replacement A function to operate on the extracted matches or a 
#' character string which is a replacement for the matched pattern.
#' @param \ldots ignored.
#' @return Returns a vector with tags replaced.
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
#' replace_tag(x)
#' replace_tag(x, replacement = '<<TAG>>')
#' replace_tag(x, replacement = '$3')
#' 
#' ## Replacement with a function
#' replace_tag(x, 
#'     replacement = function(x){
#'         gsub('@@', ' <<TO>> ', x)
#'     }
#' )
replace_tag <- function(x, pattern = qdapRegex::grab('rm_tag'), 
    replacement = '', ...){

    if (is.function(replacement)) {
        f_gsub <- fgsub
    } else { 
        f_gsub <- stringi::stri_replace_all_regex
    }

    f_gsub(x, pattern, replacement)

}

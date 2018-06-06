#' Replace URLs
#' 
#' Replaces URLs.  
#' 
#' @param x The text variable.
#' @param pattern Character time regex string to be matched in the given 
#' character vector. 
#' @param replacement A function to operate on the extracted matches or a 
#' character string which is a replacement for the matched pattern.
#' @param \ldots ignored.
#' @return Returns a vector with URLs replaced.
#' @export
#' @importFrom qdapRegex grab
#' @examples
#' x <- c("@@hadley I like #rstats for #ggplot2 work. ftp://cran.r-project.org/incoming/",
#'     "Difference between #magrittr and #pipeR, both implement pipeline operators for #rstats: 
#'         http://renkun.me/r/2014/07/26/difference-between-magrittr-and-pipeR.html @@timelyportfolio",
#'     "Slides from great talk: @@ramnath_vaidya: Interactive slides from Interactive Visualization 
#'         presentation #user2014. https://ramnathv.github.io/user2014-rcharts/#1",
#'     NA 
#' )
#' 
#' replace_url(x)
#' replace_url(x, replacement = '<<URL>>')
#' 
#' \dontrun{
#' ## Replacement with a function
#' library(urltools)
#' replace_url(x, 
#'     replacement = function(x){
#'         sprintf('{{%s}}', urltools::url_parse(x)$domain)
#'     }
#' )
#' }
replace_url <- function(x, pattern = qdapRegex::grab('rm_url'), 
    replacement = '', ...){

    if (is.function(replacement)) {
        f_gsub <- fgsub
    } else { 
        f_gsub <- stringi::stri_replace_all_regex
    }

    f_gsub(x, pattern, replacement)

}

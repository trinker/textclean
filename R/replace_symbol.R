#' Replace Symbols With Word Equivalents
#' 
#' This function replaces symbols with word equivalents (e.g., \code{@@} becomes 
#' \code{"at"}.
#' 
#' @param x A character vector.
#' @param dollar logical.  If \code{TRUE} replaces dollar sign ($) with 
#' \code{"dollar"}.
#' @param percent logical.  If \code{TRUE} replaces percent sign (\%) with 
#' \code{"percent"}.
#' @param pound logical.  If \code{TRUE} replaces pound sign (#) with 
#' \code{"number"}.
#' @param at logical.  If \code{TRUE} replaces at sign (@@) with \code{"at"}.
#' @param and logical.  If \code{TRUE} replaces and sign (&) with \code{"and"}.
#' @param with  logical.  If \code{TRUE} replaces with sign (w/) with 
#' \code{"with"}.
#' @return Returns a character vector with symbols replaced..
#' @keywords symbol-replace
#' @export
#' @examples
#' x <- c("I am @@ Jon's & Jim's w/ Marry", 
#'     "I owe $41 for food", 
#'     "two is 10% of a #"
#' )
#' replace_symbol(x)
replace_symbol <- function(x, dollar = TRUE, percent = TRUE, 
    pound = TRUE, at = TRUE, and = TRUE, with = TRUE) {
    
    y <- c(dollar, percent, pound, at, and, with, with)
  
    gsub("\\+", " ", mgsub(
        x,
        pattern = symbs[y], 
        replacement = replaces[y], 
        fixed = TRUE,
    ))
}

symbs <-  c("%", "$", "#", "&", "@", "w/o", "w/")
replaces <- paste0(" ", c("percent", "dollar", "number", "and", "at", 
        "without", "with"), " ")


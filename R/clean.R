#' Remove Escaped Characters
#' 
#' Preprocess data to remove escaped characters
#' 
#' @param text.var The text variable
#' @return Returns a vector of character strings with escaped characters removed.
#' @keywords escaped character
#' @export
#' @examples
#' \dontrun{
#' x <- "I go \\r
#'     to the \\tnext line"
#' x
#' clean(x)
#' }
clean <-
function(text.var) {
    gsub("\\s+", " ", gsub("\\\\r|\\\\n|\\n|\\\\t", " ", text.var))
}

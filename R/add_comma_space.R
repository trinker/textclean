#' Ensure Space After Comma
#' 
#' Adds a space after a comma as \code{strip} and many other functions may consider a 
#' comma separated string as one word (i.e., \code{"one,two,three"} becomes 
#' \code{"onetwothree"}  rather than \code{"one two three"}).
#' 
#' @param text.var The text variable.
#' @return Returns a vector of strings with commas that have a space after them.
#' @keywords comma space
#' @export
#' @examples
#' \dontrun{
#' x <- c("the,  dog,went", "I,like,it", "where are you", NA, "why", ",", ",f")
#' add_comma_space(x)
#' }
add_comma_space <- function(x) {
    gsub("(,)([^ ])", "\\1 \\2", x)
}


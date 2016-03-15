#' Denote replace_incompletelete End Marks With "|"
#' 
#' Replaces replace_incompletelete sentence end marks (.., ..., .?, ..?, en & em dash etc.)
#' with \code{"|"}.
#' 
#' @param x  The text variable.
#' @param replacement A string to replace incomplete punctuation marks with.
#' @param \dots ignored.
#' @return Returns a text variable (character sting) with replace_incompletelete sentence 
#' marks (.., ..., .?, ..?, en & em dash etc.) replaced with "|".  If scan mode 
#' is \code{TRUE} returns a data frame with replace_incompletelete sentence location.
#' @keywords replace_incompletelete-sentence
#' @export
#' @examples
#' x <- c("the...",  "I.?", "you.", "threw..", "we?")
#' replace_incomplete(x)
#' replace_incomplete(x, '...')
replace_incomplete <-
function(x, replacement = "|", ...) {
    gsub(sprintf('%s\\s*$', pat), replacement, x)
}

pat <- paste0("\\?*\\?[.]+|[.?!]*\\? [.][.?!]+|[.?!]*\\. [.?!]+|",
    "[.?!]+\\. [.?!]*|[.?!]+\\.[.?!]*|[.?!]*\\.[.?!]+")



#' Denote Incomplete End Marks With "|"
#' 
#' Replaces incomplete sentence end marks (.., ..., .?, ..?, en & em dash etc.)
#' with \code{"|"}.
#' 
#' @param x  The text variable.
#' @param replacement A string to replace incomplete punctuation marks with.
#' @param \dots ignored.
#' @return Returns a text variable (character sting) with incomplete sentence 
#' marks (.., ..., .?, ..?, en & em dash etc.) replaced with "|".  
#' @keywords incomplete-sentence
#' @export
#' @examples
#' x <- c("the...",  "I.?", "you.", "threw..", "we?")
#' replace_incomplete(x)
#' replace_incomplete(x, '...')
replace_incomplete <- function(x, replacement = "|", ...) {
    gsub(sprintf('%s\\s*$', pat), replacement, x)
}

pat <- paste0("\\?*\\?[.]+|[.?!]*\\? [.][.?!]+|[.?!]*\\. [.?!]+|",
    "[.?!]+\\. [.?!]*|[.?!]+\\.[.?!]*|[.?!]*\\.[.?!]+")



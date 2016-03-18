#' Replace Contractions
#'
#' This function replaces contractions with long form.
#' 
#' @param x  The text variable.
#' @param contraction.key A two column hash of contractions (column 1) and expanded 
#' form replacements (column 2).  Default is to use 
#' \code{\link[lexicon]{hash_contractions}} data set.
#' @param ignore.case logical.  Should case be ignored?
#' @param \dots ignored.
#' @return Returns a vector with contractions replaced.
#' @keywords contraction
#' @export
#' @examples
#' \dontrun{
#' x <- c("Mr. Jones isn't going.",  
#'     "Check it out what's going on.",
#'     "He's here but didn't go.",
#'     "the robot at t.s. wasn't nice", 
#'     "he'd like it if i'd go away")
#' 
#' replace_contraction(x)
#' }
replace_contraction <- 
function(x, contraction.key = lexicon::hash_contractions, ignore.case=TRUE, ...) {

    mgsub(x, contraction.key[[1]], contraction.key[[2]], fixed = FALSE, ignore.case=TRUE)

}


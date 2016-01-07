#' Replace Mixed Ordinal Numbers With Text Representation
#' 
#' Replaces mixed text/numeric represented ordinal numbers with words (e.g., 
#' "1st" becomes "first").
#' 
#' @param text.var  The text variable.
#' @param num.paste logical.  If \code{TRUE} a the elements of larger numbers are 
#' separated with spaces.  If \code{FALSE} the elements will be joined without 
#' spaces.
#' @param remove logical.  If \code{TRUE} ordinal numbers are removed from the text.
#' @keywords ordinal-to-word
#' @note Currently only implemented for ordinal values 1 through 100
#' @seealso 
#' \code{\link[qdap]{bracketX}},
#' \code{\link[qdap]{qprep}},
#' \code{\link[qdap]{replace_abbreviation}},
#' \code{\link[qdap]{replace_contraction}},
#' \code{\link[qdap]{replace_symbol}},
#' \code{\link[qdap]{replace_number}}
#' @export
#' @examples
#' \dontrun{
#' x <- c(
#'     "I like the 1st one not the 22nd one.", 
#'     "For the 100th time stop!"
#' )
#' replace_ordinal(x)
#' replace_ordinal(x, FALSE)
#' replace_ordinal(x, remove = TRUE)
#' "I like the 1st 1 not the 22nd 1." %>% replace_ordinal %>% replace_number
#' }
replace_ordinal <- function(text.var, num.paste = TRUE, remove = FALSE) {

    symb <- c("1st", "2nd", "3rd", paste0(4:19, "th"),
        paste0(20:100, c("th", "st", "nd", "rd", rep("th", 6))))

    if (remove) {
        ordinal <- ""
    } else {
        base_ord <- ordinal <- c("first", "second", "third", "fourth", 
            "fifth", "sixth", "seventh", "eighth", "ninth")
        prefix <- c("twent", "thirt", "fort", "fift", "sixt", 
            "sevent", "eight", "ninet")
        ordinal <- c(base_ord, "tenth", "eleventh", "twelfth", 
            "thirteenth", "fourteenth", "fifteenth", "sixteenth", 
            "seventeenth", "eighteenth", "nineteenth", 
            paste0(rep(prefix, each=10), c("ieth", paste("y", base_ord))), 
            "hundredth")
    }
    if (num.paste & !remove) ordinal <- gsub("\\s+", "", ordinal)
    Trim(mgsub(paste0("\\b", symb, "\\b"), spaste(ordinal), text.var, fixed=FALSE))
}

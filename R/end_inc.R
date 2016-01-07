#' Test for Incomplete Sentences
#' 
#' Test for incomplete sentences and optionally remove them.
#' 
#' @param dataframe A dataframe that contains the person and text variable.
#' @param text.var A character string of the text variable.
#' @param warning.report logical.  If \code{TRUE} prints a warning of regarding 
#' removal of incomplete sentences.
#' @param which.mode logical.  If \code{TRUE} outputs two logical vectors: `NOT` 
#' (logical test of not being an incomplete sentence) and `INC` (logical test of 
#' being an incomplete sentence) 
#' @return Generates a dataframe with incomplete sentences removed.
#' @keywords incomplete
#' @export
#' @examples
#' \dontrun{
#' dat <- sentSplit(DATA, "state", stem.col = FALSE)
#' dat$state[c(2, 5)] <- paste(strip(dat$state[c(2, 5)]), "|")
#' end_inc(dat, "state")
#' end_inc(dat, "state", warning.report = FALSE)
#' end_inc(dat, "state", which.mode = TRUE)
#' }
end_inc <-
function(dataframe, text.var, warning.report=TRUE, which.mode = FALSE){
    tx <- scrubber(dataframe[, as.character(substitute(text.var))])
    nc <- nchar(tx)
    keep <- substring(tx, nc, nc) != "|"
    if (which.mode) {
        return(list("NOT" = keep, "INC" = !keep))
    } else {
        nrp <- sum(!keep, na.rm=TRUE)
        if (warning.report & nrp > 0) {
            warning(nrp, 
            " incomplete sentence items removed\n")
        }
        return(dataframe[keep, ])
    }
}

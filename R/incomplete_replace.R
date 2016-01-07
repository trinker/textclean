#' Denote Incomplete End Marks With "|"
#' 
#' Replaces incomplete sentence end marks (.., ..., .?, ..?, en & em dash etc.)
#' with \code{"|"}.
#' 
#' @rdname incomplete_replace
#' @param text.var  The text variable.
#' @param scan.mode logical.  If \code{TRUE} only scans and reports incomplete 
#' sentences.
#' @return Returns a text variable (character sting) with incomplete sentence 
#' marks (.., ..., .?, ..?, en & em dash etc.) replaced with "|".  If scan mode 
#' is \code{TRUE} returns a data frame with incomplete sentence location.
#' @keywords incomplete-sentence
#' @export
#' @examples
#' \dontrun{
#' x <- c("the...",  "I.?", "you.", "threw..", "we?")
#' incomplete_replace(x)
#' incomp(x)
#' incomp(x, scan.mode = TRUE)
#' }
incomplete_replace <-
function(text.var, scan.mode = FALSE) {
  pat <- paste0("\\?*\\?[.]+|[.?!]*\\? [.][.?!]+|[.?!]*\\. [.?!]+|",
        "[.?!]+\\. [.?!]*|[.?!]+\\.[.?!]*|[.?!]*\\.[.?!]+")
    if (scan.mode) {
      wid <- options()$width
      options(width = 10000)
      sel <- grepl(pat, scrubber(text.var))
      x <- data.frame(row.num = which(sel), 
          text = as.character(text.var[sel]))
      print(left_just(x, 2))
      options(width = wid)
    } else {
      x <- gsub(pat, "|", scrubber(text.var))
      return(x)
    }
}

#' @rdname incomplete_replace
#' @export
incomp <- incomplete_replace

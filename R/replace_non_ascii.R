#' Replace Common Non-ASCII Characters
#' 
#' \code{replace_non_ascii} - Replaces common non-ASCII characters.
#' 
#' @param x The text variable.
#' @param remove.nonconverted logical.  If \code{TRUE} unmapped encodings are
#' deleted from the string.
#' @param \dots ignored.
#' @return Returns a text variable (character sting) with non-ASCII characters 
#' replaced.
#' @keywords ascii
#' @rdname replace_non_ascii
#' @export
#' @examples
#' x <- c(
#'     "Hello World", "6 Ekstr\xf8m", "J\xf6reskog", "bi\xdfchen Z\xfcrcher",
#'     'This is a \xA9 but not a \xAE', '6 \xF7 2 = 3', 'fractions \xBC, \xBD, \xBE',
#'     'cows go \xB5', '30\xA2'
#' )
#' Encoding(x) <- "latin1"
#' x
#' 
#' replace_non_ascii(x)
#' replace_non_ascii(x, remove.nonconverted = FALSE)
#' 
#' z <- '\x95He said, \x93Gross, I am going to!\x94'
#' Encoding(z) <- "latin1"
#' z
#' 
#' replace_curly_quote(z)
#' replace_non_ascii(z)
replace_non_ascii <- function(x, remove.nonconverted = TRUE, ...) {
    x <- replace_curly_quote(x)
    x <- stringi::stri_trans_general(x, "latin-ascii")
    x <- iconv(as.character(x), "", "ASCII", "byte")
    Encoding(x) <-"latin1"    
    x <- mgsub(x, ser, reps)
    if (isTRUE(remove.nonconverted)) x <- qdapRegex::rm_angle(x)
    x
}

#' Replace Common Non-ASCII Characters
#' 
#' \code{replace_curly_quote} - Replaces curly single and doble quotes.  This 
#' provides a subset of functionality found in \code{replace_non_ascii} specific 
#' to quotes.
#' 
#' @rdname replace_non_ascii
#' @export
replace_curly_quote <- function(x, ...){
    replaces <- c('\x91', '\x92', '\x93', '\x94')
    Encoding(replaces) <- "latin1"
    for (i in 1:4) {
        x <- gsub(replaces[i], c("'", "'", "\"", "\"")[i], x, fixed = TRUE)
    }
    x
}

ser <- c("<e2><80><9c>", "<e2><80><9d>", "<e2><80><98>", "<e2><80><99>",
	"<e2><80><9b>", "<ef><bc><87>", "<e2><80><a6>", "<e2><80><93>",
	"<e2><80><94>", "<c3><a1>", "<c3><a9>", "<c2><bd>", '<a9>', '<ae>',
    '<f7>', '<bc>', '<bd>', '<be>', '<b5>', '<a2>'
    )

reps <- c('"', '"', "'", "'", "'", "'", '...', '-', '-', "a", "e", "1/2", 
    ' copyright ', ' registered trademark ', "/", '1/2', '1/4', '3/4', ' mu ', ' cent ')


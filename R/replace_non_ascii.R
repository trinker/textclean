#' Replace Common Non-ASCII Characters
#' 
#' Replaces common non-ascii characters.
#' 
#' @param x  The text variable.
#' @param remove.nonconverted logical.  If \code{TRUE} unmapped encodings are
#' deleted from the string.
#' @param \dots ignored.
#' @return Returns a text variable (character sting) with non-ascii characters 
#' replaced.
#' @keywords ascii
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
replace_non_ascii <-
function(x, remove.nonconverted = TRUE, ...) {
    x <- iconv(as.character(x), "", "ASCII", "byte")
    Encoding(x) <-"latin1"
    x <- mgsub(x, ser, reps)
    if (isTRUE(remove.nonconverted)) x <- qdapRegex::rm_angle(x)
    x
}


ser <- c("<e2><80><9c>", "<e2><80><9d>", "<e2><80><98>", "<e2><80><99>",
	"<e2><80><9b>", "<ef><bc><87>", "<e2><80><a6>", "<e2><80><93>",
	"<e2><80><94>", "<c3><a1>", "<c3><a9>", "<c2><bd>", '<a9>', '<ae>',
    '<f7>', '<bc>', '<bd>', '<be>', '<b5>', '<a2>'
    )

reps <- c('"', '"', "'", "'", "'", "'", '...', '-', '-', "a", "e", "1/2", 
    ' copyright ', ' registered trademark ', "/", '1/2', '1/4', '3/4', ' mu ', ' cent ')


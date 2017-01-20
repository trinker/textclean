#' Replace HTML Markup
#' 
#' Replaces HTML markup.  The angle braces are removed and the HTML symbol 
#' markup is replaced with equivalent symbols.  Replacements for symbols are as 
#' follows:
#' 
#' \tabular{lr}{
#'     \bold{html} \tab  \bold{symbol} \cr
#'   &nbsp;   \tab      \cr
#'     &lt;   \tab < \cr
#'     &gt;   \tab  > \cr
#'    &amp;   \tab & \cr
#'   &quot;   \tab " \cr
#'   &apos;   \tab ' \cr
#'   &cent;   \tab cents  \cr
#'  &pound;   \tab pounds  \cr
#'    &yen;   \tab yen \cr
#'   &euro;   \tab euro \cr
#'   &copy;   \tab (c) \cr
#'    &reg;   \tab (r) \cr
#' }
#' 
#' @param x  The text variable.
#' @param symbol lofical.  If code{TRUE} the sybols are retained with appropriate
#' replacments.  If \code{FALSE} they are removed.
#' @param \ldots Ignored.
#' @return Returns a vector with HTML markup replaced.
#' @keywords html
#' @export
#' @examples
#' x <- c(
#'     "<bold>Random</bold> text with symbols: &nbsp; &lt; &gt; &amp; &quot; &apos;",
#'     "<p>More text</P> &cent; &pound; &yen; &euro; &copy; &reg;"
#' )
#' 
#' replace_html(x)
#' replace_html(x, FALSE)
replace_html <- function(x, symbol = TRUE, replace...){
    if (isTRUE(symbol)) {
        reps <-  html_symbols[['symbol']]
    } else {
        reps <- " "
    }
    mgsub(gsub('<[^>]+>', ' ', x), html_symbols[['html']],reps)
}


html_symbols <- structure(list(html = c("&nbsp;", "&lt;", "&gt;", "&amp;", "&quot;", 
"&apos;", "&cent;", "&pound;", "&yen;", "&euro;", "&copy;", "&reg;"
), symbol = c(" ", "<", ">", "&", "\"", "'", " cents ", " pounds ", 
" yen ", " euro ", "(c)", "(r)")), class = "data.frame", .Names = c("html", 
"symbol"), row.names = c(NA, -12L))


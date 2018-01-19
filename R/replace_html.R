#' Replace HTML Markup
#' 
#' Replaces HTML markup.  The angle braces are removed and the HTML symbol 
#' markup is replaced with equivalent symbols.  
#'
#' @details Replacements for symbols are as follows:
#' 
#' \tabular{lr}{
#'  \bold{html} \tab  \bold{symbol} \cr
#'   &copy;   \tab (c) \cr
#'   &reg;   \tab (r) \cr
#'   &trade;   \tab tm \cr
#'   &ldquo;   \tab " \cr
#'   &rdquo;   \tab " \cr
#'   &lsquo;   \tab ' \cr
#'   &rsquo;   \tab ' \cr
#'   &bull;   \tab - \cr
#'   &middot;   \tab - \cr
#'   &sdot;   \tab [] \cr
#'   &ndash;   \tab - \cr
#'   &mdash;   \tab - \cr
#'   &cent;   \tab cents \cr
#'   &pound;   \tab pounds \cr
#'   &euro;   \tab euro \cr
#'   &ne;   \tab != \cr
#'   &frac12;   \tab half \cr
#'   &frac14;   \tab quarter \cr
#'   &frac34;   \tab three fourths \cr
#'   &deg;   \tab degrees \cr
#'   &larr;   \tab <- \cr
#'   &rarr;   \tab -> \cr
#'   &hellip;   \tab ... \cr
#'   &nbsp;   \tab   \cr
#'   &lt;   \tab < \cr
#'   &gt;   \tab > \cr
#'   &amp;   \tab & \cr
#'   &quot;   \tab " \cr
#'   &apos;   \tab ' \cr
#'   &yen;   \tab yen \cr
#' }
#' 
#' @param x The text variable.
#' @param symbol logical.  If code{TRUE} the symbols are retained with appropriate
#' replacements.  If \code{FALSE} they are removed.
#' @param \ldots Ignored.
#' @return Returns a vector with HTML markup replaced.
#' @keywords html
#' @export
#' @examples
#' x <- c(
#'     "<bold>Random</bold> text with symbols: &nbsp; &lt; &gt; &amp; &quot; &apos;",
#'     "<p>More text</p> &cent; &pound; &yen; &euro; &copy; &reg;"
#' )
#' 
#' replace_html(x)
#' replace_html(x, FALSE)
#' replace_white(replace_html(x, FALSE))
replace_html <- function(x, symbol = TRUE, ...){
    if (isTRUE(symbol)) {
        reps <-  html_symbols[['symbol']]
    } else {
        reps <- " "
    }
    mgsub(gsub('<[^>]+>', ' ', x), html_symbols[['html']],reps)
}


html_symbols <- data.frame(
    html = c("&copy;", "&reg;", "&trade;", "&ldquo;", 
        "&rdquo;", "&lsquo;", "&rsquo;", "&bull;", "&middot;", "&sdot;", 
        "&ndash;", "&mdash;", "&cent;", "&pound;", "&euro;", "&ne;", 
        "&frac12;", "&frac14;", "&frac34;", "&deg;", "&larr;", "&rarr;", 
        "&hellip;", "&nbsp;", "&lt;", "&gt;", "&amp;", "&quot;", "&apos;",
        "&yen;"
    ), 
    symbol = c("(c)", "(r)", "tm", "\"", "\"", "'", 
        "'", "-", "-", "[]", "-", "-", "cents", "pounds", "euro", "!=", 
        "half", "quarter", "three fourths", "degrees", "<-", "->", "...",
        " ", "<", ">", "&", '"', "'", "yen"
    ), 
    stringsAsFactors = FALSE
)

## clipr::write_clip(textclean::glue("#'   {html}   \\tab {symb} \\cr\n", html = html_table[[1]], symb = html_table[[2]]))


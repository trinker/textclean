#' Replace a Regex with an Functional Operation on the Regex Match
#' 
#' This is a stripped down version of \code{gsubfn} from the \pkg{gsubfn} 
#' package.  It finds a regex match, and then uses a function to operate on
#' these matches and uses them to replace the original matches.  Note that
#' the \pkg{stringi} packages is used for matching and extracting the regex 
#' matches.  For more powerful needs please see the \pkg{gsubfn} package.
#' 
#' @param x A character vector.
#' @param pattern Character string to be matched in the given character vector. 
#' @param fun A function to operate on the extracted matches.
#' @param \ldots ignored.
#' @return Returns a vector with the pattern replaced.
#' @export
#' @seealso \code{\link[gsubfn]{gsubfn}}
#' @examples 
#' fgsub(
#'     x = c(NA, 'df dft sdf', 'sd fdggg sd dfhhh d', 'ddd'),
#'     pattern = "\\b\\w*([a-z])(\\1{2,})\\w*\\b",
#'     fun = function(x) {paste0('<<', paste(rev(strsplit(x, '')[[1]]), collapse =''), '>>')}    
#' )
fgsub <- function(x, pattern, fun, ...){
    
    locs <- stringi::stri_detect_regex(x, pattern)
    locs[is.na(locs)] <- FALSE
    txt <- x[locs]
    
    hits <- stringi::stri_extract_all_regex(txt, pattern)
    pats <- unique(unlist(hits))
    reps <- paste0('textcleanholder', seq_along(pats), 'textcleanholder')
    freps <- unlist(lapply(pats, fun))
        
    txt <- mgsub(txt, pats, reps)
    
    x[locs] <- mgsub(txt, reps, freps)
    x

}

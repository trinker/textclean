#' Replace Abbreviations
#'
#' This function replaces abbreviations with long form.
#' 
#' @param text.var  The text variable.
#' @param abbreviation A two column key of abbreviations (column 1) and long 
#' form replacements (column 2) or a vector of abbreviations.  Default is to use 
#' qdapDictionaries's \code{\link[qdapDictionaries]{abbreviations}} data set.
#' @param replace A vector of long form replacements if a data frame is not 
#' supplied to the abbreviation argument.
#' @param ignore.case logical.  If \code{TRUE} replaces without regard to 
#' capitalization.
#' @return Returns a vector with abbreviations replaced.
#' @keywords abbreviation
#' @seealso 
#' \code{\link[qdap]{bracketX}},
#' \code{\link[qdap]{qprep}},
#' \code{\link[qdap]{replace_contraction}},
#' \code{\link[qdap]{replace_number}},
#' \code{\link[qdap]{replace_symbol}}
#' @export
#' @examples
#' \dontrun{
#' x <- c("Mr. Jones is here at 7:30 p.m.",  
#'     "Check it out at www.github.com/trinker/qdap",
#'     "i.e. He's a sr. dr.; the best in 2012 A.D.",
#'     "the robot at t.s. is 10ft. 3in.")
#' 
#' replace_abbreviation(x)
#' 
#' #create abbreviation and replacement vectors
#' abv <- c("in.", "ft.", "t.s.")
#' repl <- c("inch", "feet", "talkstats")
#' 
#' replace_abbreviation(x, abv, repl)
#' 
#' (KEY <- rbind(abbreviations, data.frame(abv = abv, rep = repl)))
#' replace_abbreviation(x, KEY)
#' }
replace_abbreviation <-
function(text.var, abbreviation = qdapDictionaries::abbreviations, replace = NULL, 
    ignore.case=TRUE) {
    if (!is.null(replace)) {
        ab <- data.frame(abv=abbreviation, repl=replace)
    } else {
        if (is.list(abbreviation)) {
            ab <- data.frame(abv=abbreviation[[1]], repl=abbreviation[[2]])            
        } else {
            stop("must supply vector of abbreviations and vector of replacements")
        }
    }
    if (ignore.case) {
        ab[, 1] <- tolower(ab[, 1])    
        caps <- function(string, all = FALSE) {      
            capit <- function(x) paste0(toupper(substring(x, 1, 1)), substring(x, 2))
            if (all) {
                x <- paste(unlist(lapply(strsplit(string, " "), capit)), collapse=" ")
                y <- paste(unlist(lapply(strsplit(x, NULL), capit)), collapse="")
                x <- c(x, y)
            } else {
                x <- capit(string)
            }
            return(x)
        }
        ab2 <- do.call(rbind, list(ab, ab))
        temp <- unlist(lapply(ab2[, 1], caps, TRUE))
        ab2[, 1] <- temp[1:(length(temp)/2)]
        v <- as.character(ab[, 2])
        ab <- data.frame(rbind(ab, ab2))
        ab[, 2] <- c(v, rep(v, each=2))
        ab[, 2] <- spaste(ab[, 2])
    }
    text.var <- Trim(text.var)
    pn <- which(substring(text.var, nchar(text.var)) == ".")
    text.var <- mgsub(ab[, 1], ab[, 2], text.var)
    x <- Trim(gsub("\\s+", " ", text.var))
    x[pn] <- sapply(x[pn], function(z) {
            if (substring(z, nchar(z)) != ".") {
                paste(z, ".", sep="")
            } else {
                z
            }
        }, USE.NAMES = FALSE)
    return(scrubber(x))
}

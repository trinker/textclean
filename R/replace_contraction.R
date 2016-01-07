#' Replace Contractions
#'
#' This function replaces contractions with long form.
#' 
#' @param text.var  The text variable.
#' @param contraction A two column key of contractions (column 1) and expanded 
#' form replacements (column 2) or a vector of contractions.  Default is to use 
#' qdapDictionaries's \code{\link[qdapDictionaries]{contractions}} data set.
#' @param replace A vector of expanded form replacements if a data frame is not 
#' supplied to the contraction argument.
#' @param ignore.case logical.  If \code{TRUE} replaces without regard to 
#' capitalization.
#' @param sent.cap logical.  If \code{TRUE} capitalizes the beginning of every 
#' sentence.
#' @return Returns a vector with contractions replaced.
#' @keywords contraction
#' @seealso 
#' \code{\link[qdap]{bracketX}},
#' \code{\link[qdap]{qprep}},
#' \code{\link[qdap]{replace_abbreviation}},
#' \code{\link[qdap]{replace_number}},
#' \code{\link[qdap]{replace_symbol}}
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
function(text.var, contraction = qdapDictionaries::contractions, replace = NULL, 
    ignore.case=TRUE, sent.cap = TRUE) {
    if (!is.null(replace)) {
        ab <- data.frame(abv=contraction, repl=replace)
    } else {
        if (is.list(contraction)) {
            ab <- data.frame(abv=contraction[[1]], repl=contraction[[2]])            
        } else {
            stop("must supply vector of contractions and vector of replacements")
        }
    }
    capit <- function(x) {
        z <- paste0(toupper(substring(x, 1, 1)), substring(x, 2))
        z[is.na(x)] <- NA
        z
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
    x <- scrubber(x)
    if (sent.cap) {
        return(capit(x))
    }
    x
}


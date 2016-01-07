#' Remove Rows That Contain Markers
#' 
#' \code{rm_row} - Remove rows from a data set that contain a given marker/term.
#' 
#' @param dataframe A dataframe object.
#' @param search.column Column name to search for markers/terms.
#' @param terms Terms/markers of the rows that are to be removed from the 
#' dataframe.  The term/marker must appear at the beginning of the string and is 
#' case sensitive.
#' @param contains logical.  If \code{TRUE} \code{rm_row} searches for the terms 
#' anywhere within the string.  If \code{FALSE} \code{rm_row} searches only the 
#' beginning of the string.
#' @param ignore.case logical.  If \code{TRUE} case is ignored during matching, 
#' if \code{FALSE}the pattern matching is case sensitive.
#' @param keep.rownames logical.  If \code{TRUE} the original, non-sequential, 
#' rownames will be used. 
#' @param \ldots Other arguments passed to \code{\link[base]{grepl}}.
#' @return \code{rm_row} - returns a dataframe with the termed/markered rows 
#' removed.
#' @rdname rm_row
#' @export
#' @examples
#' \dontrun{
#' #rm_row EXAMPLE:
#' rm_row(DATA, "person", c("sam", "greg"))
#' rm_row(DATA, 1, c("sam", "greg"))
#' rm_row(DATA, "state", c("Comp"))
#' rm_row(DATA, "state", c("I "))
#' rm_row(DATA, "state", c("you"), contains = TRUE, ignore.case=TRUE)
#' 
#' #rm_empty_row EXAMPLE:
#' (dat <- rbind.data.frame(DATA[, c(1, 4)], matrix(rep(" ", 4), 
#'    ncol =2, dimnames=list(12:13, colnames(DATA)[c(1, 4)]))))
#' rm_empty_row(dat)
#' }
rm_row <- 
function (dataframe, search.column, terms, contains = FALSE, ignore.case = FALSE,
    keep.rownames = FALSE, ...) {

    if (contains) {
        FUN <- function(dat, sc, term) {
            dat[!grepl(term, dat[, sc], ignore.case = ignore.case, ...),]
        }
    } else {
        if (!ignore.case) {
            FUN <- function(dat, sc, term) {
                dat[substring(dat[, sc], 1, nchar(term)) != term, ]
            }
        } else {
            FUN <- function(dat, sc, term) {
                dat[tolower(substring(dat[, sc], 1, nchar(term))) != tolower(term), ]
            }
        }
    }

    lapply(terms, function(x) {
        dataframe <<- FUN(dataframe, search.column, x)
    })

    if (!keep.rownames) {
        rownames(dataframe) <- NULL
    }
    dataframe
}


#' Remove Empty Rows in a Data Frame
#' 
#' \code{rm_empty_row} - Removes the empty rows of a data set that are common in 
#' reading in data (default method in \code{\link[qdap]{read.transcript}}).
#' 
#' @return \code{rm_empty_row} - returns a dataframe with empty rows removed.
#' @rdname rm_row
#' @export
rm_empty_row <-
function(dataframe) {
    x <- paste2(dataframe, sep="")
    x <- gsub("\\s+", "", x)
    ind <- x != ""
    return(dataframe[ind,  ,drop = FALSE] )
}

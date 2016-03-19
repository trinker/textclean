#' Remove Rows That Contain Markers
#' 
#' \code{filter_row} - Remove rows from a data set that contain a given marker/term.
#' 
#' @param dataframe A dataframe object.
#' @param column Column name to search for markers/terms.
#' @param terms The regex terms/markers of the rows that are to be removed from 
#' the dataframe.  
#' @param \ldots Other arguments passed to \code{\link[base]{grepl}}.
#' @return \code{filter_row} - returns a dataframe with the termed/markered rows 
#' removed.
#' @rdname filter_row
#' @export
#' @examples
#' \dontrun{
#' #filter_row EXAMPLE:
#' filter_row(DATA, "person", c("sam", "greg"))
#' filter_row(DATA, 1, c("sam", "greg"))
#' filter_row(DATA, "state", c("Comp"))
#' filter_row(DATA, "state", c("I "))
#' filter_row(DATA, "state", c("you"), ignore.case=TRUE)
#' 
#' #filter_empty_row EXAMPLE:
#' (dat <- rbind.data.frame(DATA[, c(1, 4)], matrix(rep(" ", 4), 
#'    ncol =2, dimnames=list(12:13, colnames(DATA)[c(1, 4)]))))
#' filter_empty_row(dat)
#' }
filter_row <- function (dataframe, column, terms, ...) {
    
    terms <- paste(terms, collapse="|")
    dataframe <- dataframe[!grepl(terms, dataframe[[column]], perl=TRUE, ...), ]
    rownames(dataframe) <- NULL
    
    dataframe
}


#' Remove Empty Rows in a Data Frame
#' 
#' \code{filter_empty_row} - Removes the empty rows of a data set that are common in 
#' reading in data.
#' 
#' @return \code{filter_empty_row} - returns a dataframe with empty rows removed.
#' @rdname filter_row
#' @export
filter_empty_row <- function(dataframe) {
    x <- apply(dataframe, 1, function(x) paste(na.omit(x), collapse = ""))
    return(dataframe[!grepl("^\\s*$", x),  ,drop = FALSE] )
}

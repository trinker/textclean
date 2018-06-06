#' Filter Rows That Contain Markers
#' 
#' \code{drop_row} - Remove rows from a data set that contain a given 
#' marker/term.
#' 
#' @param dataframe A dataframe object.
#' @param column Column name to search for markers/terms.
#' @param terms The regex terms/markers of the rows that are to be removed from 
#' the dataframe.  
#' @param \ldots Other arguments passed to \code{\link[base]{grepl}}.
#' @return \code{drop_row} - returns a dataframe with the termed/markered rows 
#' removed.
#' @rdname drop_row
#' @export
#' @examples
#' \dontrun{
#' ## drop_row EXAMPLE:
#' drop_row(DATA, "person", c("sam", "greg"))
#' keep_row(DATA, "person", c("sam", "greg"))
#' drop_row(DATA, 1, c("sam", "greg"))
#' drop_row(DATA, "state", c("Comp"))
#' drop_row(DATA, "state", c("I "))
#' drop_row(DATA, "state", c("you"), ignore.case=TRUE)
#' 
#' ## drop_empty_row EXAMPLE:
#' (dat <- rbind.data.frame(DATA[, c(1, 4)], matrix(rep(" ", 4), 
#'    ncol =2, dimnames=list(12:13, colnames(DATA)[c(1, 4)]))))
#' drop_empty_row(dat)
#' 
#' ## drop_NA EXAMPLE:
#' DATA[1:3, "state"] <- NA
#' drop_NA(DATA)
#' }
drop_row <- function(dataframe, column, terms, ...) {
    
    terms <- paste(terms, collapse="|")
    if (length(dataframe[[column]]) == 0) {
        stop(
            "No columns in the data appear to match supplied `column`", 
            call. = FALSE
        )   
    }
    dataframe <- dataframe[!grepl(terms, dataframe[[column]], perl=TRUE, ...), ]
    rownames(dataframe) <- NULL
    
    dataframe
}

#' Filter Rows That Contain Markers
#' 
#' \code{keep_row} - Keep rows from a data set that contain a given marker/term.
#' @rdname drop_row
#' @export
keep_row <- function(dataframe, column, terms, ...) {
    
    terms <- paste(terms, collapse="|")
    if (length(dataframe[[column]]) == 0) {
        stop(
            "No columns in the data appear to match supplied `column`", 
            call. = FALSE
            )    
    }
    dataframe <- dataframe[grepl(terms, dataframe[[column]], perl=TRUE, ...), ]
    rownames(dataframe) <- NULL
    
    dataframe
}


#' Remove Empty Rows in a Data Frame
#' 
#' \code{drop_empty_row} - Removes the empty rows of a data set that are common in 
#' reading in data.
#' 
#' @return \code{drop_empty_row} - returns a dataframe with empty rows removed.
#' @rdname drop_row
#' @export
drop_empty_row <- function(dataframe) {
    x <- apply(dataframe, 1, function(x) {
        paste(stats::na.omit(x), collapse = "")
    })
    return(dataframe[!grepl("^\\s*$", x),  ,drop = FALSE] )
}


#' Remove Empty Rows in a Data Frame
#' 
#' \code{drop_NA} - Removes the \code{NA} rows of a data set.
#' 
#' @return \code{drop_NA} - returns a dataframe with \code{NA} rows removed.
#' @rdname drop_row
#' @export
drop_NA <- function(dataframe, column = TRUE, ...){
    
    column <- detect_text_column(dataframe, column)
    
    dataframe[!is.na(dataframe[[column]]), ,drop = FALSE]
    
}





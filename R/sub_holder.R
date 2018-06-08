#' Hold the Place of Characters Prior to Subbing
#' 
#' This function holds the place for particular character values, allowing the 
#' user to manipulate the vector and then revert the place holders back to the 
#' original values.
#' 
#' @param x A character vector.
#' @param pattern Character string to be matched in the given character vector.
#' @param alpha.type logical.  If \code{TRUE} alpha (lower case letters) are 
#' used for the key.  If \code{FALSE} numbers are used as the key.
#' @param holder.prefix The prefix to use before the alpha key in the palce 
#' holder when \code{alpha.type = TRUE}; this ensures uniqueness.
#' @param holder.suffix The suffix to use after the alpha key in the palce 
#' holder when \code{alpha.type = TRUE}; this ensures uniqueness.
#' @param \dots Additional arguments passed to \code{\link[base]{gsub}}.
#' @return Returns a list with the following:
#' \item{output}{keyed place holder character vector} 
#' \item{unhold}{A function used to revert back to the original values}
#' @note The \code{unhold} function for \code{sub_holder} will only work on keys
#' that have not been disturbed by subsequent alterations.  The key follows the 
#' pattern of holder.prefix (`zzzplaceholder`) followed by lower case letter 
#' keys followed by holder.suffix (`zzz`) when \code{alpha.type = TRUE}, 
#' otherwise the holder is numeric.
#' @export
#' @examples
#' ## `alpha.type` as TRUE
#' library(lexicon); library(textshape)
#' (fake_dat <- paste(hash_emoticons[1:11, 1, with=FALSE][[1]], DATA$state))
#' (m <- sub_holder(fake_dat, hash_emoticons[[1]]))
#' m$unhold(strip(m$output))
#' 
#' ## `alpha.type` as FALSE (numeric keys)
#' vowels <- LETTERS[c(1, 5, 9, 15, 21)]
#' (m2 <- sub_holder(toupper(DATA$state), vowels, alpha.type = FALSE))
#' m2$unhold(gsub("[^0-9]", "", m2$output))
#' mtabulate(strsplit(m2$unhold(gsub("[^0-9]", "", m2$output)), ""))
sub_holder <- function(x, pattern, alpha.type = TRUE, 
    holder.prefix = 'zzzplaceholder', holder.suffix = 'zzz', ...) {

    if (!is.character(pattern)) pattern <- as.character(pattern)
    y <- length(pattern)

    if (alpha.type) {
  
        # counter <- 0
        # while(y > 26) {
        #     y <- y/26
        #     counter <- counter + 1
        # }
        # if (y > 0) counter <- counter + 1
 
        ## replaced the above:https://www.youtube.com/watch?v=zJmTJR6s4QU
        counter <- max(ceiling(log(y, 26)), 0L)
    
        keys <- apply(
            expand.grid(lapply(seq_len(counter), function(i) letters)), 
            1, 
            paste, 
            collapse=""
        )[seq_len(y)]
        reps <- paste0(holder.prefix, keys, holder.suffix)
    } else {
        counter <- NULL
        keys <- reps <- seq_len(y)
    }

    if (!is.null(counter) && counter == 0) {
        output <- x
    } else {
        output <- mgsub(x, pattern, reps, ...)
    }


    FUN <- function(x, ...) {
        mgsub(x, reps, pattern, ...)
    }

    out <- list(output = output, unhold = FUN)

    attributes(out) <- list(
        class = c("sub_holder", "list"), 
        names = names(out),
        pattern = pattern, 
        keys = keys, 
        len = y
    )
    out

}


#' Prints a sub_holder object
#' 
#' Prints a sub_holder object
#' 
#' @param x The sub_holder object
#' @param \ldots ignored
#' @export
#' @method print sub_holder
print.sub_holder <- function(x, ...) {
    print(x[["output"]])
}

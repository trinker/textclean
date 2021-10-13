#' Replace Numbers With Text Representation
#' 
#' \code{replace_number} - Replaces numeric represented numbers with words 
#' (e.g., 1001 becomes one thousand one).
#' 
#' @param x The text variable.
#' @param num.paste logical.  If \code{FALSE} the elements of larger numbers are 
#' separated with spaces.  If \code{TRUE} the elements will be joined without 
#' spaces.
#' @param remove logical.  If \code{TRUE} numbers are removed from the text.
#' @param \ldots Other arguments passed to  \code{\link[english]{as.english}}
#' @return Returns a vector with numbers replaced.
#' @references Fox, J. (2005). Programmer's niche: How do you spell that number? 
#' R News. Vol. 5(1), pp. 51-55.
#' @note The user may want to use \code{\link[textclean]{replace_ordinal}} 
#' first to remove ordinal number notation.  For example 
#' \code{\link[textclean]{replace_number}} would turn "21st" into 
#' "twenty onest", whereas \code{\link[textclean]{replace_ordinal}} would 
#' generate "twenty first".
#' @keywords number-to-word
#' @rdname replace_number
#' @export
#' @examples
#' x <- c(
#'     NA, 
#'     'then .456 good', 
#'     'none', 
#'     "I like 346,457 ice cream cones.", 
#'     "I like 123456789 cashes.",     
#'     "They are 99 percent good and 45678.2345667"
#' )
#' replace_number(x)
#' replace_number(x, num.paste = TRUE)
#' replace_number(x, remove=TRUE)
#' \dontrun{
#' library(textclean)
#' hunthou <- replace_number(seq_len(1e5)) 
#' 
#' textclean::mgsub(
#'     "'twenty thousand three hundred five' into 20305", 
#'     hunthou, 
#'     seq_len(1e5)
#' )
#' ## "'20305' into 20305"
#' 
#' ## Larger example from: https://stackoverflow.com/q/18332463/1000343
#' ## A slower approach
#' fivehunthou <- replace_number(seq_len(5e5)) 
#' 
#' testvect <- c("fifty seven", "four hundred fifty seven", 
#'     "six thousand four hundred fifty seven", 
#'     "forty six thousand four hundred fifty seven", 
#'     "forty six thousand four hundred fifty seven", 
#'     "three hundred forty six thousand four hundred fifty seven"
#' )
#' 
#' textclean::mgsub(testvect, fivehunthou, seq_len(5e5))
#' 
#' as_ordinal(1:10)
#' textclean::mgsub('I want to be 1 in line', 1:10, as_ordinal(1:10))
#' }
replace_number  <- function(x, num.paste = FALSE, remove = FALSE, ...) {

    if (is.numeric(x)){    
        x <- drop_sci_note(x) ## ensures scientific notation is not used
    } else {
        x <- as.character(x)    
    }

    if (remove) return(stringi::stri_replace_all_regex(x, num_regex, ""))

    ## extract the numbers
    to_replace <- stringi::stri_extract_all_regex(x, num_regex)
    
    
# browser()
    ## locations of the number strings
    locs <- which(!sapply2(to_replace, function(x) length(x) == 1 && is.na(x)))

    ## find locations of decimals
    decimal_locs <- lapply(to_replace[locs], stringi::stri_detect_regex, "\\.")

    ## get the numbers/texts tht correspond to number strings
    replaces <- to_replace[locs]

    ## lengths of the replacements lists so that it can be  
    ## unlisted and then relisted later
    lens <- lengths(replaces)
# browser()
    ## Data frame of the number text.  
    ## This will be disected and put back together
    num_df <- data.frame(
        num = gsub(",", "", unlist(replaces)), 
        stringsAsFactors = FALSE
    )
    
    num_df[['decimal']] <- unlist(
        stringi::stri_extract_all_regex(num_df[[1]], "\\.\\d+")
    )
    
    num_df[['integer']] <- floor(as.numeric(num_df[[1]]))
    num_df[['den']] <- num_df[['den1']] <- 10 ^ (nchar(num_df[['decimal']])- 1)
    
    num_df[['den']][!is.na(num_df[['den']])] <- paste0(
        eng(num_df[['den']][!is.na(num_df[['den']])], ...), 'ths'
    ) 
    
    num_df[['numerator']] <- eng(
        num_df[['den1']] * as.numeric(num_df[['decimal']]), ...
    )
    
    num_df[['den']][is.na(num_df[['den']])] <- ""
    num_df[['int']] <- eng(num_df[['integer']], ...)
    
    is_decimal <- grepl("\\.", num_df[[1]], perl = TRUE)  
    not_integer_decimal <- !grepl('\\d\\.', num_df[[1]], perl = TRUE)

    num_df[['int']][is_decimal & not_integer_decimal] <- ifelse(grepl('^minus', num_df[['int']][is_decimal & not_integer_decimal]), 'minus', "")
    
    num_df[['numerator']][!not_integer_decimal] <- paste(
        'and', num_df[['numerator']][!not_integer_decimal]
    )

    ## the replacements to swap in
    replaces2 <- trimws(paste(
        num_df[['int']], num_df[['numerator']], num_df[['den']]
    ))
    if (num.paste) replaces2 <- gsub("\\s+", "", replaces2)

    ## Reconvert to the original list shape that matches replaces
    replaces2 <- textshape::split_index(replaces2, textshape::starts(lens))

    ## for loop to do the gsubbing
    for (i in seq_along(locs)) {
        x[locs[i]] <- mgsub(x[locs[i]], replaces[[i]], replaces2[[i]])
    }
    x
}

num_regex <- paste0(
    "(?<=^| )-?.?\\d+(?:\\d+)?(?= |\\.?$)|", 
    "(?<=^| )-?\\d+(?:\\.\\d+)?(?= |\\.?$)|",
    "\\d+(?:,\\d{3})+(\\.\\d+)*"
)

eng <- function(x, ...) as.character(english::as.english(x, ...))


#' Replace Numbers With Text Representation
#' 
#' \code{as_ordinal} - A convenience wrapper for \code{english::ordinal} that 
#' takes integers and converts them to ordinal form.
#' 
#' @rdname replace_number
#' @export
as_ordinal <- function(x, ...){
    english::ordinal(x)
}



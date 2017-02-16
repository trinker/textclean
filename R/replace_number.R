#' Replace Numbers With Text Representation
#' 
#' Replaces numeric represented numbers with words (e.g., 1001 becomes one 
#' thousand one).
#' 
#' @param x The text variable.
#' @param num.paste logical.  If \code{FALSE} the elements of larger numbers are 
#' separated with spaces.  If \code{TRUE} the elements will be joined without 
#' spaces.
#' @param remove logical.  If \code{TRUE} numbers are removed from the text.
#' @param \ldots Other arguments passed to  \code{\link[english]{as.english}}
#' @return Returns a vector with abbreviations replaced.
#' @references Fox, J. (2005). Programmer's niche: How do you spell that number? 
#' R News. Vol. 5(1), pp. 51-55.
#' @note The user may want to use \code{\link[textclean]{replace_ordinal}} first to 
#' remove ordinal number notation.  For example \code{\link[textclean]{replace_number}}
#' would turn "21st" into "twenty onest", whereas \code{\link[textclean]{replace_ordinal}}
#' would generate "twenty first".
#' @keywords number-to-word
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
replace_number  <- function(x, num.paste = FALSE, remove = FALSE, ...) {

    if (remove) return(stringi::stri_replace_all_regex(x, num_regex, ""))

    ## extract the numbers
    to_replace <- stringi::stri_extract_all_regex(x, num_regex)

    ## locations of the number strings
    locs <- which(!sapply(to_replace, function(x) length(x) == 1 && is.na(x)))

    ## find locations of decimals
    decimal_locs <- lapply(to_replace[locs], stringi::stri_detect_regex, "\\.")

    ## get the numbers/texts tht correspond to number strings
    replaces <- to_replace[locs]

    ## lengths of the replacements lists so that it can be  
    ## unlisted and then relisted later
    lens <- sapply(replaces, length)

    ## Data frame of the number text.  
    ## This will be disected and put back together
    num_df <- data.frame(
        num = gsub(",", "", unlist(replaces)), 
        stringsAsFactors = FALSE
    )
    num_df[['decimal']] <- unlist(stringi::stri_extract_all_regex(num_df[[1]], "\\.\\d+"))
    num_df[['integer']] <- floor(as.numeric(num_df[[1]]) )
    num_df[['den']] <- num_df[['den1']] <- 10 ^ (nchar(num_df[['decimal']])- 1)
    num_df[['den']][!is.na(num_df[['den']])] <- paste0(eng(num_df[['den']][!is.na(num_df[['den']])], ...), 'ths') 
    num_df[['numerator']] <- eng(num_df[['den1']] * as.numeric(num_df[['decimal']]), ...)
    num_df[['den']][is.na(num_df[['den']])] <- ""
    num_df[['int']] <- eng(num_df[['integer']], ...)
    is_decimal <- grepl("\\.", num_df[[1]])  
    not_integer_decimal <- !grepl('\\d\\.', num_df[[1]])
    num_df[['int']][is_decimal & not_integer_decimal] <- ""
    num_df[['numerator']][!not_integer_decimal] <- paste('and', num_df[['numerator']][!not_integer_decimal])

    ## the replacements to swap in
    replaces2 <- trimws(paste(num_df[['int']], num_df[['numerator']], num_df[['den']]))
    if (num.paste) replaces2 <- gsub("\\s+", "", replaces2)

    ## Reconvert to the original list shape that matches replaces
    replaces2 <- textshape::split_index(replaces2, textshape::starts(lens))

    ## for loop to do the gsubbing
    for (i in seq_along(locs)) {
        x[locs[i]] <- mgsub(x[locs[i]], replaces[[i]], replaces2[[i]])
    }
    x
}

num_regex <- "(?<=^| )[-.]*\\d+(?:\\.\\d+)?(?= |\\.?$)|\\d+(?:,\\d{3})+(\\.\\d+)*"
eng <- function(x, ...) as.character(english::as.english(x, ...))



## 
## replace_number  <-
## function(x, num.paste = FALSE, remove = FALSE) {
## 
##     if (remove) return(gsub("[0-9]", "", x))
## 
##     ones <- c("zero", "one", "two", "three", "four", "five", "six", "seven", 
##         "eight", "nine") 
## 
##     num.paste <- ifelse(num.paste, "combine", "separate")
##  
##     unlist(lapply(lapply(gsub(",([0-9])", "\\1", x), function(x) {
##             if (!is.na(x) & length(unlist(strsplit(x, 
##                 "([0-9])", perl = TRUE))) > 1) {
##                 num_sub(x, num.paste = num.paste)
##             } else {
##                 x
##             }
##         }
##     ), mgsub, 0:9, ones))
##     
## }
## 
## ## Helper function to convert numbers
## numb2word <- function(x){ 
##     helper <- function(x){ 
##         digits <- rev(strsplit(as.character(x), "")[[1]]) 
##         nDigits <- length(digits) 
##         if (nDigits == 1) as.vector(ones[digits]) 
##         else if (nDigits == 2) 
##             if (x <= 19) as.vector(teens[digits[1]]) 
##                 else trim(paste(tens[digits[2]], 
##     Recall(as.numeric(digits[1])))) 
##         else if (nDigits == 3) trim(paste(ones[digits[3]], "hundred", 
##             Recall(makeNumber(digits[2:1])))) 
##         else { 
##             nSuffix <- ((nDigits + 2) %/% 3) - 1 
##             if (nSuffix > length(suffixes)) stop(paste(x, "is too large!")) 
##             trim(paste(Recall(makeNumber(digits[ 
##                 nDigits:(3*nSuffix + 1)])), 
##                 suffixes[nSuffix], 
##                 Recall(makeNumber(digits[(3*nSuffix):1])))) 
##             } 
##         } 
##     trim <- function(text){ 
##         gsub("^\ ", "", gsub("\ *$", "", text)) 
##         } 
##     makeNumber <- function(...) as.numeric(paste(..., collapse="")) 
##     opts <- options(scipen=100) 
##     on.exit(options(opts)) 
##     ones <- c("", "one", "two", "three", "four", "five", "six", "seven", 
##         "eight", "nine") 
##     names(ones) <- 0:9 
##     teens <- c("ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", 
##         "sixteen", " seventeen", "eighteen", "nineteen") 
##     names(teens) <- 0:9 
##     tens <- c("twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", 
##         "ninety") 
##     names(tens) <- 2:9 
##     x <- round(x) 
##     suffixes <- c("thousand", "million", "billion", "trillion", "quadrillion",
##         "quintillion", "sextillion", "septillion", "octillion", "nonillion",
##         "decillion", "undecillion", "duodecillion", "tredecillion", 
##         "quattuordecillion") 
##     if (length(x) > 1) return(sapply(x, helper)) 
##     helper(x) 
## }  
## 
## ## Helper function to sub out numbers
## num_sub <- function(x, num.paste) {
##     len <- attributes(gregexpr("[[:digit:]]+", x)[[1]])$match.length
##     pos <- c(gregexpr("[[:digit:]]+", x)[[1]])
##     values <- substring(x, pos, pos + len - 1)
##     pos.end <- pos + len - 1
##     replacements <- sapply(values, function(x) numb2word(as.numeric(x)))      
##     replacements <- switch(num.paste,
##         separate = replacements,
##         combine =  sapply(replacements, function(x)gsub(" ", "", x)),
##         stop("Invalid num.paste argument"))
##     numDF <- unique(data.frame(symbol = names(replacements), 
##         text = replacements))
##     rownames(numDF) <- 1:nrow(numDF)       
##     pat <- paste(numDF[, "symbol"], collapse = "|")
##     repeat {
##         m <- regexpr(pat, x)
##         if (m == -1) 
##             break
##         sym <- regmatches(x, m)
##         regmatches(x, m) <- numDF[match(sym, numDF[, "symbol"]), 
##             "text"]
##     }
##     return(x)
## }


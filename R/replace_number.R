#' Replace Numbers With Text Representation
#' 
#' Replaces numeric represented numbers with words (e.g., 1001 becomes one 
#' thousand one).
#' 
#' @param x  The text variable.
#' @param num.paste logical.  If \code{TRUE} a the elements of larger numbers are 
#' separated with spaces.  If \code{FALSE} the elements will be joined without 
#' spaces.
#' @param remove logical.  If \code{TRUE} numbers are removed from the text.
#' @return Returns a vector with abbreviations replaced.
#' @references Fox, J. (2005). Programmer's niche: How do you spell that number? 
#' R News. Vol. 5(1), pp. 51-55.
#' @note The user may want to use \code{\link[qdap]{replace_ordinal}} first to 
#' remove ordinal number notation.  For example \code{\link[qdap]{replace_number}}
#' would turn "21st" into "twenty onest", whereas \code{\link[qdap]{replace_ordinal}}
#' would generate "twenty first".
#' @keywords number-to-word
#' @export
#' @examples
#' x <- c("I like 346,457 ice cream cones.", "They are 99 percent good")
#' y <- c("I like 346457 ice cream cones.", "They are 99 percent good")
#' replace_number(x)
#' replace_number(y)
#' replace_number(x, FALSE)
#' replace_number(x, remove=TRUE)
replace_number  <-
function(x, num.paste = TRUE, remove = FALSE) {

    if (remove) return(gsub("[0-9]", "", x))

    ones <- c("zero", "one", "two", "three", "four", "five", "six", "seven", 
        "eight", "nine") 

    num.paste <- ifelse(num.paste, "separate", "combine")
 
    unlist(lapply(lapply(gsub(",([0-9])", "\\1", x), function(x) {
            if (!is.na(x) & length(unlist(strsplit(x, 
                "([0-9])", perl = TRUE))) > 1) {
                num_sub(x, num.paste = num.paste)
            } else {
                x
            }
        }
    ), mgsub, 0:9, ones))
    
}

## Helper function to convert numbers
numb2word <- function(x){ 
    helper <- function(x){ 
        digits <- rev(strsplit(as.character(x), "")[[1]]) 
        nDigits <- length(digits) 
        if (nDigits == 1) as.vector(ones[digits]) 
        else if (nDigits == 2) 
            if (x <= 19) as.vector(teens[digits[1]]) 
                else trim(paste(tens[digits[2]], 
    Recall(as.numeric(digits[1])))) 
        else if (nDigits == 3) trim(paste(ones[digits[3]], "hundred", 
            Recall(makeNumber(digits[2:1])))) 
        else { 
            nSuffix <- ((nDigits + 2) %/% 3) - 1 
            if (nSuffix > length(suffixes)) stop(paste(x, "is too large!")) 
            trim(paste(Recall(makeNumber(digits[ 
                nDigits:(3*nSuffix + 1)])), 
                suffixes[nSuffix], 
                Recall(makeNumber(digits[(3*nSuffix):1])))) 
            } 
        } 
    trim <- function(text){ 
        gsub("^\ ", "", gsub("\ *$", "", text)) 
        } 
    makeNumber <- function(...) as.numeric(paste(..., collapse="")) 
    opts <- options(scipen=100) 
    on.exit(options(opts)) 
    ones <- c("", "one", "two", "three", "four", "five", "six", "seven", 
        "eight", "nine") 
    names(ones) <- 0:9 
    teens <- c("ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", 
        "sixteen", " seventeen", "eighteen", "nineteen") 
    names(teens) <- 0:9 
    tens <- c("twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", 
        "ninety") 
    names(tens) <- 2:9 
    x <- round(x) 
    suffixes <- c("thousand", "million", "billion", "trillion", "quadrillion",
        "quintillion", "sextillion", "septillion", "octillion", "nonillion",
        "decillion", "undecillion", "duodecillion", "tredecillion", 
        "quattuordecillion") 
    if (length(x) > 1) return(sapply(x, helper)) 
    helper(x) 
}  

## Helper function to sub out numbers
num_sub <- function(x, num.paste) {
    len <- attributes(gregexpr("[[:digit:]]+", x)[[1]])$match.length
    pos <- c(gregexpr("[[:digit:]]+", x)[[1]])
    values <- substring(x, pos, pos + len - 1)
    pos.end <- pos + len - 1
    replacements <- sapply(values, function(x) numb2word(as.numeric(x)))      
    replacements <- switch(num.paste,
        separate = replacements,
        combine =  sapply(replacements, function(x)gsub(" ", "", x)),
        stop("Invalid num.paste argument"))
    numDF <- unique(data.frame(symbol = names(replacements), 
        text = replacements))
    rownames(numDF) <- 1:nrow(numDF)       
    pat <- paste(numDF[, "symbol"], collapse = "|")
    repeat {
        m <- regexpr(pat, x)
        if (m == -1) 
            break
        sym <- regmatches(x, m)
        regmatches(x, m) <- numDF[match(sym, numDF[, "symbol"]), 
            "text"]
    }
    return(x)
}

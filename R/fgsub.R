#' Replace a Regex with an Functional Operation on the Regex Match
#' 
#' This is a stripped down version of \code{gsubfn} from the \pkg{gsubfn} 
#' package.  It finds a regex match, and then uses a function to operate on
#' these matches and uses them to replace the original matches.  Note that
#' the \pkg{stringi} packages is used for matching and extracting the regex 
#' matches.  For more powerful or flexible needs please see the \pkg{gsubfn} 
#' package.
#' 
#' @param x A character vector.
#' @param pattern Character string to be matched in the given character vector. 
#' @param fun A function to operate on the extracted matches.
#' @param \ldots ignored.
#' @return Returns a vector with the pattern replaced.
#' @export
#' @importFrom data.table :=
#' @seealso \code{\link[gsubfn]{gsubfn}}
#' @examples 
#' ## In this example the regex looks for words that contain a lower case letter 
#' ## followed by the same letter at least 2 more times.  It then extracts these
#' ## words, splits them appart into letters, reverses the string, pastes them
#' ## back together, wraps them with double angle braces, and then puts them back 
#' ## at the original locations.
#' fgsub(
#'     x = c(NA, 'df dft sdf', 'sd fdggg sd dfhhh d', 'ddd'),
#'     pattern = "\\b\\w*([a-z])(\\1{2,})\\w*\\b",
#'     fun = function(x) {
#'         paste0('<<', paste(rev(strsplit(x, '')[[1]]), collapse =''), '>>')
#'     }    
#' )
#' 
#' ## In this example we extract numbers, strip out non-digits, coerce them to 
#' ## numeric, cut them in half, round up to the closest integer, add the commas 
#' ## back, and replace back into the original locations.
#' fgsub(
#'     x = c(NA, 'I want 32 grapes', 'he wants 4 ice creams', 
#'         'they want 1,234,567 dollars'
#'     ),
#'     pattern = "[\\d,]+",
#'     fun = function(x) {
#'         prettyNum(
#'             ceiling(as.numeric(gsub('[^0-9]', '', x))/2), 
#'             big.mark = ','
#'         )
#'     }    
#' )
#' 
#' ## In this example we extract leading zeros, convert to an equal number of 
#' ## spaces. 
#' fgsub(
#'     x = c(NA, "00:04", "00:08", "00:01", "06:14", "00:02", "00:04"),
#'     pattern = '^0+',
#'     fun = function(x) {gsub('0', ' ', x)}
#' )
fgsub <- function(x, pattern, fun, ...){

    hit_id <- pattern_id <- pat <- NULL
    
    locs <- stringi::stri_detect_regex(x, pattern)
    locs[is.na(locs)] <- FALSE
    txt <- x[locs]

    hits <- stringi::stri_extract_all_regex(txt, pattern)
    
    ## Make unique replacement substrings
    h <- lengths(hits)
    y <- sum(h)
    if (y == 0) return(x)
    counter <- ceiling(y/26)

    ## Make a replacement key
    pats <- unique(unlist(hits))
    reps <- paste0("textcleanholder", seq_along(pats), "textcleanholder")
    freps <- unlist(lapply(pats, fun))

    pat_key <- data.table::data.table(pat = reps, replacement = freps)
    
    hit_key <- data.table::data.table(
        hit_id = rep(seq_len(length(h)), h),
        pat = reps,
        pattern_id = unlist(lapply(h, seq_len))
    )
    
    data.table::setkey(pat_key, pat)
    data.table::setkey(hit_key, pat)
    
    hit_key <- hit_key[pat_key][, 
        hit_id := as.integer(hit_id)][, 
        pattern_id := as.integer(pattern_id)]
    
    data.table::setorderv(hit_key, cols = c('hit_id', 'pattern_id'))

    ## Loop through and replace the first pattern in each element with a unique 
    ## replacement substring
    for (i in seq_len(y)) {
        
        hkr <- hit_key[i,]
        
        txt[hkr[, 'hit_id'][[1]]] <- sub(
            pattern, 
            hkr[, 'pat'][[1]], 
            txt[hkr[, 'hit_id'][[1]]], 
            perl = TRUE
        )
        
    }

    ## Because the unique repalcment substrings are so unlikely to have a 
    ## collision, we can use fixed = TRUE and be very quick here
    txt <- mgsub(txt, hit_key[['pat']],  hit_key[['replacement']], fixed = TRUE, ...)
    
    x[locs] <- txt
    x

}

## defunct version 2018-06-06
# fgsub <- function(x, pattern, fun, ...){
# 
#     hit_id <- pattern_id <- pat <- NULL
#     
#     locs <- stringi::stri_detect_regex(x, pattern)
#     locs[is.na(locs)] <- FALSE
#     txt <- x[locs]
# 
#     hits <- stringi::stri_extract_all_regex(txt, pattern)
#     
# 
#     pats <- unique(unlist(hits))
#     reps <- paste0("textcleanholder", seq_along(pats), "textcleanholder")
#     freps <- unlist(lapply(pats, fun))
# 
#     pat_key <- data.table::data.table(pat = pats, replacement = freps)
#     
#     hit_key <- textshape::tidy_list(
#         set_names(
#             lapply(hits, function(x) set_names(x, seq_along(x))), 
#             seq_along(hits)
#         ),
#         'hit_id', 'pat', 'pattern_id'
#     )
#     
# 
#     data.table::setkey(pat_key, pat)
#     data.table::setkey(hit_key, pat)
#     
#     hit_key <- hit_key[pat_key][, 
#         hit_id := as.integer(hit_id)][, 
#         pattern_id := as.integer(pattern_id)]
#     
#     data.table::setorderv(hit_key, cols = c('hit_id', 'pattern_id'))
# 
#     for (i in seq_len(nrow(hit_key))) {
#         hkr <- hit_key[i,]     
#         hkr[, 'pattern_id'][[1]]
#         txt[hkr[, 'hit_id'][[1]]] <- sub(
#             hkr[, 'pat'][[1]], 
#             hkr[, 'replacement'][[1]], 
#             txt[hkr[, 'hit_id'][[1]]], 
#             perl = TRUE
#         )
#     }
#         
#     x[locs] <- txt
#     x
# 
# }

## old version removed 2018-06-01
# fgsub <- function(x, pattern, fun, ...){
#     
#     locs <- stringi::stri_detect_regex(x, pattern)
#     locs[is.na(locs)] <- FALSE
#     txt <- x[locs]
#     
#     hits <- stringi::stri_extract_all_regex(txt, pattern)
#     pats <- unique(unlist(hits))
#     reps <- paste0('textcleanholder', seq_along(pats), 'textcleanholder')
#     freps <- unlist(lapply(pats, fun))
#         
#     txt <- mgsub(txt, pats, reps)
#     
#     x[locs] <- mgsub(txt, reps, freps)
#     x
# 
# }

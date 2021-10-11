#' Detect/Locate Potential Non-Normalized Text 
#' 
#' Detect/Locate potential issues with text data.  This family of functions 
#' generates a list of detections/location functions that can be accessed via 
#' the dollar sign or square bracket operators.  Accessible functions include:
#' 
#' \describe{
#'   \item{contraction}{Contains contractions}
#'   \item{date}{Contains dates}
#'   \item{digit}{Contains digits}
#'   \item{email}{Contains email addresses}
#'   \item{emoticon}{Contains emoticons}
#'   \item{empty}{Contains just white space}
#'   \item{escaped}{Contains escaped backslash character}
#'   \item{hash}{Contains Twitter style hash tags}
#'   \item{html}{Contains html mark-up}
#'   \item{incomplete}{Contains incomplete sentences (e.g., ends with ...)}
#'   \item{kern}{Contains kerning (e.g. "The B O M B!")}
#'   \item{list_column}{Is a list of atomic vectors (Not provided by \code{which_are}))}
#'   \item{misspelled}{Contains potentially misspelled words}
#'   \item{no_endmark}{Contains a sentence with no ending punctuation}
#'   \item{no_space_after_comma}{Contains commas with no space after them}
#'   \item{non_ascii}{Contains non-ASCII characters}
#'   \item{non_character}{Is a non-character vector (Not provided by \code{which_are}))}
#'   \item{non_split_sentence}{Contains non split sentences}
#'   \item{tag}{Contains a Twitter style handle used to tag others (use of the at symbol)}
#'   \item{time}{Contains a time stamp}
#'   \item{url}{Contains a URL}
#' }
#' 
#' The functions above that have a description starting with 'is' rather than 'contains'
#' are meta functions that describe the attribute of the column/vector being passed
#' rather than attributes about the individual elements of the column/vector.  The
#' meta functions will return a logical of length one and are not available under
#' \code{which_are}.
#' 
#' @return \code{which_are} returns an environment of functions that can be used to 
#' locate and return the integer locations of the particular non-normalized text
#' named by the function.
#' @export
#' @include replace_html.R
#' @rdname which_are
#' @examples
#' wa <- which_are()
#' it <- is_it()
#' wa$digit(c('The dog',  "I like 2", NA))
#' it$digit(c('The dog',  "I like 2", NA))
#' 
#' is_it()$list_column(c('the dog', 'ate the chicken'))
#' 
which_are <- function(){
    
    funs <- is_it()
    nms <- ls(funs)[!ls(funs) %in% meta_funs]

    funs <- mget(nms, funs) #funs[!names(funs) %in% meta_funs]
  
    out <- list2env(stats::setNames(Map(function(f, nm){
        function(x) {
            
            out <- f(x)
            atts <- attributes(out)[!names(attributes(out)) %in% 'class']
            out <- which(out) 

            set_class(out, nm, atts)
        }
    }, funs, names(funs)), names(funs)))
    
    class(out) <- 'which_are'
    attributes(out)[['functions']] <- names(funs)
    out
    
}

set_class <- function(x, nms, atts){
    
    class(x) <- c('which_are_locs', class(x))    
    attributes(x)[['fun']] <- nms
    
    if (!is.null(atts)) {
        
        for (i in seq_along(atts)){
            attributes(x)[[names(atts)[i]]] <- atts[[i]]    
        }
        
    }
    
    x
}


#' @return \code{is_it} returns an environment of functions that can be used to 
#' detect and return a logical atomic vector of equal length to the input vector
#' (except for meta functions) of the particular non-normalized text
#' named by the function.
#' @export
#' @rdname which_are
is_it <- function(){
    out <- list2env(stats::setNames(lapply(is_funs, match.fun), is_funs), 
        hash = FALSE)
    class(out) <- 'is_it'
    attributes(out)[['functions']] <- is_funs
    out
}



#' Prints a which_are_locs Object
#' 
#' Prints a which_are_locs object
#' 
#' @param x A which_are_locs object 
#' @param n The number of affected elements to print out (the rest are 
#' truncated)
#' @param file Path to an external file to print to
#' @param \ldots ignored.
#' @method print which_are_locs
#' @export
print.which_are_locs <- function(x, n = 100, file = NULL, ...){
   
    x <- rm_class(x, 'which_are_locs')
    if (is.null(file)) file <- ''
    if (length(x) == 0) return(invisible(NULL))
    parts <- .checks[[attributes(x)[['fun']]]]
    
    problem <- sprintf("\nThe following observations %s:\n", parts[['problem']])
    affected <- truncated(x, n)
    solution <- paste("\n*Suggestion: Consider", parts[['fix']])
    
    cat(problem, affected, solution, sep ="\n", file = file)

}

truncated <- function(x, n = 100, ...){
    is_truncated <- length(x) > n
    if (is_truncated) x <- x[seq_len(n)]
    paste0(
        paste(x, collapse = ', '), 
        ifelse(is_truncated, '...[truncated]...', '')
    )
}

.checks <- list(
    
    contraction = list(
        fun = "contraction", 
        is_meta = FALSE, 
        problem = "contain contractions", 
        fix = "running `replace_contraction`"
    ),
    date = list(
        fun = "date", 
        is_meta = FALSE, 
        problem = "contain dates", 
        fix = "running `replace date`"
    ),
    digit = list(
        fun = "digit", 
        is_meta = FALSE, 
        problem = "contain digits/numbers", 
        fix = "using `replace_number`"
    ),
    email = list(
        fun = "email", 
        is_meta = FALSE, 
        problem = "contain email addresses", 
        fix = "using `replace_email`"
    ),
    emoticon = list(
        fun = "emoticon", 
        is_meta = FALSE, 
        problem = "contain emoticons", 
        fix = "using `replace_emoticons`"
    ),
    empty = list(
        fun = "empty", 
        is_meta = FALSE, 
        problem = "contain empty text cells (all white space)", 
        fix = "running `drop_empty_row`"
    ),
    escaped = list(
        fun = "escaped", 
        is_meta = FALSE, 
        problem = "contain escaped back spaced characters", 
        fix = "using `replace_white`"
    ),
    hash = list(
        fun = "hash", 
        is_meta = FALSE, 
        problem = "contain Twitter style hash tags (e.g., #rstats)", 
        fix = paste0(
            "using `qdapRegex::ex_tag' (to capture meta-data) and/", 
            "or replace_hash"
        )
    ),
    html = list(
        fun = "html", 
        is_meta = FALSE, 
        problem = "contain HTML markup", 
        fix =  "running `replace_html`"
    ),
    incomplete = list(
        fun = "incomplete", 
        is_meta = FALSE, 
        problem = paste(
            "contain incomplete sentences", 
            "(e.g., uses ending punctuation like '...')" 
        ),
        fix = "using `replace_incomplete`"
    ), 
    kern = list(
        fun = "kern", 
        is_meta = FALSE, 
        problem = "contain kerning (e.g., 'The B O M B!')", 
        fix = "using `replace_kern`"
    ),
    list_column = list(
        fun = "list_column", 
        is_meta = TRUE, 
        problem = "is a list column", 
        fix = paste0(
            "using `textclean::unnest_text`", 
            "\n             Also, consider rerunning `check_text` after fixing"
        )
    ),
    missing_value = list(
        fun = "missing_value", 
        is_meta = FALSE, 
        problem = "contain missing values", 
        fix = "running `drop_NA`"
    ),    
    misspelled = list(
        fun = "misspelled", 
        is_meta = FALSE, 
        problem = "contain potentially misspelled words", 
        fix = "running `hunspell::hunspell_find` & `hunspell::hunspell_suggest`"
    ),
    no_alpha = list(
        fun = "no_alpha", 
        is_meta = FALSE, 
        problem = "contain elements with no alphabetic (a-z) letters", 
        fix = "cleaning the raw text or running `filter_row`"
    ),
    no_endmark = list(
        fun = "no_endmark", 
        is_meta = FALSE, 
        problem = "contain elements with missing ending punctuation", 
        fix = "cleaning the raw text or running `add_missing_endmark`"
    ),
    no_space_after_comma = list(
        fun = "no_space_after_comma", 
        is_meta = FALSE, 
        problem = "contain commas with no space afterwards", 
        fix = "running `add_comma_space`"
    ),
    non_ascii = list(
        fun = "non_ascii", 
        is_meta = FALSE, 
        problem = "contain non-ASCII text", 
        fix = "running `replace_non_ascii`"
    ),
    non_character = list(
        fun = "non_character", 
        is_meta = TRUE, 
        problem = "is not a character column (likely `factor`)", 
        fix =  paste0(
            "using `as.character` or ", 
            "`stringsAsFactors = FALSE` when reading in", 
            "\n             Also, consider rerunning `check_text` after fixing"
        )
    ),
    non_split_sentence = list(
        fun = "non_split_sentence", 
        is_meta = FALSE, 
        problem = paste(
            "contain unsplit sentences", 
            "(more than one sentence per element)"
        ),
        fix = "running `textshape::split_sentence`"
    ),
    tag = list(
        fun = "tag", 
        is_meta = FALSE, 
        problem = "contain Twitter style handle tags (e.g., @trinker)", 
        fix = paste0(
            "using `qdapRegex::ex_tag' (to capture meta-data) and/", 
            "or `replace_tag`"
        )
    ),
    time = list(
        fun = "time", 
        is_meta = FALSE, 
        problem = "contain timestamps", 
        fix = "using `replace_time`"
    ),
    url = list(
        fun = "url", 
        is_meta = FALSE, 
        problem = "contain URLs", 
        fix = "using `replace_url`"
    )

)
 
#' @include utils.R
is_funs <- unname(sapply2(.checks, `[[`, 'fun'))
meta_funs <- unname(sapply2(.checks, `[[`, 'fun')[
    sapply2(.checks, `[[`, 'is_meta')]) 
elemental_funs <- unname(sapply2(.checks, `[[`, 'fun')[
    !sapply2(.checks, `[[`, 'is_meta')]) 




## a function generator to make search functions from the qdap
qr2fun <- function(pat){
    function(x){
        grepl(qdapRegex::grab(pat), x, perl=TRUE)
    }
}
    
## contains a contaction
contraction <- function(x){
    grepl(
        paste0(
            "([a-z]'(nt|t|ve|d|ll|m|re))|('(cause|tis|twas))|(\\b(he|how|it|",
            "let|she|that|there|what|when|where|who|why)'s)"
        ),
        x, ignore.case = TRUE, perl = TRUE
    )
}
#contraction(c('jon\'s a good man', "'cause I want to", '4was\'nt', 'the dog', 
# "I'm happy", "He's sad", "I here she's there", NA))

## dates
date <- qr2fun('rm_date')

## digits
digit <- function(x) {
    grepl('\\d', x, perl = TRUE)    
}

## email addresses
email <- qr2fun('rm_email')

## emoticons
emoticon <- qr2fun('rm_emoticon')


## just white space
empty <- function(x) {
    #any(grepl("^\\s*$", stats::na.omit(x)))
    grepl("^\\s*$", x, perl = TRUE)
}

## are there escaped backslashes
escaped <- function(x) {
    grepl("[\\\\]", x) & !grepl("\\\"|\\\'|\\\`", x, perl = TRUE)
}


## hash
hash <- qr2fun('rm_hash')


## contains html
html <- function(x) {
    pat <- paste0("<[^>]+>|", paste(html_symbols[['html']], collapse ="|"))
    grepl(pat, x, perl = TRUE)
}

## incomplete sentences usually indicated by 2-4 enmarks that are 
##  trailing (e.g., ...)
incomplete <- function(x) {
    pat <- paste0(
        "\\?*\\?[.]+|[.?!]*\\? [.][.?!]+|[.?!]*\\. [.?!]+|[.?!]+\\. [.?!]*|",
        "[.?!]+\\.[.?!]*|[.?!]*\\.[.?!]+"
    )
    grepl(pat, x, perl = TRUE)
}
   
## contains kerning
kern <- function(x) {
   grepl('(([A-Z]\\s+){2,}[A-Z])', x, perl = TRUE)
} 

## check if something is a list of vectors
list_column <-  function(x) {
    is.list(x) && all(sapply2(x, is.atomic))
}

## missing values
missing_value <- function(x){
    is.na(x)    
}


## mis-splelled words
misspelled <- function(x){
    
    check_install('hunspell')
    pot_spell <- try(
        eval(parse(text = "hunspell::hunspell_find(x)")), 
        silent = TRUE
    )
    
    if (inherits(pot_spell, 'try-error')) {
        pot_spell <- list(rep(character(0), length(x)))
    } 
    
    misspelled <- new.env(hash=FALSE)
    misspelled[["misspelled"]] <- unique(unname(unlist(pot_spell)))
    
    out <- unlist(lapply(pot_spell, function(x) length(x) != 0 ))
    class(out) <- 'misspelled'
    attributes(out)[["misspelled"]] <- misspelled
    out
}

## Does it have no letters
no_alpha <- function(x) {
    !is.na(x) & !grepl("[a-zA-Z]", x, perl = TRUE)
}


## is missing punctiuation
no_endmark <- function(x) {
    !has_endmark(x) & !is.na(x)
}

## is comma with no space
no_space_after_comma <- function(x) {
    grepl("(,)([^ ])", x, perl = TRUE)
}



## are there any non ascii characters
non_ascii <- function(x) {
    grepl("[^ -~]", x, perl = TRUE) & !is.na(x) & !grepl("^\\s*$", x, perl = TRUE)
}

## not character
non_character <- function(x) {
    !is.character(x) && !all(unlist(lapply(x, function(y) is.character(y) | 
            (length(y) == 1 && is.na(y)) )))
}

## unique sentences
non_split_sentence <- function(x) {
    lengths(textshape::split_sentence(x)) > 1
}

## tag addresses
tag <- qr2fun('rm_tag')


## time
time <- qr2fun('rm_time')

## url
url <- qr2fun('rm_url')



    
    









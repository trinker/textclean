#' Detect/Locate Potential Non-Normalized Text 
#' 
#' Detect/Locate potential issues with text data.  This family of function 
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
#' @return \code{which_are} returns a list of functions that can be used to 
#' locate and return the integer locations of the particular non-normalized text
#' named by the function.
#' @export
#' @rdname which_are
#' @examples
#' wa <- which_are()
#' it <- is_it()
#' wa$digit(c('The dog',  "I like 2", NA))
#' it$digit(c('The dog',  "I like 2", NA))
#' 
#' is_it()$list_column(c('the dog', 'ate the chicken'))
which_are <- function(){
    
    funs <- is_it()

    funs <- funs[!names(funs) %in% meta_funs]
    
    stats::setNames(lapply(funs, function(f){
        function(x) {
            out <- which(f(x)) 
            if (length(out) == 0) return(NULL)
            out
        }
    }), names(funs))
    
}


#' @return \code{is_it} returns a list of functions that can be used to 
#' detect and return a logical atomic vector of equal length to the input vector
#' (except for meta functions) of the particular non-normalized text
#' named by the function.
#' @export
#' @rdname which_are
is_it <- function(){
    stats::setNames(lapply(is_funs, match.fun), is_funs)
}


is_funs <- c(
    'contraction', 'date', 'digit', 'email', 'emoticon', 'empty', 'escaped', 
    'hash', 'html', 'incomplete', 'kern', 'list_column', 'missing', 'misspelled', 
    'no_alpha', 'no_endmark', 'no_space_after_comma', 'non_ascii', 'non_character', 
    'non_split_sentence', 'tag', 'time', 'url'
)

meta_funs <- c('list_column', 'non_character')


checks <- list(
    
    contraction = list(fun = "contraction", is_meta = FALSE, problem = "contains contractions", fix = "running `replace_contraction`"),
    date = list(fun = "date", is_meta = FALSE, problem = "contains dates", fix = "running `replace date`"),
    digit = list(fun = "digit", is_meta = FALSE, problem = "contains digits/numbers", fix = "using `replace_number`"),
    email = list(fun = "email", is_meta = FALSE, problem = "contains email addresses", fix = "using `replace_email`"),
    emoticon = list(fun = "emoticon", is_meta = FALSE, problem = "contains emoticons", fix = "using `replace_emoticons`"),
    empty = list(fun = "empty", is_meta = FALSE, problem = "contains empty text cells (all white space)", fix = "running `drop_empty_row`"),
    escaped = list(fun = "escaped", is_meta = FALSE, problem = "contains escaped back spaced characters", fix = "using `replace_white`"),
    hash = list(fun = "hash", is_meta = FALSE, problem = "contains Twitter style hash tags (e.g., #rstats)", fix = "using `qdapRegex::ex_tag' (to capture meta-data) and/or replace_hash"),
    html = list(fun = "html", is_meta = FALSE, problem = "", fix =  "running `replace_html`"),
    incomplete = list(fun = "incomplete", is_meta = FALSE, problem = "contains incomplete sentences (e.g., uses ending punctuation like ...)", fix = "using `replace_incomplete`"), 
    kern = list(fun = "kern", is_meta = FALSE, problem = "contains kerning (e.g., 'The B O M B!'", fix = "using `replace_kern`"),
    list_column = list(fun = "list_column", is_meta = TRUE, problem = "is a list column", fix = "using `textclean::unnest_text`"),
    missing_value = list(fun = "missing_value", is_meta = FALSE, problem = "contains missing values", fix = "running `drop_NA`"),    
    misspelled = list(fun = "misspelled", is_meta = FALSE, problem = "", fix = "running `hunspell::hunspell_find` & `hunspell::hunspell_suggest`"),
    no_alpha = list(fun = "no_alpha", is_meta = FALSE, problem = "contains elements with no alphabetic (a-z) letters", fix = "cleaning the raw text or running `filter_row`"),
    no_endmark = list(fun = "no_endmark", is_meta = FALSE, problem = "contains elements with missing ending punctuation", fix = "cleaning the raw text or running `add_missing_endmark`"),
    no_space_after_comma = list(fun = "no_space_after_comma", is_meta = FALSE, problem = "contains commas with no space afterwards", fix = "running `add_comma_space`"),
    non_ascii = list(fun = "non_ascii", is_meta = FALSE, problem = "contains non-ASCII text", fix = "running `replace_non_ascii`"),
    non_character = list(fun = "non_character", is_meta = TRUE, problem = "is not a character column (likely factor)", fix =  "using `as.character` or `stringsAsFactors = FALSE` when reading in"),
    non_split_sentence = list(fun = "non_split_sentence", is_meta = FALSE, problem = "contains unsplit sentences (more than one sentence per element)", fix = "running `textshape::split_sentence`"),
    tag = list(fun = "tag", is_meta = FALSE, problem = "contains Twitter style handle tags (e.g., @trinker)", fix = "using `qdapRegex::ex_tag' (to capture meta-data) and/or `replace_tag`"),
    time = list(fun = "time", is_meta = FALSE, problem = "contains timestamps", fix = "using `replace_time`"),
    url = list(fun = "url", is_meta = FALSE, problem = "contains URLs", fix = "using `replace_url`")

)
 


## a function generator to make search functions from the qdap
qr2fun <- function(pat){
    function(x){
        grepl(qdapRegex::grab(pat), x, perl=TRUE)
    }
}
    
## contains a contaction
contraction <- function(x){
    grepl(
        "([a-z]'(nt|t|ve|d|ll|m|re))|('(cause|tis|twas))|(\\b(he|how|it|let|she|that|there|what|when|where|who|why)'s)",
        x, ignore.case = TRUE
    )
}
#contraction(c('jon\'s a good man', "'cause I want to", '4was\'nt', 'the dog', "I'm happy", "He's sad", "I here she's there", NA))

## dates
date <- function(x) {
    grepl(replace_date_pattern, x)    
}


## digits
digit <- function(x) {
    grepl('\\d', x)    
}

## email addresses
email <- qr2fun('rm_email')

## emoticons
emoticon <- qr2fun('rm_emoticon')


## just white space
empty <- function(x) {
    any(grepl("^\\s*$", stats::na.omit(x)))
}

## are there escaped backslashes
escaped <- function(x) {
    grepl("[\\\\]", x) & !grepl("\\\"|\\\'|\\\`", x)
}


## hash
hash <- qr2fun('rm_hash')


## contains html
html <- function(x) {
    pat <- paste0("<[^>]+>|", paste(html_symbols[['html']], collapse ="|"))
    grepl(pat, x)
}

## incomplete sentences usually indicated by 2-4 enmarks that are trailing (e.g., ...)
incomplete <- function(x) {
    pat <- "\\?*\\?[.]+|[.?!]*\\? [.][.?!]+|[.?!]*\\. [.?!]+|[.?!]+\\. [.?!]*|[.?!]+\\.[.?!]*|[.?!]*\\.[.?!]+"
    grepl(pat, x)
}
   
## contains kerning
kern <- function(x) {
   grepl('(([A-Z]\\s+){2,}[A-Z])', x)
} 

## check if something is a list of vectors
list_column <-  function(x) {
    is.list(x) && all(sapply(x, is.atomic))
}

## missing values
missing <- function(x){
    is.na()    
}

## mis-splelled words
misspelled <- function(x){
    
    check_install('hunspell')
    pot_spell <- eval(parse(text = "hunspell::hunspell_find(x)")) 
    unlist(lapply(pot_spell, function(x) length(x) != 0 ))
    
}

## Does it have no letters
no_alpha <- function(x) {
    !is.na(x) & !grepl("[a-zA-Z]", x)
}


## is missing punctiuation
no_endmark <- function(x) {
    any(suppressWarnings(stats::na.omit(!has_endmark(x))))
}

## is comma with no space
no_space_after_comma <- function(x) {
    grepl("(,)([^ ])", x)
}



## are there any non ascii characters
non_ascii <- function(x) {
    grepl("[^ -~]", x) & !is.na(x) & !grepl("^\\s*$", x)
}

## not character
non_character <- function(x) {
    !is.character(x) 
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



    
    









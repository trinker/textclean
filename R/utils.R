abbr_rep <- lapply(list(
  Titles   = c('jr', 'mr', 'mrs', 'ms', 'dr', 'prof', 'sr', 'sen', 'rep',
         'rev', 'gov', 'atty', 'supt', 'det', 'rev', 'col','gen', 'lt',
         'cmdr', 'adm', 'capt', 'sgt', 'cpl', 'maj'),

  Entities = c('dept', 'univ', 'uni', 'assn', 'bros', 'inc', 'ltd', 'co',
         'corp', 'plc'),

  Months   = c('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul',
         'aug', 'sep', 'oct', 'nov', 'dec', 'sept'),

  Days     = c('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'),

  Misc     = c('vs', 'etc', 'no', 'esp', 'cf', 'al', 'mt'),

  Streets  = c('ave', 'bld', 'blvd', 'cl', 'ct', 'cres', 'dr', 'rd', 'st')
), function(x){
    fl <- sub("(^[a-z])(.+)", "\\1", x)
    sprintf("[%s%s]%s", fl, toupper(fl), sub("(^[a-z])(.+)", "\\2", x))
})

period_reg <- paste0(
    "(?:(?<=[a-z])\\.\\s(?=[a-z]\\.))",
        "|",
    "(?:(?<=([ .][a-z]))\\.)(?!(?:\\s[A-Z]|$)|(?:\\s\\s))",
        "|",
    "(?:(?<=[A-Z])\\.(?=\\s??[A-Z]\\.))",
        "|",
    "(?:(?<=[A-Z])\\.(?!\\s+[A-Z][A-Za-z]))"
)


sent_regex <- sprintf("((?<=\\b(%s))\\.)|%s|(%s)",
    paste(unlist(abbr_rep), collapse = "|"),
    period_reg,
	'\\.(?=\\d+)'
)


count_endmark <- function(x) {
    y <- stringi::stri_replace_all_regex(trimws(x), sent_regex, "<<<TEMP>>>")
    stringi::stri_count_regex(
        y, 
        paste0(
            "(?<!\\w\\.\\w.)(?<![A-Z][a-z]\\.)(?<=\\.|", 
            "\\?|\\!)(\\s|(?=[a-zA-Z][a-zA-Z]*\\s))"
        )
    )
}


check_install <- function(x, fun = 'function'){

    found <- TRUE
    path <- try(find.package(x), silent = TRUE)
    
    if (inherits(path, "try-error")) found <- FALSE

    if (!found) {
        if (interactive()){
            message(paste(x, "package not found.  Do you want to install?\n"))
            ans <- utils::menu(c("Yes", "No"))
            if (ans == "1") {
                utils::install.packages(x)
            } else {
                stop(
                    paste(
                        fun, 
                        'requires', 
                        x, 
                        'package to be install.  Please install before using.'
                    ), 
                    call. = FALSE, 
                )
            }   
        } else {
            stop(
                paste(
                    fun, 
                    'requires', 
                    x, 
                    'package to be install.  Please install before using.'
                ), 
                call. = FALSE
            )
        }     
    }

    path <- try(find.package(x), silent = TRUE)
    if (inherits(path, "try-error")) {
        stop(paste(
            'Could not install.', 
            fun, 
            'requires', 
            x, 
            'package to be installed.  Please install before using.'
        ), call. = FALSE)
    }  

}

.mgsub <- function (pattern, replacement, text.var, ...) {

    ord <- rev(order(nchar(pattern)))
    pattern <- pattern[ord]
    if (length(replacement) != 1) replacement <- replacement[ord]

    if (length(replacement) == 1) replacement <- rep(replacement, length(pattern))

    text.var <- stringi::stri_replace_all_fixed(text.var, pattern, replacement,
        vectorize_all=FALSE, opts_fixed = list(case_insensitive = TRUE)
    )

    text.var
}


replace_string_elements_generic  <- function(x, y, z = NULL, 
    ignore.case = FALSE, ...) {

    z_null <- is.null(z)
    if(isTRUE(z_null)) z <- 'replacermentfunctionstringholder'

    na_locs <- is.na(x)
    tokens <- textshape::split_token(x, lower = FALSE, ...)
    locs <- textshape::starts(lengths(tokens))[-1]

    tokens <- unlist(tokens)
    fun <- ifelse(ignore.case, tolower, c)
    #match(fun(tokens), fun(y))
    tokens[which(fun(tokens) %in% fun(y))] <- z

    replaced <- textshape::split_index(tokens, locs)
    replaced[na_locs] <- x[na_locs]
    replaced[!na_locs] <- unlist(lapply(replaced[!na_locs],function(x) {
         paste(x, collapse = " ")
    }))
    out <- unlist(replaced)

    if(isTRUE(z_null)) {
        out <- trimws(gsub("\\s+", " ", gsub(z, "", out, fixed = TRUE)))
    }

    gsub("(\\s+)([.!?,;:])", "\\2", out, perl = TRUE)
}


to_byte <- function(x){
    Encoding(x) <- "latin1"
    iconv(x, "latin1", "ASCII", "byte")
}


.fgsub <- function(x, pattern, fun, ...){
    

    hits <- stringi::stri_extract_all_regex(x, pattern)
    pats <- unique(unlist(hits))
    reps <- paste0('textcleanholder', seq_along(pats), 'textcleanholder')
    freps <- unlist(lapply(pats, fun))
        
    x <- mgsub(x, pats, reps)
    
    mgsub(x, reps, freps)

}


set_names <- function(x, nms){
    names(x) <- nms
    x
}

rm_na <- function(x) x[!is.na(x)]

rm_class <- function(x, cls){
    class(x) <- class(x)[!class(x) %in% cls]    
    x
}

## function to detect text columns
detect_text_column <- function(dat, text.var){
    
    if (isTRUE(text.var)) {
    
        dat <- as.data.frame(dat, stringsAsFactors = FALSE)
        
        mean_lens <- unlist(lapply(dat, function(y) {
         
            if(!is.character(y) && !is.factor(y)) return(0)
            mean(nchar(as.character(y)), na.rm = TRUE)
            
        }))
    
        max_cols <- which.max(mean_lens)
        
        text.var <- colnames(dat)[max_cols[1]]
        
        if (length(text.var) == 0 | sum(as.integer(mean_lens)) == 0) {
            stop(
                paste(
                    "Could not detect ` text.var`.", 
                    "Please supply `text.var` explicitly."
                ),
                call. = FALSE
            )
        }
        
        if (length(max_cols) > 1) {
            warning(
                sprintf(
                    'More than one text column detected...using `%s`', 
                    text.var
                ), 
                call. = FALSE
            )    
        }
    } 
    
    text.var
    
}

## safer type sapply
sapply2 <- function (X, FUN, ...) {
    unlist(lapply(X, FUN, ...))
}


avail <- lexicon::available_data

drop_sci_note <- function(x, ...){

    if (!is.numeric(x)) return(x)

    x <- as.character(as.numeric(x))

    locs <- grepl('e\\+', x, perl = TRUE)

    x[locs] <- unlist(Map(function(b, e) {

            subs <- nchar(gsub('^.*\\.', '', b))

            paste0(gsub('[.]', '', b), paste(rep('0', e - subs), collapse = ''))

        }, gsub('e\\+.+', '', x[locs]), as.integer(gsub('^.+?e\\+', '', x[locs]))
    ))


    x
}


#' Check Text For Potential Problems
#' 
#' \code{check_text} - Uncleaned text may result in errors, warnings, and 
#' incorrect results in subsequent analysis.  \code{check_text} checks text for 
#' potential problems and suggests possible fixes.  Potential text anomalies 
#' that are detected include: factors, missing ending punctuation, empty cells, 
#' double punctuation, non-space after comma, no alphabetic characters, 
#' non-ASCII, missing value, and potentially misspelled words.
#' 
#' @param x The text variable.
#' @param file A connection, or a character string naming the file to print to.  
#' If \code{NULL} prints to the console.  Note that this is assigned as an 
#' attribute and passed to \code{print}.
#' @param checks A vector of checks to include from \code{which_are}.  If 
#' \code{checks = NULL}, all checks from \code{which_are} which be used.  Note
#' that all meta checks will be conducted (see \code{which_are} for details on
#' meta checks).
#' @param n The number of affected elements to print out (the rest are truncated).
#' @param \ldots ignored.
#' @return Returns a list with the following potential text faults report:\cr
#' \itemize{
#'   \item{contraction}{- Text elements that contain contractions}
#'   \item{date}{- Text elements that contain dates}
#'   \item{digit}{- Text elements that contain digits/numbers}
#'   \item{email}{- Text elements that contain email addresses}
#'   \item{emoticon}{- Text elements that contain emoticons}
#'   \item{empty}{- Text elements that contain empty text cells (all white space)}
#'   \item{escaped}{- Text elements that contain escaped back spaced characters}
#'   \item{hash}{- Text elements that contain Twitter style hash tags (e.g., #rstats)}
#'   \item{html}{- Text elements that contain HTML markup}
#'   \item{incomplete}{- Text elements that contain incomplete sentences (e.g., uses ending punctuation like ...)}
#'   \item{kern}{- Text elements that contain kerning (e.g., 'The B O M B!')}
#'   \item{list_column}{- Text variable that is a list column}
#'   \item{missing_value}{- Text elements that contain missing values}
#'   \item{misspelled}{- Text elements that contain potentially misspelled words}
#'   \item{no_alpha}{- Text elements that contain elements with no alphabetic (a-z) letters}
#'   \item{no_endmark}{- Text elements that contain elements with missing ending punctuation}
#'   \item{no_space_after_comma}{- Text elements that contain commas with no space afterwards}
#'   \item{non_ascii}{- Text elements that contain non-ASCII text}
#'   \item{non_character}{- Text variable that is not a character column (likely \code{factor})}
#'   \item{non_split_sentence}{- Text elements that contain unsplit sentences (more than one sentence per element)}
#'   \item{tag}{- Text elements that contain Twitter style handle tags (e.g., @@trinker)}
#'   \item{time}{- Text elements that contain timestamps}
#'   \item{url}{- Text elements that contain URLs}
#' }
#' @note The output is a list containing meta checks and elemental checks
#' but prints as a pretty formatted output with potential problem elements, the 
#' accompanying text, and possible suggestions to fix the text.
#' @keywords check text spelling
#' @export
#' @include check_text_logicals.R
#' @rdname check_text
#' @examples
#' \dontrun{
#' v <- list(c('foo', 'bar'), NA, c('hello', 'world'))
#' check_text(v)
#' 
#' w <- factor(unlist(v))
#' check_text(w)
#' 
#' x <- c("i like", "<p>i want. </p>thet them ther .", "I am ! that|", "", NA, 
#'     "&quot;they&quot;,were there", ".", "   ", "?", "3;", "I like goud eggs!", 
#'     "i 4like...", "\\tgreat",  "She said \"yes\"")
#' check_text(x)
#' print(check_text(x), include.text=FALSE)
#' check_text(x, checks = c('non_split_sentence', 'no_endmark'))
#' elementals <- available_checks()[is_meta != TRUE,][['fun']]
#' check_text(
#'     x, 
#'     checks = elementals[
#'         !elementals %in% c('non_split_sentence', 'no_endmark')
#'     ]
#' )
#' 
#' y <- c("A valid sentence.", "yet another!")
#' check_text(y)
#' 
#' z <- rep('dfsdsd\'nt', 120)
#' check_text(z)
#' }
check_text <- function(x, file = NULL, checks = NULL, n = 10, ...) {

    if (is.data.frame(x)) stop("`x` is a data.frame.  Pass a text vector.")
    check_install('hunspell')
    
    ## meta checks
    metas <- mget(meta_funs, is_it())
    meta_checks <- lapply(metas, function(fun) {
        try(fun(x))
    })

    ## elemental checks
    elementals <- which_are()
    if (is.null(checks)) {
        checks <- ls(elementals)
    } else {
        checks <- checks[checks %in% ls(elementals)]
    }
    elementals <- mget(checks, elementals)
    elemental_checks <- lapply(elementals, function(fun) {
        try(fun(x))
    })    
    
    out <- list(meta_checks = meta_checks, elemental_checks = elemental_checks)

    text <- new.env(hash=FALSE)
    text[["text.var"]] <- x
    
    class(out) <- "check_text"
    attributes(out)[["text.var"]] <- text
    attributes(out)[["file"]] <- file
    attributes(out)[["n"]] <- n 
    out
    
}

# cat(sapply(.checks, function(x){
# 
#     frame <- ifelse(x$is_meta, "#'   \\item{%s}{- Text variable that %s}", 
#         "#'   \\item{%s}{- Text elements that %s}")
#     sprintf(frame, x$fun, x$problem)
# 
# }), sep = '\n', file = 'clipboard')
    
#' Check Text For Potential Problems
#' 
#' \code{available_check} - Provide a data.frame view of all the available 
#' checks in the \code{check_text} function. 
#' @rdname check_text
#' @export
available_checks <- function(){
    data.table::rbindlist(lapply(.checks, as.data.frame, 
        stringsAsFactors = FALSE))[, 'fix' := NULL][]
}
    
#' Prints a check_text Object
#' 
#' Prints a check_text object.
#' 
#' @param x The check_text object.
#' @param include.text logical.  If \code{TRUE} the offending text is printed as 
#' well.
#' @param file A connection, or a character string naming the file to print to.  
#' If \code{NULL} prints to the console.
#' @param n The number of affected elements to print out (the rest are 
#' truncated)
#' @param \ldots ignored
#' @method print check_text
#' @export
print.check_text <- function(x, include.text = TRUE, file = NULL, n = NULL, 
    ...) {

    if (is.null(file)) file <- force(attributes(x)[["file"]])
    file <- ifelse(is.null(file), "", file)

    if (is.null(n)) n <- force(attributes(x)[["n"]])
    n <- ifelse(is.null(n), 10, n)
    
    allgood <- sum(unlist(lapply(x[['meta_checks']], `[[`, 1))) == 0 &&
        sum(unlist(lapply(x[['elemental_checks']], length))) == 0
    
    if (allgood) {
        all_good()
        return(invisible(NULL))
    }
 
    txt.var <- force(attributes(x)[["text.var"]][["text.var"]])
    
    ## Print meta
    meta <- invisible(Map(function(e, nms, f){
    
        if (!isTRUE(e)) return(invisible(NULL))
        
        lns <- paste(rep("=", nchar(nms)), collapse="")
        parts <- .checks[[f]]
        problem <- sprintf("\nThe text variable %s:\n", parts[['problem']])
        solution <- paste("\n*Suggestion: Consider", parts[['fix']])
        
        c(paste0("\n", lns), nms, lns, problem, solution, "")
    }, 
        x[['meta_checks']], 
        gsub('_', ' ', toupper(names(x[['meta_checks']]))), 
        names(x[['meta_checks']])
    ))
    
    cat(
        unlist(meta), 
        sep ="\n", 
        file = file
    )
    
    ## Print elemental
    invisible(Map(function(e, nms){
     
        if (length(e) == 0) return(invisible(NULL))
        
        lns <- paste(rep("=", nchar(nms)), collapse="")

        parts <- .checks[[attributes(e)[['fun']]]]
   
        problem <- sprintf(
            "\nThe following observations %s:\n", 
            parts[['problem']]
        )
        
        affected <- truncated(e, n)
        solution <- paste("\n*Suggestion: Consider", parts[['fix']])
        
        if (isTRUE(include.text) && parts[['fun']] != "missing_value") {
            
            text_problem <- "\nThis issue affected the following text:\n"

            if (parts[['fun']] == "misspelled") {

                ## grab the misspelled words
                spelling <- attributes(e)[['misspelled']][['misspelled']]
                
                ## put angle braces around misspelled words
                txt.var[e] <- trimws(mgsub(
                    txt.var[e],
                    spelling,
                    paste0("<<", spelling, ">>")
                ))
            } 
            
            trunced <- ifelse(length(e) > n, '\n...[truncated]...', '')
            
            cat(
                c(
                    paste0("\n", lns), 
                    nms, lns, problem, affected, text_problem, 
                    paste0(
                        paste0(e, ": ", txt.var[e])[seq_len(min(n, length(e)))],
                        trunced
                    ), 
                    solution, ""
                ), 
                sep ="\n", 
                file = file,
                append = TRUE
            )
   
        } else {
            
            cat(
                c(paste0("\n", lns), nms, lns, problem, affected, solution, ""), 
                sep ="\n", 
                file = file, 
                append = TRUE
            )
            
        }

    }, 
        x[['elemental_checks']], 
        gsub('_', ' ', toupper(names(x[['elemental_checks']])))
    ))
    
}

all_good <- function(){
	message <- paste0(
	    sprintf(cow, sample(adj, 1)),
        "\n\n\n\n"
	)
	cat(message)
}


cow <- paste0(
    "\n", 
    " ------------- \n",
    "No problems found!\n",
    "This text is %s! \n",
    " ---------------- \n",
    "  \\   ^__^ \n",
    "   \\  (oo)\\ ________ \n",
    "      (__)\\         )\\ /\\ \n",
    "           ||------w|\n",
    "           ||      ||"
)

adj <- c(
    "outstanding", "astounding", "staggering", "kryptonian*", "breathtaking",
    "stunning", "prodigious", "stupendous", "righteous", "wickedly awesome",
    "superb", "sublime", "indomitable", "transcendent", "marvelous",
    "resplendent", "phenomenal", "remarkable", "funkadelic", "magnificent",
    "virtuosic", "rapturous", "flawless", "majestic", "splendiferous",
    "legendary"
)


#' Check Text For Potential Problems
#' 
#' Uncleaned text may result in errors, warnings, and incorrect results in 
#' subsequent analysis.  \code{check_text} checks text for potential problems 
#' and suggests possible fixes.  Potential text anomalies that are detected 
#' include: factors, missing ending punctuation, empty cells, double punctuation, 
#' non-space after comma, no alphabetic characters, non-ascii, missing value, 
#' and potentially misspelled words.
#' 
#' @param x The text variable.
#' @param file A connection, or a character string naming the file to print to.  
#' If \code{NULL} prints to the console.  Note that this is assigned as an 
#' attribute and passed to \code{print}.
#' @return Returns a list with the following potential text faults reports:\cr
#' \itemize{
#'   \item{non_character}{- Text that is \code{factor}.}
#'   \item{missing_ending_punctuation}{- Text with no endmark at the end of the string.}
#'   \item{empty}{- Text that contains an empty element (i.e., \code{""}).}
#'   \item{double_punctuation}{- Text that contains two punctuation marks in the same string.}
#'   \item{non_space_after_comma}{- Text that contains commas with no space after them.}
#'   \item{no_alpha}{- Text that contains string elements with no alphabetic characters.}
#'   \item{non_ascii}{- Text that contains non-ASCII characters.}
#'   \item{missing_value}{- Text that contains missing values (i.e., \code{NA}).}
#'   \item{containing_escaped}{- Text that contains escaped (see \code{?Quotes}).}
#'   \item{containing_digits}{- Text that contains digits.}
#'   \item{indicating_incomplete}{- Text that contains endmarks that are indicative of incomplete/trailing sentences (e.g., \code{...}).}
#'   \item{potentially_misspelled}{- Text that contains potentially misspelled words.}
#' }
#' @note The output is a list but prints as a pretty formatted output with 
#' potential problem elements, the accompanying text, and possible suggestions 
#' to fix the text.
#' @keywords check text spelling
#' @export
#' @examples
#' \dontrun{
#' x <- c("i like", "i want. thet them ther .", "I am ! that|", "", NA, 
#'     "they,were there", ".", "   ", "?", "3;", "I like goud eggs!", 
#'     "i 4like...", "\\tgreat",  "She said \"yes\"")
#' check_text(x)
#' print(check_text(x), include.text=FALSE)
#'
#' y <- c("A valid sentence.", "yet another!")
#' check_text(y)
#' }
check_text <- function(x, file = NULL) {

    
    check_install('hunspell')
    
    non_character <- is.factor(x) 
    x <- as.character(x)
    missing <- which(is.na(x))
    
    pot_spell <- eval(parse(text = "hunspell::hunspell_find(x)")) 
    misspelled <- which(sapply(pot_spell, function(x) length(x) != 0 ))

    if (length(missing) == 0) missing <- NULL
    if (!non_character) non_character <- NULL
    if (length(misspelled) == 0) misspelled <- NULL

    out <- list(
        non_character = non_character,
        missing_ending_punctuation = which.mp(x),
        empty = which.empty(x),
        double_punctuation = which.dp(x),
        non_space_after_comma = which.cns(x),
        no_alpha = which.non.alpha(x),
        non_ascii = which.non.ascii(x),
        missing_value = missing, 
        containing_escaped = which.escaped(x),
        containing_digits = which.digit(x),
        indicating_incomplete = which.incomplete(x),
        potentially_misspelled = misspelled
    )
    class(out) <- "check_text"
    attributes(out)[["text.var"]] <- x
    attributes(out)[["file"]] <- file
    attributes(out)[["misspelled"]] <- unname(unlist(pot_spell))
    out
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
#' @param \ldots ignored
#' @method print check_text
#' @export
print.check_text <- function(x, include.text = TRUE, file = NULL, ...) {
    
    if (is.null(file)) file <- force(attributes(x)[["file"]])
    spelling <- force(attributes(x)[["misspelled"]])
    file <- ifelse(is.null(file), "", file)

    if (all(sapply(x, is.null))) {
        all_good()
        return(invisible(NULL))
    }
    
    txt.var <- force(attributes(x)[["text.var"]])
    out <- Map(function(x, y, z) {

            if (is.null(x)) return(invisible(NULL))
            nm <- toupper(gsub("_", " ", y))
            lns <- paste(rep("=", nchar(nm)), collapse="")
       
            if (y == "non_character") {

                if(is.null(x)) {
                    mess <- "\n  --IS CHARACTER--\n"
                    mess3 <- NULL
                } else {
                    mess <- "\nText is a factor."
                    mess3 <- paste("\n*Suggestion: Consider", z)
                }         
                
                return(c(paste0("\n", lns), nm, lns, mess, mess3))
            }        
        
            mess <- sprintf("\nThe following observations were %s:\n", 
                tolower(nm))

            affected <- paste(x, collapse=", ")

            
            if(is.null(z) | is.null(x)) {
                mess3 <- NULL
            } else {
                mess3 <- paste("\n*Suggestion: Consider", z)
            }   
            if (include.text & !is.null(x) & y != "missing_value") {
                mess2 <- sprintf("\nThe following text is %s:\n", tolower(nm))

                if (y == "potentially_misspelled" && !is.null(spelling)) {
                    spelling <- unique(spelling)
                    txt.var[x] <- trimws(mgsub(
                        txt.var[x],
                        spelling,
                        paste0("<<", spelling, ">>")
                        ))
                } 
                affected.text <- txt.var[x]

                c(paste0("\n", lns), nm, lns, mess, affected, mess2, 
                    paste0(x, ": ", affected.text), mess3, "")
            } else {
                c(paste0("\n", lns), nm, lns, mess, affected, mess3, "")
            }
        }, 
        unclass(x), names(x), .check_messages)
    cat(paste(unlist(out), collapse="\n"), file = file)
}

spaste <- function(x) paste0(" ", x, " ")
    
    
.check_messages <- list(
    non_character = "using `as.character` or `stringsAsFactors = FALSE` when reading in", 
    missing_ending_punctuation = "cleaning the raw text or running `replace_incomplete`",
    empty = "running `filter_empty`",
    double_punctuation = "running `textshape::split_sentence`",
    non_space_after_comma = "running `add_comma_space`",
    no_alpha = "cleaning the raw text or running `filter_row`",
    non_ascii = "running `replace_non_ascii`",
    missing_value = "running `filter_NA`", 
    containing_escaped = "using `replace_white`",
    containing_digits = "using `replace_number`",
    indicating_incomplete = "using `replace_incomplete`",   
    potentially_misspelled = "running `hunspell::hunspell_find` & `hunspell::hunspell_suggest`"
)

## is missing punctiuation
is.mp <- function(x) any(suppressWarnings(stats::na.omit(!has_endmark(x))))
is.empty <- function(x) any(grepl("^\\s*$", stats::na.omit(x)))
## is double punctuation
is.dp <- function(text.var) {
    count_endmark(text.var) > 1
}
## is comma with no space
is.cns <- function(x) grepl("(,)([^ ])", x)
## x <- c("the, dog,went", "I,like,it", "where are you", NA, "why")
## is.cns(x)


is.non.alpha <- function(x) {
    !is.na(x) & !grepl("[a-zA-Z]", x)
}

is.non.ascii <- function(x) {
    grepl("[^ -~]", x) & !is.na(x) & !grepl("^\\s*$", x)
}

## check if something is a list of vectors
is.list_o_vectors <-  function(x) {

    is.list(x) && !is.data.frame(x) && all(sapply(x, is.vector))
}


which.incomplete <- function(x) {
    pat <- "\\?*\\?[.]+|[.?!]*\\? [.][.?!]+|[.?!]*\\. [.?!]+|[.?!]+\\. [.?!]*|[.?!]+\\.[.?!]*|[.?!]*\\.[.?!]+"
    out <- grep(pat, x)
    if(length(out) == 0) return(NULL)
    out
}


which.escaped <- function(x) {
    out <- which(grepl("[\\\\]", x) & !grepl("\\\"|\\\'|\\\`", x))
    if(length(out) == 0) return(NULL)
    out
}

which.mp <- function(x) {
    out <- which(!has_endmark(x))
    if(length(out) == 0) return(NULL)
    out
}

which.empty <- function(x) {
    out <- which(!is.na(x) & grepl("^\\s*$", x))
    if(length(out) == 0) return(NULL)
    out
}

which.cns <- function(x) {
    out <- which(is.cns(x))
    if(length(out) == 0) return(NULL)
    out
}

which.dp <- function(x){
    out <- which(is.dp(x))
    if(length(out) == 0) return(NULL)
    out
}

which.non.alpha <- function(x){
    out <- which(is.non.alpha(x))
    if(length(out) == 0) return(NULL)
    out
}

which.non.ascii <- function(x){
    out <- which(is.non.ascii(x))
    if(length(out) == 0) return(NULL)
    out
}

which.digit <- function(x) {
    out <- grep('\\d', x)    
    if(length(out) == 0) return(NULL)
    out
}


all_good <- function(){
	message <- paste0(
	    sprintf(cow, sample(adj, 1)),
        "\n\n\n\n"
	)
	cat(message)
}


cow <- "\n ------- \nNo problems found!\nYou are %s! \n -------- \n    \\   ^__^ \n     \\  (oo)\\ ________ \n        (__)\\         )\\ /\\ \n             ||------w|\n             ||      ||"

adj <- c(
    "outstanding", "astounding", "staggering", "kryptonian*", "breathtaking",
    "stunning", "prodigious", "stupendous", "righteous", "wickedly awesome",
    "superb", "sublime", "indomitable", "transcendent", "marvelous",
    "resplendent", "phenomenal", "remarkable", "funkadelic", "magnificent",
    "virtuosic", "rapturous", "flawless", "majestic", "splendiferous",
    "legendary"
)
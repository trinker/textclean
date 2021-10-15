#' Replace Word Elongations
#' 
#' In informal writing people may use a form of text embellishment to emphasize 
#' or alter word meanings called elongation (a.k.a. "word lengthening").  For 
#' example, the use of "Whyyyyy" conveys frustration.  Other times the usage may 
#' be to be more sexy (e.g., "Heyyyy there").  Other times it may be used for 
#' emphasis (e.g., "This is so gooood").  This function uses an augmented form
#' of Armstrong & Fogarty's (2007) algorithm.  The algorithm first attempts to
#' replace the elongation with known semantic replacements (optional; default is
#' \code{FALSE}).  After this the algorithm locates all places where the same 
#' letter (case insensitive) appears 3 times consecutively.  These elements are
#' then further processed.  The matches are replaced via \code{fgsub} by first
#' taking the elongation to it's canonical form (drop all > 1 consecutive 
#' letters to a single letter) and then replacing with the most common word 
#' used in 2008 in Google's ngram data set that takes the canonical form.  If 
#' the canonical form is not found in the Google data set then the canonical 
#' form is used as the replacement.
#' 
#' @param x  The text variable.
#' @param impart.meaning logical.  If \code{TRUE}, known elongation semantics
#' are used as replacements (see \code{textclean:::meaning_elongations} for 
#' known elongation semantics and replacements).
#' @param elongation.pattern The elongation pattern to search for.  The default
#' only considers a repeat of \code{'[A-Za-z]'} within a "word" that is bounded
#' by a word boundary or the beginning or end of the string and contained only
#' \code{'\\w'} characters.  This means "words" with non-ascii characters will 
#' not be considered.
#' @param \ldots ignored.
#' @return Returns a vector with word elongations replaced.
#' @references
#' Armstrong, D. B., Fogarty, G. J., & Dingsdag, D. (2007). Scales measuring 
#' characteristics of small business information systems. Proceedings of the 
#' 2011 Conference on Empirical Methods in Natural Language Processing (pp. 
#' 562-570). Edinburgh, Scotland. Retrieved from 
#' http://www.aclweb.org/anthology/D11-1052 \cr \cr
#' \url{https://storage.googleapis.com/books/ngrams/books/datasetsv2.html} \cr \cr
#' \url{https://www.theatlantic.com/magazine/archive/2013/03/dragging-it-out/309220} \cr \cr
#' \url{https://english.stackexchange.com/questions/189517/is-there-a-name-term-for-multiplied-vowels}
#' @export
#' @examples
#' x <- c('look', 'noooooo!', 'real coooool!', "it's sooo goooood", 'fsdfds', 
#'     'fdddf', 'as', "aaaahahahahaha", "aabbccxccbbaa", 'I said heyyy!',
#'     "I'm liiiike whyyyyy me?", "Wwwhhatttt!", NA)
#' 
#' replace_word_elongation(x)
#' replace_word_elongation(x, impart.meaning = TRUE)
replace_word_elongation <- function(x, impart.meaning = FALSE, 
    elongation.pattern = "(?i)(^|\\b)\\w*([a-z])(\\1{2,})\\w*($|\\b)", ...){

    ## replace with meaningful
    if (isTRUE(impart.meaning)){
        x <- mgsub(x, meaning_elongations[['x']], meaning_elongations[['y']], 
            fixed = FALSE, perl = TRUE, ignore.case = TRUE)
    }

    ## consider only groupings with a triple letter
    locs <- stringi::stri_detect_regex(x, elongation.pattern, 
        opts_regex = list(case_insensitive = TRUE))
    
    locs[is.na(locs)] <- FALSE
    
    if (sum(locs) == 0) return(x)
    
    txt <- x[locs]
    canonicalk <- data.table::data.table(canonical)
# browser()
    ## replace tripple letter words with most common form or else canonical form
    x[locs] <- .fgsub(txt, elongation.pattern, function(x, can = canonical){

        y <- gsub("([a-z])(\\1+)", '\\1', tolower(x), perl = TRUE)
    
        z <- data.table::data.table(canonical = y)
        out <- merge(z, can, by = 'canonical')$word

        if ((length(out) == 0 || is.na(out))) {
            if (!is.na(y)){
                out <- y
            } else {
                warning(sprintf("Elongation detected for '%s' but could not be replaced", x))
                out <- x
            }                
        } 
        out
        
    })
    
    x

}



# Known with meaning
b2 <- "(?<=^|[^A-Za-z'-])(%s)(?=$|[^A-Za-z'-])"
meaning_elongations <- data.frame(
    x = sprintf(
        b2, 
        c(
            'hey{2,}', 'fi{3,}ne', 'no{3,}', 'sor{3,}y|sory{2,}|sor{3,}y{2,}',
            'thanks{2,}', 'tha{2,}nks', 'ri{3,}ght', 'why{3,}', 'real{2,}y'
        )
    ),
    y = c(
        'hey sexy', 'not fine', 'sarcastic', 'not sorry', 'not thankful', 
        'very thankful', 'not correct', 'frustration', 'surprised'
    ), 
    stringsAsFactors = FALSE
)

#elongation_search_pattern <- "(?i)([a-z])(\\1{2,})"
#elongation_pattern <- "(?i)(^|\\b)\\w*([a-z])(\\1{2,})\\w*($|\\b)"





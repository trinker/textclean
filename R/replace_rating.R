#' Replace Ratings With Words
#'
#' Replaces ratings with word equivalents.
#'
#' @param x The text variable.
#' @param rating_dt A \pkg{data.table} of ratings and corresponding word meanings.
#' @param \ldots ignored.
#' @return Returns a vector of strings with ratings replaced with word
#' equivalents.
#' @keywords rating
#' @export
#' @examples
#' x <- c("This place receives 5 stars for their APPETIZERS!!!",
#'      "Four stars for the food & the guy in the blue shirt for his great vibe!",
#'      "10 out of 10 for both the movie and trilogy.",
#'      "* Both the Hot & Sour & the Egg Flower Soups were absolutely 5 Stars!",
#'      "For service, I give them no stars.", "This place deserves no stars.",
#'      "10 out of 10 stars.",
#'      "My rating: just 3 out of 10.",
#'      "If there were zero stars I would give it zero stars.",
#'      "Rating: 1 out of 10.",
#'      "I gave it 5 stars because of the sound quality.",
#'      "If it were possible to give them 0/10, they'd have it."
#' )
#'
#' replace_rating(x)
replace_rating <- function (x, rating_dt = lexicon::key_rating, ...) {
    gsub("\\s+", " ", .mgsub(rating_dt[["x"]], paste0(" ",
        rating_dt[["y"]], " "), x, ...))
}


IMPORT <- lexicon::available_data
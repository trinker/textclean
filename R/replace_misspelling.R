#' Replace Misspelled Words
#' 
#' Replace misspelled words with their most likely replacement.  This function 
#' uses \pkg{hunspell} in the backend.  \pkg{hunspell}  must be installed in 
#' order to use this feature.
#' 
#' @param x A character vector.
#' @param \ldots ignored..
#' @return Returns a vector of strings with misspellings replaced.
#' @note The function splits the string apart into tokens for speed
#' optimization.  After the replacement occurs the strings are pasted back
#' together.  The strings are not guaranteed to retain exact spacing of the
#' original.
#' @export
#' @author Surin Space and Tyler Rinker <tyler.rinker@@gmail.com>.
#' @examples
#' bad_string <- c("I cant spelll rigtt noow.", '', NA, 
#'     'Thiss is aslo mispelled?', 'this is 6$ and 38 cents in back2back!')
#' replace_misspelling(bad_string)
replace_misspelling <- function(x, ...){

    check_install('hunspell')

    if (!(is.character(x) | is.factor(x))) stop('`x` must be a character vector')
    is_na <- is.na(x)
    dat <- data.frame(text = as.character(x), stringsAsFactors = FALSE)

    token_df <- textshape::split_token(dat, lower = FALSE)[, 
        lower := tolower(text)]

    tokens <- grep('[a-z]', rm_na(unique(token_df[['lower']])), value = TRUE)
    hits <- !hunspell::hunspell_check(tokens)

    misspelled <- tokens[hits]

    map <- data.table::data.table(
        lower = misspelled,
        replacement = unlist(lapply(hunspell_suggest(misspelled), `[`, 1))
    )

    fixed_df <- map[token_df, on = "lower"]

    fixed_df_a <- fixed_df[!is.na(replacement),][,
        is_cap := substring(text, 1, 1) %in% LETTERS][,
        final := ifelse(is_cap,  upper_first_letter(replacement), replacement)][]

    fixed_df_b <- fixed_df[is.na(replacement),][, final := text][]

    bound <- rbind(fixed_df_a, fixed_df_b, fill = TRUE)

    out <- data.table::setorder(bound, element_id, token_id)[, 
        list(`final` = paste(final, collapse = ' ')), by = 'element_id'][,
        `final` := gsub("(\\s+)([.!?,;:])", "\\2", final, perl = TRUE)][['final']]
    out[is_na] <- NA
    out
}


upper_first_letter <- function(x){
    substring(x, 1, 1) <- toupper(substring(x, 1, 1))
    x
}

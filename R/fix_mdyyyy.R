#' Coerce Character m/d/yyyy to Date
#' 
#' Uses regular expressions to sub out a single day or month with a leading zero
#' and then coerces to a date object.
#' 
#' @param x A character date in the form of m/d/yyyy where m and d can be single 
#' integers like 1 for January.
#' @param \ldots ignored.
#' @return Returns a data vector
#' @export
#' @rdname fix_mdyyyy
#' @examples 
#' fix_mdyyyy(c('4/23/2017', '12/1/2016', '3/3/2013', '12/12/2012', '2013-01-01'))
#' \dontrun{
#' library(dplyr)
#' data_frame(
#'     x = 1:4,
#'     y = LETTERS[1:4],
#'     start_date = c('4/23/2017', '12/1/2016', '3/3/2013', '12/12/2012'),
#'     end_date = c('5/23/2017', '12/9/2016', '3/3/2016', '2/01/2012')
#' ) %>%
#' mutate_at(vars(ends_with('_date')), fix_mdyyyy)
#' }
fix_mdyyyy <- function(x, ...){
    UseMethod('fix_mdyyyy')
} 


#' @export
#' @method fix_mdyyyy date
fix_mdyyyy.date <- function(x, ...){
    x
} 

#' @export
#' @method fix_mdyyyy default
fix_mdyyyy.default <- function(x, ...){
    as.Date(fix_mdyyyy_character(x), format = '%Y-%m-%d')
} 

fix_mdyyyy_character <- function(x, ...){
    gsub(
        '(^\\d{2})(?:/)(\\d{2})(?:/)(\\d{4})', 
        '\\3-\\1-\\2', 
        gsub(
            '(/)(\\d{1}/)',
            '\\10\\2',     
            gsub(
                '(^\\d{1}/)',
                '0\\1', 
                x
            )
        )
    )
} 

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
    stringi::stri_count_regex(y, "(?<!\\w\\.\\w.)(?<![A-Z][a-z]\\.)(?<=\\.|\\?|\\!)(\\s|(?=[a-zA-Z][a-zA-Z]*\\s))")
}


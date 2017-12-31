if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, data.table, stringi, R.utils)

if (!dir.exists('google_ngram')) dir.create('google_ngram')

#letter <- 'b'

get_google_ngram_data <- function(letter, ...){
    
    loc <- sprintf('http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-1gram-20120701-%s.gz', letter) %>%
        textreadr::download() 

    R.utils::gunzip(loc, destname = sprintf('google_ngram/googlebooks-eng-all-1gram-20120701-%s', letter), remove = FALSE)

}


make_canonical_hash <- function(letter, ...){

	dat <- fread(sprintf('google_ngram/googlebooks-eng-all-1gram-20120701-%s', letter), sep = '\t', header = FALSE)[, 1:3
		][V2 == 2008,
		][, V1 := tolower(stri_replace_all_regex(V1, '_[A-Z]+$', ''))
		][stri_detect_regex(V1, '[^a-z\'-]', negate = TRUE),
		][, list(V3 = sum(V3)), by = c('V1')
		][, canonical := gsub("([a-z])(\\1+)", '\\1', V1, perl = TRUE)
		][, cnt := .N, by = 'canonical'
		][cnt > 1,
		][, cnt := NULL
		#][order(canonical, -V3)
		][, .SD[which.max(V3)], by = 'canonical'
		][, V3 := NULL
		][]

	setnames(dat, c('V1'), c('word'))
	setkey(dat, 'canonical')

	#setnames(dat, c('V1', 'V3'), c('word', 'n'))
	#setcolorder(dat, c("canonical", "word", "n"))

	dat
}

canonical <- lapply(letters, function(letter){
    gc()
    print(letter); flush.console()
    try(get_google_ngram_data(letter))
    try(make_canonical_hash(letter))
})

## check for errors
canonical %>%
    sapply(inherits, 'try-error') %>%
    sum()


canonical %>%
    rbindlist() %>%
    unique() %>%
    saveRDS('canonical.rds')


canonical <- readRDS('C:\\Users\\Tyler\\Desktop/canonical.rds')
## canonical <- textclean:::canonical
data.table::setkey(canonical, 'canonical')
devtools::use_data(canonical, internal = TRUE)





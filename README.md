textclean   [![Follow](https://img.shields.io/twitter/follow/tylerrinker.svg?style=social)](https://twitter.com/intent/follow?screen_name=tylerrinker)
============


[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/textclean.svg?branch=master)](https://travis-ci.org/trinker/textclean)
[![Coverage
Status](https://coveralls.io/repos/trinker/textclean/badge.svg?branch=master)](https://coveralls.io/r/trinker/textclean?branch=master)
<a href="https://img.shields.io/badge/Version-0.1.0-orange.svg"><img src="https://img.shields.io/badge/Version-0.1.0-orange.svg" alt="Version"/></a>
</p>
<img src="inst/textclean_logo/r_textclean2.png" width="200" alt="textclean Logo">

**textclean** is a collection of tools to clean and process text. Many
of these tools have been taken from the **qdap** package and revamped to
be more intuitive, better named, and faster.


Table of Contents
============

-   [Functions](#functions)
-   [Installation](#installation)
-   [Contact](#contact)
-   [Demonstration](#demonstration)
    -   [Load the Packages/Data](#load-the-packagesdata)
    -   [Check Text](#check-text)
    -   [Row Filtering](#row-filtering)
    -   [Stripping](#stripping)
    -   [Subbing](#subbing)
        -   [Multiple Subs](#multiple-subs)
        -   [Stashing Character Pre-Sub](#stashing-character-pre-sub)
    -   [Replacement](#replacement)
        -   [Contractions](#contractions)
        -   [Incomplete Sentences](#incomplete-sentences)
        -   [Non-ASCII Characters](#non-ascii-characters)
        -   [Numbers](#numbers)
        -   [Symbols](#symbols)
        -   [White Space](#white-space)

Functions
============


The main functions, task category, & descriptions are summarized in the
table below:

<table>
<thead>
<tr class="header">
<th align="left">Function</th>
<th align="left">Task</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>mgsub</code></td>
<td align="left">subbing</td>
<td align="left">Multiple <code>gsub</code></td>
</tr>
<tr class="even">
<td align="left"><code>sub_holder</code></td>
<td align="left">subbing</td>
<td align="left">Hold a value prior to a <code>strip</code></td>
</tr>
<tr class="odd">
<td align="left"><code>strip</code></td>
<td align="left">deletion</td>
<td align="left">Remove all non word characters</td>
</tr>
<tr class="even">
<td align="left"><code>filter_empty_row</code></td>
<td align="left">filter rows</td>
<td align="left">Remove empty rows</td>
</tr>
<tr class="odd">
<td align="left"><code>filter_row</code></td>
<td align="left">filter rows</td>
<td align="left">Remove rows matching a regex</td>
</tr>
<tr class="even">
<td align="left"><code>filter_NA</code></td>
<td align="left">filter rows</td>
<td align="left">Remove <code>NA</code> text rows</td>
</tr>
<tr class="odd">
<td align="left"><code>replace_contractions</code></td>
<td align="left">replacement</td>
<td align="left">Replace contractions with both words</td>
</tr>
<tr class="even">
<td align="left"><code>replace_incomplete</code></td>
<td align="left">replacement</td>
<td align="left">Replace incomplete sentence end-marks</td>
</tr>
<tr class="odd">
<td align="left"><code>replace_non_ascii</code></td>
<td align="left">replacement</td>
<td align="left">Replace non-ascii with equivalent or remove</td>
</tr>
<tr class="even">
<td align="left"><code>replace_number</code></td>
<td align="left">replacement</td>
<td align="left">Replace common numbers</td>
</tr>
<tr class="odd">
<td align="left"><code>replace_symbol</code></td>
<td align="left">replacement</td>
<td align="left">Replace common symbols</td>
</tr>
<tr class="even">
<td align="left"><code>replace_white</code></td>
<td align="left">replacement</td>
<td align="left">Replace regex white space characters</td>
</tr>
<tr class="odd">
<td align="left"><code>add_comma_space</code></td>
<td align="left">repalcement</td>
<td align="left">Replace non-space after comma</td>
</tr>
<tr class="even">
<td align="left"><code>check_text</code></td>
<td align="left">check</td>
<td align="left">Text report of potential issues</td>
</tr>
<tr class="odd">
<td align="left"><code>has_endmark</code></td>
<td align="left">check</td>
<td align="left">Check if an element has an end-mark</td>
</tr>
</tbody>
</table>

Installation
============

To download the development version of **textclean**:

Download the [zip
ball](https://github.com/trinker/textclean/zipball/master) or [tar
ball](https://github.com/trinker/textclean/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh(
        "trinker/lexicon",    
        "trinker/textclean"
    )

Contact
=======

You are welcome to:    
- submit suggestions and bug-reports at: <https://github.com/trinker/textclean/issues>    
- send a pull request on: <https://github.com/trinker/textclean/>    
- compose a friendly e-mail to: <tyler.rinker@gmail.com>    

Demonstration
=============

Load the Packages/Data
----------------------

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load(dplyr)
    pacman::p_load_gh("trinker/textclean", "trinker/textshape", "trinker/lexicon")

Check Text
----------

One of the most useful tools in **textclean** is `check_text` which
scans text variables and reports potential problems. Not all potential
problems are definite problems for analysis but the report provides an
overview of what may need further preparation. The report also provides
suggested functions for the reported problems. The report provides
information on the following:

1.  **non\_character** - Text that is `factor`.
2.  **missing\_ending\_punctuation** - Text with no endmark at the end
    of the string.
3.  **empty** - Text that contains an empty element (i.e., `""`).
4.  **double\_punctuation** - Text that contains two punctuation marks
    in the same string.
5.  **non\_space\_after\_comma** - Text that contains commas with no
    space after them.
6.  **no\_alpha** - Text that contains string elements with no
    alphabetic characters.
7.  **non\_ascii** - Text that contains non-ASCII characters.
8.  **missing\_value** - Text that contains missing values (i.e., `NA`).
9.  **containing\_escaped** - Text that contains escaped (see
    `?Quotes`).
10. **containing\_digits** - Text that contains digits.
11. **indicating\_incomplete** - Text that contains endmarks that are
    indicative of incomplete/trailing sentences (e.g., `...`).
12. **potentially\_misspelled** - Text that contains potentially
    misspelled words.

Here is an example:

    x <- as.factor(c("i like", "i want. thet them ther .", "I am ! that|", "", NA, 
        "they,were there", ".", "   ", "?", "3;", "I like goud eggs!", 
        "i 4like...", "\\tgreat",  "She said \"yes\""))
    check_text(x)

    ## 
    ## =============
    ## NON CHARACTER
    ## =============
    ## 
    ## Text is a factor.
    ## 
    ## *Suggestion: Consider using `as.character` or `stringsAsFactors = FALSE` when reading in
    ## 
    ## ==========================
    ## MISSING ENDING PUNCTUATION
    ## ==========================
    ## 
    ## The following observations were missing ending punctuation:
    ## 
    ## 1, 3, 4, 5, 6, 8, 10, 13, 14
    ## 
    ## The following text is missing ending punctuation:
    ## 
    ## 1: i like
    ## 3: I am ! that|
    ## 4: 
    ## 5: NA
    ## 6: they,were there
    ## 8:    
    ## 10: 3;
    ## 13: \tgreat
    ## 14: She said "yes"
    ## 
    ## *Suggestion: Consider cleaning the raw text or running `replace_incomplete`
    ## 
    ## 
    ## =====
    ## EMPTY
    ## =====
    ## 
    ## The following observations were empty:
    ## 
    ## 4, 8
    ## 
    ## The following text is empty:
    ## 
    ## 4: 
    ## 8:    
    ## 
    ## *Suggestion: Consider running `filter_empty`
    ## 
    ## 
    ## =====================
    ## NON SPACE AFTER COMMA
    ## =====================
    ## 
    ## The following observations were non space after comma:
    ## 
    ## 6
    ## 
    ## The following text is non space after comma:
    ## 
    ## 6: they,were there
    ## 
    ## *Suggestion: Consider running `add_comma_space`
    ## 
    ## 
    ## ========
    ## NO ALPHA
    ## ========
    ## 
    ## The following observations were no alpha:
    ## 
    ## 4, 7, 8, 9, 10
    ## 
    ## The following text is no alpha:
    ## 
    ## 4: 
    ## 7: .
    ## 8:    
    ## 9: ?
    ## 10: 3;
    ## 
    ## *Suggestion: Consider cleaning the raw text or running `filter_row`
    ## 
    ## 
    ## =========
    ## NON ASCII
    ## =========
    ## 
    ## The following observations were non ascii:
    ## 
    ## 4, 5
    ## 
    ## The following text is non ascii:
    ## 
    ## 4: 
    ## 5: NA
    ## 
    ## *Suggestion: Consider running `replace_non_ascii`
    ## 
    ## 
    ## =============
    ## MISSING VALUE
    ## =============
    ## 
    ## The following observations were missing value:
    ## 
    ## 5
    ## 
    ## *Suggestion: Consider running `filter_NA`
    ## 
    ## 
    ## ==================
    ## CONTAINING ESCAPED
    ## ==================
    ## 
    ## The following observations were containing escaped:
    ## 
    ## 13
    ## 
    ## The following text is containing escaped:
    ## 
    ## 13: \tgreat
    ## 
    ## *Suggestion: Consider using `replace_white`
    ## 
    ## 
    ## =================
    ## CONTAINING DIGITS
    ## =================
    ## 
    ## The following observations were containing digits:
    ## 
    ## 10, 12
    ## 
    ## The following text is containing digits:
    ## 
    ## 10: 3;
    ## 12: i 4like...
    ## 
    ## *Suggestion: Consider using `replace_number`
    ## 
    ## 
    ## =====================
    ## INDICATING INCOMPLETE
    ## =====================
    ## 
    ## The following observations were indicating incomplete:
    ## 
    ## 12
    ## 
    ## The following text is indicating incomplete:
    ## 
    ## 12: i 4like...
    ## 
    ## *Suggestion: Consider using `replace_incomplete`
    ## 
    ## 
    ## ======================
    ## POTENTIALLY MISSPELLED
    ## ======================
    ## 
    ## The following observations were potentially misspelled:
    ## 
    ## 2, 11, 12, 13
    ## 
    ## The following text is potentially misspelled:
    ## 
    ## 2: i want. <<thet>> them <<ther>> .
    ## 11: I like <<goud>> eggs!
    ## 12: i <<4like>>...
    ## 13: \<<tgreat>>
    ## 
    ## *Suggestion: Consider running `hunspell::hunspell_find` & `hunspell::hunspell_suggest`

And if all is well the user should be greeted by a cow:

    y <- c("A valid sentence.", "yet another!")
    check_text(y)

    ## 
    ##  ------- 
    ## No problems found!
    ## You are phenomenal! 
    ##  -------- 
    ##     \   ^__^ 
    ##      \  (oo)\ ________ 
    ##         (__)\         )\ /\ 
    ##              ||------w|
    ##              ||      ||

Row Filtering
-------------

It is useful to filter/remove empty rows or unwanted rows (for example
the researcher dialogue from a transcript). The `filter_empty_row` &
`filter_row` do empty row do just this. First I'll demo the removal of
empty rows.

    ## create a data set wit empty rows
    (dat <- rbind.data.frame(DATA[, c(1, 4)], matrix(rep(" ", 4), 
        ncol =2, dimnames=list(12:13, colnames(DATA)[c(1, 4)]))))

    ##        person                                 state
    ## 1         sam         Computer is fun. Not too fun.
    ## 2        greg               No it's not, it's dumb.
    ## 3     teacher                    What should we do?
    ## 4         sam                  You liar, it stinks!
    ## 5        greg               I am telling the truth!
    ## 6       sally                How can we be certain?
    ## 7        greg                      There is no way.
    ## 8         sam                       I distrust you.
    ## 9       sally           What are you talking about?
    ## 10 researcher         Shall we move on?  Good then.
    ## 11       greg I'm hungry.  Let's eat.  You already?
    ## 12                                                 
    ## 13

    filter_empty_row(dat)

    ##        person                                 state
    ## 1         sam         Computer is fun. Not too fun.
    ## 2        greg               No it's not, it's dumb.
    ## 3     teacher                    What should we do?
    ## 4         sam                  You liar, it stinks!
    ## 5        greg               I am telling the truth!
    ## 6       sally                How can we be certain?
    ## 7        greg                      There is no way.
    ## 8         sam                       I distrust you.
    ## 9       sally           What are you talking about?
    ## 10 researcher         Shall we move on?  Good then.
    ## 11       greg I'm hungry.  Let's eat.  You already?

Next we filter out rows. The `filter_row` function takes a data set, a
column (named or numeric position) and regex terms to search for. The
`terms` argument takes regex(es) allowing for partial matching. `terms`
is case sensitive but can be changed via the `ignore.case` argument.

    filter_row(dataframe = DATA, column = "person", terms = c("sam", "greg"))

    ##       person sex adult                         state code
    ## 1    teacher   m     1            What should we do?   K3
    ## 2      sally   f     0        How can we be certain?   K6
    ## 3      sally   f     0   What are you talking about?   K9
    ## 4 researcher   f     1 Shall we move on?  Good then.  K10

    filter_row(DATA, 1, c("sam", "greg"))

    ##       person sex adult                         state code
    ## 1    teacher   m     1            What should we do?   K3
    ## 2      sally   f     0        How can we be certain?   K6
    ## 3      sally   f     0   What are you talking about?   K9
    ## 4 researcher   f     1 Shall we move on?  Good then.  K10

    filter_row(DATA, "state", c("Comp"))

    ##        person sex adult                                 state code
    ## 1        greg   m     0               No it's not, it's dumb.   K2
    ## 2     teacher   m     1                    What should we do?   K3
    ## 3         sam   m     0                  You liar, it stinks!   K4
    ## 4        greg   m     0               I am telling the truth!   K5
    ## 5       sally   f     0                How can we be certain?   K6
    ## 6        greg   m     0                      There is no way.   K7
    ## 7         sam   m     0                       I distrust you.   K8
    ## 8       sally   f     0           What are you talking about?   K9
    ## 9  researcher   f     1         Shall we move on?  Good then.  K10
    ## 10       greg   m     0 I'm hungry.  Let's eat.  You already?  K11

    filter_row(DATA, "state", c("I "))

    ##       person sex adult                                 state code
    ## 1        sam   m     0         Computer is fun. Not too fun.   K1
    ## 2       greg   m     0               No it's not, it's dumb.   K2
    ## 3    teacher   m     1                    What should we do?   K3
    ## 4        sam   m     0                  You liar, it stinks!   K4
    ## 5      sally   f     0                How can we be certain?   K6
    ## 6       greg   m     0                      There is no way.   K7
    ## 7      sally   f     0           What are you talking about?   K9
    ## 8 researcher   f     1         Shall we move on?  Good then.  K10
    ## 9       greg   m     0 I'm hungry.  Let's eat.  You already?  K11

    filter_row(DATA, "state", c("you"), ignore.case = TRUE)

    ##       person sex adult                         state code
    ## 1        sam   m     0 Computer is fun. Not too fun.   K1
    ## 2       greg   m     0       No it's not, it's dumb.   K2
    ## 3    teacher   m     1            What should we do?   K3
    ## 4       greg   m     0       I am telling the truth!   K5
    ## 5      sally   f     0        How can we be certain?   K6
    ## 6       greg   m     0              There is no way.   K7
    ## 7 researcher   f     1 Shall we move on?  Good then.  K10

Stripping
---------

Often it is useful to remove all non relevant symbols and case from a
text (letters, spaces, and apostrophes are retained). The `strip`
function accomplishes this. The `char.keep` argument allows the user to
retain characters.

    strip(DATA$state)

    ##  [1] "computer is fun not too fun"      "no it's not it's dumb"           
    ##  [3] "what should we do"                "you liar it stinks"              
    ##  [5] "i am telling the truth"           "how can we be certain"           
    ##  [7] "there is no way"                  "i distrust you"                  
    ##  [9] "what are you talking about"       "shall we move on good then"      
    ## [11] "i'm hungry let's eat you already"

    strip(DATA$state, apostrophe.remove = TRUE)

    ##  [1] "computer is fun not too fun"    "no its not its dumb"           
    ##  [3] "what should we do"              "you liar it stinks"            
    ##  [5] "i am telling the truth"         "how can we be certain"         
    ##  [7] "there is no way"                "i distrust you"                
    ##  [9] "what are you talking about"     "shall we move on good then"    
    ## [11] "im hungry lets eat you already"

    strip(DATA$state, char.keep = c("?", "."))

    ##  [1] "computer is fun. not too fun."      
    ##  [2] "no it's not it's dumb."             
    ##  [3] "what should we do?"                 
    ##  [4] "you liar it stinks"                 
    ##  [5] "i am telling the truth"             
    ##  [6] "how can we be certain?"             
    ##  [7] "there is no way."                   
    ##  [8] "i distrust you."                    
    ##  [9] "what are you talking about?"        
    ## [10] "shall we move on? good then."       
    ## [11] "i'm hungry. let's eat. you already?"

Subbing
-------

### Multiple Subs

`gsub` is a great tool but often the user wants to replace a vector of
elements with another vector. `mgsub` allows for a vector of patterns
and replacements. Note that the first argument of `mgsub` is the data,
not the `pattern` as is standard with base R's `gsub`. This allows
`mgsub` to be used in a **magrittr** pipeline more easily. Also note
that by default `fixed = TRUE`. This means the search `pattern` is not a
regex per-se. This makes the replacement much faster when a regex search
is not needed. `mgsub` also reorders the patterns to ensure patterns
contained within patterns don't over write the longer pattern. For
example if the pattern `c('i', 'it')` is given the longer `'it'` is
replaced first (though `order.pattern = FALSE` can be used to negate
this feature).

    mgsub(DATA$state, c("it's", "I'm"), c("<<it is>>", "<<I am>>"))

    ##  [1] "Computer is fun. Not too fun."           
    ##  [2] "No <<it is>> not, <<it is>> dumb."       
    ##  [3] "What should we do?"                      
    ##  [4] "You liar, it stinks!"                    
    ##  [5] "I am telling the truth!"                 
    ##  [6] "How can we be certain?"                  
    ##  [7] "There is no way."                        
    ##  [8] "I distrust you."                         
    ##  [9] "What are you talking about?"             
    ## [10] "Shall we move on? Good then."            
    ## [11] "<<I am>> hungry. Let's eat. You already?"

    mgsub(DATA$state, "[[:punct:]]", "<<PUNCT>>", fixed = FALSE)

    ##  [1] "Computer is fun<<PUNCT>> Not too fun<<PUNCT>>"                              
    ##  [2] "No it<<PUNCT>>s not<<PUNCT>> it<<PUNCT>>s dumb<<PUNCT>>"                    
    ##  [3] "What should we do<<PUNCT>>"                                                 
    ##  [4] "You liar<<PUNCT>> it stinks<<PUNCT>>"                                       
    ##  [5] "I am telling the truth<<PUNCT>>"                                            
    ##  [6] "How can we be certain<<PUNCT>>"                                             
    ##  [7] "There is no way<<PUNCT>>"                                                   
    ##  [8] "I distrust you<<PUNCT>>"                                                    
    ##  [9] "What are you talking about<<PUNCT>>"                                        
    ## [10] "Shall we move on<<PUNCT>> Good then<<PUNCT>>"                               
    ## [11] "I<<PUNCT>>m hungry<<PUNCT>> Let<<PUNCT>>s eat<<PUNCT>> You already<<PUNCT>>"

    mgsub(DATA$state, c("i", "it"), c("<<I>>", "[[IT]]"))

    ##  [1] "Computer <<I>>s fun. Not too fun."  
    ##  [2] "No [[IT]]'s not, [[IT]]'s dumb."    
    ##  [3] "What should we do?"                 
    ##  [4] "You l<<I>>ar, [[IT]] st<<I>>nks!"   
    ##  [5] "I am tell<<I>>ng the truth!"        
    ##  [6] "How can we be certa<<I>>n?"         
    ##  [7] "There <<I>>s no way."               
    ##  [8] "I d<<I>>strust you."                
    ##  [9] "What are you talk<<I>>ng about?"    
    ## [10] "Shall we move on? Good then."       
    ## [11] "I'm hungry. Let's eat. You already?"

    mgsub(DATA$state, c("i", "it"), c("<<I>>", "[[IT]]"), order.pattern = FALSE)

    ##  [1] "Computer <<I>>s fun. Not too fun."  
    ##  [2] "No <<I>>t's not, <<I>>t's dumb."    
    ##  [3] "What should we do?"                 
    ##  [4] "You l<<I>>ar, <<I>>t st<<I>>nks!"   
    ##  [5] "I am tell<<I>>ng the truth!"        
    ##  [6] "How can we be certa<<I>>n?"         
    ##  [7] "There <<I>>s no way."               
    ##  [8] "I d<<I>>strust you."                
    ##  [9] "What are you talk<<I>>ng about?"    
    ## [10] "Shall we move on? Good then."       
    ## [11] "I'm hungry. Let's eat. You already?"

### Stashing Character Pre-Sub

There are times the user may want to stash a set of characters before
subbing out and then return the stashed characters. An example of this
is when a researcher wants to remove punctuation but not emoticons. The
`subholder` function provides tooling to stash the emoticons, allow a
punctuation stripping, and then return the emoticons. First I'll create
some fake text data with emoticons, then stash the emoticons (using a
unique text key to hold their place), then I'll strip out the
punctuation, and last put the stashed emoticons back.

    (fake_dat <- paste(key_emoticons[1:11, 1, with=FALSE][[1]], DATA$state))

    ##  [1] "#-o Computer is fun. Not too fun."        
    ##  [2] "$_$ No it's not, it's dumb."              
    ##  [3] "(*v*) What should we do?"                 
    ##  [4] "(-: You liar, it stinks!"                 
    ##  [5] "(-}{-) I am telling the truth!"           
    ##  [6] "(.V.) How can we be certain?"             
    ##  [7] ")-: There is no way."                     
    ##  [8] "*-* I distrust you."                      
    ##  [9] "*<:o) What are you talking about?"        
    ## [10] "//_^ Shall we move on?  Good then."       
    ## [11] "0;) I'm hungry.  Let's eat.  You already?"

    (m <- sub_holder(fake_dat, key_emoticons[[1]]))

    ##  [1] "zzzplaceholderazzz Computer is fun. Not too fun."      
    ##  [2] "zzzplaceholderbzzz No it's not, it's dumb."            
    ##  [3] "zzzplaceholderczzz What should we do?"                 
    ##  [4] "zzzplaceholderdzzz You liar, it stinks!"               
    ##  [5] "zzzplaceholderezzz I am telling the truth!"            
    ##  [6] "zzzplaceholderfzzz How can we be certain?"             
    ##  [7] "zzzplaceholdergzzz There is no way."                   
    ##  [8] "zzzplaceholderhzzz I distrust you."                    
    ##  [9] "zzzplaceholderizzz What are you talking about?"        
    ## [10] "zzzplaceholderjzzz Shall we move on? Good then."       
    ## [11] "zzzplaceholderkzzz I'm hungry. Let's eat. You already?"

    (m_stripped <-strip(m$output))

    ##  [1] "zzzplaceholderazzz computer is fun not too fun"     
    ##  [2] "zzzplaceholderbzzz no it's not it's dumb"           
    ##  [3] "zzzplaceholderczzz what should we do"               
    ##  [4] "zzzplaceholderdzzz you liar it stinks"              
    ##  [5] "zzzplaceholderezzz i am telling the truth"          
    ##  [6] "zzzplaceholderfzzz how can we be certain"           
    ##  [7] "zzzplaceholdergzzz there is no way"                 
    ##  [8] "zzzplaceholderhzzz i distrust you"                  
    ##  [9] "zzzplaceholderizzz what are you talking about"      
    ## [10] "zzzplaceholderjzzz shall we move on good then"      
    ## [11] "zzzplaceholderkzzz i'm hungry let's eat you already"

    m$unhold(m_stripped)

    ##  [1] "#-o computer is fun not too fun"     
    ##  [2] "$_$ no it's not it's dumb"           
    ##  [3] "(*v*) what should we do"             
    ##  [4] "(-: you liar it stinks"              
    ##  [5] "(-}{-) i am telling the truth"       
    ##  [6] "(.V.) how can we be certain"         
    ##  [7] ")-: there is no way"                 
    ##  [8] "*-* i distrust you"                  
    ##  [9] "*<:o) what are you talking about"    
    ## [10] "//_^ shall we move on good then"     
    ## [11] "0;) i'm hungry let's eat you already"

Replacement
-----------

**textclean** contains tools to replace substrings within text with
other substrings that may be easier to analyze. This section outlines
the uses of these tools.

### Contractions

Some analysis techniques require contractions to be replaced with their
multi-word forms (e.g., "I'll" -&gt; "I will"). `replace_contrction`
provides this functionality.

    x <- c("Mr. Jones isn't going.",  
        "Check it out what's going on.",
        "He's here but didn't go.",
        "the robot at t.s. wasn't nice", 
        "he'd like it if i'd go away")

    replace_contraction(x)

    ## [1] "Mr. Jones is not going."            
    ## [2] "Check it out what is going on."     
    ## [3] "he is here but did not go."         
    ## [4] "the robot at t.s. was not nice"     
    ## [5] "he would like it if I would go away"

### Incomplete Sentences

Sometimes an incomplete sentence is denoted with multiple end marks or
no punctuation at all. `replace_incomplete` standardizes these sentences
with a pipe (`|`) endmark (or one of the users choice).

    x <- c("the...",  "I.?", "you.", "threw..", "we?")
    replace_incomplete(x)

    ## [1] "the|"   "I|"     "you."   "threw|" "we?"

    replace_incomplete(x, '...')

    ## [1] "the..."   "I..."     "you."     "threw..." "we?"

### Non-ASCII Characters

R can choke on non-ASCII characters. They can be re-encoded but the new
encoding may lack iterpretablity (e.g., ¢ may be converted to `\xA2`
which is not easily understood or likely to be matched in a hash look
up). `replace_non_ascii` attempts to replace common non-ASCII characters
with a text representation (e.g., ¢ becomes "cent") Non recognized
non-ASCII characters are simply removed (unless
`remove.nonconverted = FALSE`).

    x <- c(
        "Hello World", "6 Ekstr\xf8m", "J\xf6reskog", "bi\xdfchen Z\xfcrcher",
        'This is a \xA9 but not a \xAE', '6 \xF7 2 = 3', 'fractions \xBC, \xBD, \xBE',
        'cows go \xB5', '30\xA2'
    )
    Encoding(x) <- "latin1"
    x

    ## [1] "Hello World"             "6 Ekstrøm"              
    ## [3] "Jöreskog"                "bißchen Zürcher"        
    ## [5] "This is a © but not a ®" "6 ÷ 2 = 3"              
    ## [7] "fractions ¼, ½, ¾"       "cows go µ"              
    ## [9] "30¢"

    replace_non_ascii(x)

    ## [1] "Hello World"                                       
    ## [2] "6 Ekstrm"                                          
    ## [3] "Jreskog"                                           
    ## [4] "bichen Zrcher"                                     
    ## [5] "This is a copyright but not a registered trademark"
    ## [6] "6 / 2 = 3"                                         
    ## [7] "fractions 1/2, 1/4, 3/4"                           
    ## [8] "cows go mu"                                        
    ## [9] "30 cent"

    replace_non_ascii(x, remove.nonconverted = FALSE)

    ## [1] "Hello World"                                       
    ## [2] "6 Ekstr<f8>m"                                      
    ## [3] "J<f6>reskog"                                       
    ## [4] "bi<df>chen Z<fc>rcher"                             
    ## [5] "This is a copyright but not a registered trademark"
    ## [6] "6 / 2 = 3"                                         
    ## [7] "fractions 1/2, 1/4, 3/4"                           
    ## [8] "cows go mu"                                        
    ## [9] "30 cent"

### Numbers

Some analysis requires numbers to be converted to text form.
`replace_number` attempts to perform this task. `replace_number` handles
comma separated numbers as well.

    x <- c("I like 346,457 ice cream cones.", "They are 99 percent good")
    y <- c("I like 346457 ice cream cones.", "They are 99 percent good")
    replace_number(x)

    ## [1] "I like three hundred forty six thousand four hundred fifty seven ice cream cones."
    ## [2] "They are ninety nine percent good"

    replace_number(y)

    ## [1] "I like three hundred forty six thousand four hundred fifty seven ice cream cones."
    ## [2] "They are ninety nine percent good"

    replace_number(x, num.paste = TRUE)

    ## [1] "I like threehundredfortysixthousandfourhundredfiftyseven ice cream cones."
    ## [2] "They are ninetynine percent good"

    replace_number(x, remove=TRUE)

    ## [1] "I like , ice cream cones." "They are  percent good"

### Symbols

Text often contains short-hand representations of words/phrases. These
symbols may contain analyzable information but in the symbolic form they
cannot be parsed. The `replace_symbol` function attempts to replace the
symbols `c("$", "%", "#", "@", "& "w/")` with their word equivalents.

    x <- c("I am @ Jon's & Jim's w/ Marry", 
        "I owe $41 for food", 
        "two is 10% of a #"
    )
    replace_symbol(x)

    ## [1] "I am at Jon's and Jim's with Marry"
    ## [2] "I owe dollar 41 for food"          
    ## [3] "two is 10 percent of a number"

### White Space

Regex white space characters (e.g., `\n`, `\t`, `\r`) matched by `\s`
may impede analysis. These can be replaced with a single space `" "` via
the `replace_white` function.

    x <- "I go \r
        to   the \tnext line"
    x

    ## [1] "I go \r\n    to   the \tnext line"

    cat(x)

    ## I go 
    ##     to   the     next line

    replace_white(x)

    ## [1] "I go to the next line"
textclean   
============


[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/textclean.svg?branch=master)](https://travis-ci.org/trinker/textclean)
[![Coverage
Status](https://coveralls.io/repos/trinker/textclean/badge.svg?branch=master)](https://coveralls.io/r/trinker/textclean?branch=master)
[![](https://cranlogs.r-pkg.org/badges/textclean)](https://cran.r-project.org/package=textclean)

![](tools/textclean_logo/r_textclean.png)

**textclean** is a collection of tools to clean and normalize text. Many
of these tools have been taken from the **qdap** package and revamped to
be more intuitive, better named, and faster. Tools are geared at
checking for substrings that are not optimal for analysis and replacing
or removing them (normalizing) with more analysis friendly substrings
(see Sproat, Black, Chen, Kumar, Ostendorf, & Richards, 2001,
<doi:10.1006/csla.2001.0169>) or extracting them into new variables. For
example, emoticons are often used in text but not always easily handled
by analysis algorithms. The `replace_emoticon()` function replaces
emoticons with word equivalents.

Other R packages provide some of the same functionality (e.g.,
**english**, **gsubfn**, **mgsub**, **stringi**, **stringr**,
**qdapRegex**). **textclean** differs from these packages in that it is
designed to handle all of the common cleaning and normalization tasks
with a single, consistent, pre-configured toolset (note that
**textclean** uses many of these terrific packages as a backend). This
means that the researcher spends less time on munging, leading to
quicker analysis. This package is meant to be used jointly with the
[**textshape**](https://github.com/trinker/textshape) package, which
provides text extraction and reshaping functionality. **textclean**
works well with the
[**qdapRegex**](https://github.com/trinker/qdapRegex) package which
provides tooling for substring substitution and extraction of pre-canned
regular expressions. In addition, the functions of **textclean** are
designed to work within the piping of the tidyverse framework by
consistently using the first argument of functions as the data source.
The **textclean** subbing and replacement tools are particularly
effective within a `dplyr::mutate` statement.


Table of Contents
============

-   [Functions](#functions)
-   [Installation](#installation)
-   [Contact](#contact)
-   [Contributing](#contributing)
-   [Demonstration](#demonstration)
    -   [Load the Packages/Data](#load-the-packagesdata)
    -   [Check Text](#check-text)
    -   [Row Filtering](#row-filtering)
    -   [Stripping](#stripping)
    -   [Subbing](#subbing)
        -   [Multiple Subs](#multiple-subs)
        -   [Match, Extract, Operate, Replacement Subs](#match-extract-operate-replacement-subs)
        -   [Stashing Character Pre-Sub](#stashing-character-pre-sub)
    -   [Replacement](#replacement)
        -   [Contractions](#contractions)
        -   [Dates](#dates)
        -   [Emojis](#emojis)
        -   [Emoticons](#emoticons)
        -   [Grades](#grades)
        -   [HTML](#html)
        -   [Incomplete Sentences](#incomplete-sentences)
        -   [Internet Slang](#internet-slang)
        -   [Kerning](#kerning)
        -   [Money](#money)
        -   [Names](#names)
        -   [Non-ASCII Characters](#non-ascii-characters)
        -   [Numbers](#numbers)
        -   [Ratings](#ratings)
        -   [Ordinal Numbers](#ordinal-numbers)
        -   [Symbols](#symbols)
        -   [Time Stamps](#time-stamps)
        -   [Tokens](#tokens)
        -   [White Space](#white-space)
        -   [Word Elongation](#word-elongation)

Functions
============


The main functions, task category, & descriptions are summarized in the
table below:

<table>
<colgroup>
<col width="34%" />
<col width="17%" />
<col width="48%" />
</colgroup>
<thead>
<tr class="header">
<th>Function</th>
<th>Task</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>mgsub</code></td>
<td>subbing</td>
<td>Multiple <code>gsub</code></td>
</tr>
<tr class="even">
<td><code>fgsub</code></td>
<td>subbing</td>
<td>Functional matching replacement <code>gsub</code></td>
</tr>
<tr class="odd">
<td><code>sub_holder</code></td>
<td>subbing</td>
<td>Hold a value prior to a <code>strip</code></td>
</tr>
<tr class="even">
<td><code>swap</code></td>
<td>subbing</td>
<td>Simultaneously swap patterns 1 &amp; 2</td>
</tr>
<tr class="odd">
<td><code>strip</code></td>
<td>deletion</td>
<td>Remove all non word characters</td>
</tr>
<tr class="even">
<td><code>drop_empty_row</code></td>
<td>filter rows</td>
<td>Remove empty rows</td>
</tr>
<tr class="odd">
<td><code>drop_row</code>/<code>keep_row</code></td>
<td>filter rows</td>
<td>Filter rows matching a regex</td>
</tr>
<tr class="even">
<td><code>drop_NA</code></td>
<td>filter rows</td>
<td>Remove <code>NA</code> text rows</td>
</tr>
<tr class="odd">
<td><code>drop_element</code>/<code>keep_element</code></td>
<td>filter elements</td>
<td>Filter matching elements from a vector</td>
</tr>
<tr class="even">
<td><code>match_tokens</code></td>
<td>filter elements</td>
<td>Filter out tokens from strings that match a regex criteria</td>
</tr>
<tr class="odd">
<td><code>replace_contractions</code></td>
<td>replacement</td>
<td>Replace contractions with both words</td>
</tr>
<tr class="even">
<td><code>replace_date</code></td>
<td>replacement</td>
<td>Replace dates</td>
</tr>
<tr class="odd">
<td><code>replace_email</code></td>
<td>replacement</td>
<td>Replace emails</td>
</tr>
<tr class="even">
<td><code>replace_emoji</code></td>
<td>replacement</td>
<td>Replace emojis with word equivalent or unique identifier</td>
</tr>
<tr class="odd">
<td><code>replace_emoticon</code></td>
<td>replacement</td>
<td>Replace emoticons with word equivalent</td>
</tr>
<tr class="even">
<td><code>replace_grade</code></td>
<td>replacement</td>
<td>Replace grades (e.g., &quot;A+&quot;) with word equivalent</td>
</tr>
<tr class="odd">
<td><code>replace_hash</code></td>
<td>replacement</td>
<td>Replace Twitter style hash tags (e.g., #rstats)</td>
</tr>
<tr class="even">
<td><code>replace_html</code></td>
<td>replacement</td>
<td>Replace HTML tags and symbols</td>
</tr>
<tr class="odd">
<td><code>replace_incomplete</code></td>
<td>replacement</td>
<td>Replace incomplete sentence end-marks</td>
</tr>
<tr class="even">
<td><code>replace_internet_slang</code></td>
<td>replacement</td>
<td>Replace Internet slang with word equivalents</td>
</tr>
<tr class="odd">
<td><code>replace_kern</code></td>
<td>replacement</td>
<td>Replace spaces for &gt;2 letter, all cap, words containing spaces in between letters</td>
</tr>
<tr class="even">
<td><code>replace_money</code></td>
<td>replacement</td>
<td>Replace money in the form of $\d+.?\d{0,2}</td>
</tr>
<tr class="odd">
<td><code>replace_names</code></td>
<td>replacement</td>
<td>Replace common first/last names</td>
</tr>
<tr class="even">
<td><code>replace_non_ascii</code></td>
<td>replacement</td>
<td>Replace non-ASCII with equivalent or remove</td>
</tr>
<tr class="odd">
<td><code>replace_number</code></td>
<td>replacement</td>
<td>Replace common numbers</td>
</tr>
<tr class="even">
<td><code>replace_ordinal</code></td>
<td>replacement</td>
<td>Replace common ordinal number form</td>
</tr>
<tr class="odd">
<td><code>replace_rating</code></td>
<td>replacement</td>
<td>Replace ratings (e.g., &quot;10 out of 10&quot;, &quot;3 stars&quot;) with word equivalent</td>
</tr>
<tr class="even">
<td><code>replace_symbol</code></td>
<td>replacement</td>
<td>Replace common symbols</td>
</tr>
<tr class="odd">
<td><code>replace_tag</code></td>
<td>replacement</td>
<td>Replace Twitter style handle tag (e.g., <span class="citation">@trinker</span>)</td>
</tr>
<tr class="even">
<td><code>replace_time</code></td>
<td>replacement</td>
<td>Replace time stamps</td>
</tr>
<tr class="odd">
<td><code>replace_to</code>/<code>replace_from</code></td>
<td>replacement</td>
<td>Remove from/to begin/end of string to/from a character(s)</td>
</tr>
<tr class="even">
<td><code>replace_token</code></td>
<td>replacement</td>
<td>Remove or replace a vector of tokens with a single value</td>
</tr>
<tr class="odd">
<td><code>replace_url</code></td>
<td>replacement</td>
<td>Replace URLs</td>
</tr>
<tr class="even">
<td><code>replace_white</code></td>
<td>replacement</td>
<td>Replace regex white space characters</td>
</tr>
<tr class="odd">
<td><code>replace_word_elongation</code></td>
<td>replacement</td>
<td>Replace word elongations with shortened form</td>
</tr>
<tr class="even">
<td><code>add_comma_space</code></td>
<td>replacement</td>
<td>Replace non-space after comma</td>
</tr>
<tr class="odd">
<td><code>add_missing_endmark</code></td>
<td>replacement</td>
<td>Replace missing endmarks with desired symbol</td>
</tr>
<tr class="even">
<td><code>make_plural</code></td>
<td>replacement</td>
<td>Add plural endings to singular noun forms</td>
</tr>
<tr class="odd">
<td><code>check_text</code></td>
<td>check</td>
<td>Text report of potential issues</td>
</tr>
<tr class="even">
<td><code>has_endmark</code></td>
<td>check</td>
<td>Check if an element has an end-mark</td>
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
- submit suggestions and bug-reports at:
<https://github.com/trinker/textclean/issues>

Contributing
============

Contributions are welcome from anyone subject to the following rules:

-   Abide by the [code of conduct](CONDUCT.md).
-   Follow the style conventions of the package (indentation, function &
    argument naming, commenting, etc.)
-   All contributions must be consistent with the package license
    (GPL-2)
-   Submit contributions as a pull request. Clearly state what the
    changes are and try to keep the number of changes per pull request
    as low as possible.
-   If you make big changes, add your name to the 'Author' field.

Demonstration
=============

Load the Packages/Data
----------------------

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load(dplyr)
    pacman::p_load_gh("trinker/textshape", "trinker/lexicon", "trinker/textclean")

Check Text
----------

One of the most useful tools in **textclean** is `check_text` which
scans text variables and reports potential problems. Not all potential
problems are definite problems for analysis but the report provides an
overview of what may need further preparation. The report also provides
suggested functions for the reported problems. The report provides
information on the following:

1.  **contraction** - Text elements that contain contractions
2.  **date** - Text elements that contain dates
3.  **digit** - Text elements that contain digits/numbers
4.  **email** - Text elements that contain email addresses
5.  **emoticon** - Text elements that contain emoticons
6.  **empty** - Text elements that contain empty text cells (all white
    space)
7.  **escaped** - Text elements that contain escaped back spaced
    characters
8.  **hash** - Text elements that contain Twitter style hash tags (e.g.,
    \#rstats)
9.  **html** - Text elements that contain HTML markup
10. **incomplete** - Text elements that contain incomplete sentences
    (e.g., uses ending punctuation like '...')
11. **kern** - Text elements that contain kerning (e.g., 'The B O M B!')
12. **list\_column** - Text variable that is a list column
13. **missing\_value** - Text elements that contain missing values
14. **misspelled** - Text elements that contain potentially misspelled
    words
15. **no\_alpha** - Text elements that contain elements with no
    alphabetic (a-z) letters
16. **no\_endmark** - Text elements that contain elements with missing
    ending punctuation
17. **no\_space\_after\_comma** - Text elements that contain commas with
    no space afterwards
18. **non\_ascii** - Text elements that contain non-ASCII text
19. **non\_character** - Text variable that is not a character column
    (likely `factor`)
20. **non\_split\_sentence** - Text elements that contain unsplit
    sentences (more than one sentence per element)
21. **tag** - Text elements that contain Twitter style handle tags
    (e.g., @trinker)
22. **time** - Text elements that contain timestamps
23. **url** - Text elements that contain URLs

Note that `check_text` is running multiple checks and may be slower on
larger texts. The user may provide a sample of text for review or use
the `checks` argument to specify the exact checks to conduct and thus
limit the compute time.

Here is an example:

    x <- c("i like", "<p>i want. </p>. thet them ther .", "I am ! that|", "", NA, 
        "&quot;they&quot; they,were there", ".", "   ", "?", "3;", "I like goud eggs!", 
        "bi\xdfchen Z\xfcrcher", "i 4like...", "\\tgreat",  "She said \"yes\"")
    Encoding(x) <- "latin1"
    x <- as.factor(x)
    check_text(x)

    ## 
    ## =============
    ## NON CHARACTER
    ## =============
    ## 
    ## The text variable is not a character column (likely `factor`):
    ## 
    ## 
    ## *Suggestion: Consider using `as.character` or `stringsAsFactors = FALSE` when reading in
    ##              Also, consider rerunning `check_text` after fixing
    ## 
    ## 
    ## =====
    ## DIGIT
    ## =====
    ## 
    ## The following observations contain digits/numbers:
    ## 
    ## 10, 13
    ## 
    ## This issue affected the following text:
    ## 
    ## 10: 3;
    ## 13: i 4like...
    ## 
    ## *Suggestion: Consider using `replace_number`
    ## 
    ## 
    ## ========
    ## EMOTICON
    ## ========
    ## 
    ## The following observations contain emoticons:
    ## 
    ## 6
    ## 
    ## This issue affected the following text:
    ## 
    ## 6: &quot;they&quot; they,were there
    ## 
    ## *Suggestion: Consider using `replace_emoticons`
    ## 
    ## 
    ## =====
    ## EMPTY
    ## =====
    ## 
    ## The following observations contain empty text cells (all white space):
    ## 
    ## 1
    ## 
    ## This issue affected the following text:
    ## 
    ## 1: i like
    ## 
    ## *Suggestion: Consider running `drop_empty_row`
    ## 
    ## 
    ## =======
    ## ESCAPED
    ## =======
    ## 
    ## The following observations contain escaped back spaced characters:
    ## 
    ## 14
    ## 
    ## This issue affected the following text:
    ## 
    ## 14: \tgreat
    ## 
    ## *Suggestion: Consider using `replace_white`
    ## 
    ## 
    ## ====
    ## HTML
    ## ====
    ## 
    ## The following observations contain HTML markup:
    ## 
    ## 2, 6
    ## 
    ## This issue affected the following text:
    ## 
    ## 2: <p>i want. </p>. thet them ther .
    ## 6: &quot;they&quot; they,were there
    ## 
    ## *Suggestion: Consider running `replace_html`
    ## 
    ## 
    ## ==========
    ## INCOMPLETE
    ## ==========
    ## 
    ## The following observations contain incomplete sentences (e.g., uses ending punctuation like '...'):
    ## 
    ## 13
    ## 
    ## This issue affected the following text:
    ## 
    ## 13: i 4like...
    ## 
    ## *Suggestion: Consider using `replace_incomplete`
    ## 
    ## 
    ## =============
    ## MISSING VALUE
    ## =============
    ## 
    ## The following observations contain missing values:
    ## 
    ## 5
    ## 
    ## *Suggestion: Consider running `drop_NA`
    ## 
    ## 
    ## ========
    ## NO ALPHA
    ## ========
    ## 
    ## The following observations contain elements with no alphabetic (a-z) letters:
    ## 
    ## 4, 7, 8, 9, 10
    ## 
    ## This issue affected the following text:
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
    ## ==========
    ## NO ENDMARK
    ## ==========
    ## 
    ## The following observations contain elements with missing ending punctuation:
    ## 
    ## 1, 3, 4, 6, 8, 10, 12, 14, 15
    ## 
    ## This issue affected the following text:
    ## 
    ## 1: i like
    ## 3: I am ! that|
    ## 4: 
    ## 6: &quot;they&quot; they,were there
    ## 8:    
    ## 10: 3;
    ## 12: bißchen Zürcher
    ## 14: \tgreat
    ## 15: She said "yes"
    ## 
    ## *Suggestion: Consider cleaning the raw text or running `add_missing_endmark`
    ## 
    ## 
    ## ====================
    ## NO SPACE AFTER COMMA
    ## ====================
    ## 
    ## The following observations contain commas with no space afterwards:
    ## 
    ## 6
    ## 
    ## This issue affected the following text:
    ## 
    ## 6: &quot;they&quot; they,were there
    ## 
    ## *Suggestion: Consider running `add_comma_space`
    ## 
    ## 
    ## =========
    ## NON ASCII
    ## =========
    ## 
    ## The following observations contain non-ASCII text:
    ## 
    ## 12
    ## 
    ## This issue affected the following text:
    ## 
    ## 12: bißchen Zürcher
    ## 
    ## *Suggestion: Consider running `replace_non_ascii`
    ## 
    ## 
    ## ==================
    ## NON SPLIT SENTENCE
    ## ==================
    ## 
    ## The following observations contain unsplit sentences (more than one sentence per element):
    ## 
    ## 2, 3
    ## 
    ## This issue affected the following text:
    ## 
    ## 2: <p>i want. </p>. thet them ther .
    ## 3: I am ! that|
    ## 
    ## *Suggestion: Consider running `textshape::split_sentence`

And if all is well the user should be greeted by a cow:

    y <- c("A valid sentence.", "yet another!")
    check_text(y)

    ## 
    ##  ------------- 
    ## No problems found!
    ## This text is remarkable! 
    ##  ---------------- 
    ##   \   ^__^ 
    ##    \  (oo)\ ________ 
    ##       (__)\         )\ /\ 
    ##            ||------w|
    ##            ||      ||

Row Filtering
-------------

It is useful to drop/remove empty rows or unwanted rows (for example the
researcher dialogue from a transcript). The `drop_empty_row` &
`drop_row` do empty row do just this. First I'll demo the removal of
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

    drop_empty_row(dat)

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

Next we drop out rows. The `drop_row` function takes a data set, a
column (named or numeric position) and regex terms to search for. The
`terms` argument takes regex(es) allowing for partial matching. `terms`
is case sensitive but can be changed via the `ignore.case` argument.

    drop_row(dataframe = DATA, column = "person", terms = c("sam", "greg"))

    ##       person sex adult                         state code
    ## 1    teacher   m     1            What should we do?   K3
    ## 2      sally   f     0        How can we be certain?   K6
    ## 3      sally   f     0   What are you talking about?   K9
    ## 4 researcher   f     1 Shall we move on?  Good then.  K10

    drop_row(DATA, 1, c("sam", "greg"))

    ##       person sex adult                         state code
    ## 1    teacher   m     1            What should we do?   K3
    ## 2      sally   f     0        How can we be certain?   K6
    ## 3      sally   f     0   What are you talking about?   K9
    ## 4 researcher   f     1 Shall we move on?  Good then.  K10

    keep_row(DATA, 1, c("sam", "greg"))

    ##   person sex adult                                 state code
    ## 1    sam   m     0         Computer is fun. Not too fun.   K1
    ## 2   greg   m     0               No it's not, it's dumb.   K2
    ## 3    sam   m     0                  You liar, it stinks!   K4
    ## 4   greg   m     0               I am telling the truth!   K5
    ## 5   greg   m     0                      There is no way.   K7
    ## 6    sam   m     0                       I distrust you.   K8
    ## 7   greg   m     0 I'm hungry.  Let's eat.  You already?  K11

    drop_row(DATA, "state", c("Comp"))

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

    drop_row(DATA, "state", c("I "))

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

    drop_row(DATA, "state", c("you"), ignore.case = TRUE)

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
    ## [10] "Shall we move on?  Good then."             
    ## [11] "<<I am>> hungry.  Let's eat.  You already?"

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
    ## [10] "Shall we move on<<PUNCT>>  Good then<<PUNCT>>"                                
    ## [11] "I<<PUNCT>>m hungry<<PUNCT>>  Let<<PUNCT>>s eat<<PUNCT>>  You already<<PUNCT>>"

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
    ## [10] "Shall we move on?  Good then."        
    ## [11] "I'm hungry.  Let's eat.  You already?"

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
    ## [10] "Shall we move on?  Good then."        
    ## [11] "I'm hungry.  Let's eat.  You already?"

#### Safe Substitutions

The default behavior of `mgsub` is optimized for speed. This means that
it is very fast at multiple substitutions and in most cases works
efficiently. However, it is not what Mark Ewing describes as "safe"
substitution. In his vignette for the
[**mgsub**](https://github.com/bmewing/mgsub) package, Mark defines
"safe" as:

> 1.  Longer matches are preferred over shorter matches for substitution
>     first
> 2.  No placeholders are used so accidental string collisions don't
>     occur

Because safety is sometimes required, `textclean::mgsub` provides a
`safe` argument using the **mgsub** package as the backend. In addition
to the `safe` argument the `mgsub_regex_safe` function is available to
make the usage more explicit. The safe mode comes at the cost of speed.

    x <- "Dopazamine is a fake chemical"
    pattern <- c("dopazamin", "do.*ne")
    replacement <- c("freakout", "metazamine")

    ## Unsafe
    mgsub(x, pattern, replacement, ignore.case=TRUE, fixed = FALSE)

    ## [1] "freakoute is a fake chemical"

    ## Safe
    mgsub(x, pattern, replacement, ignore.case=TRUE, fixed = FALSE, safe = TRUE)

    ## [1] "metazamine is a fake chemical"

    ## Or alternatively
    mgsub_regex_safe(x, pattern, replacement, ignore.case=TRUE)

    ## [1] "metazamine is a fake chemical"

    x <- "hey, how are you?"
    pattern <- c("hey", "how", "are", "you")
    replacement <- c("how", "are", "you", "hey")

    ## Unsafe
    mgsub(x, pattern,replacement)

    ## [1] "how, are you how?"

    ## Safe
    mgsub_regex_safe(x, pattern,replacement)

    ## [1] "how, are you hey?"

### Match, Extract, Operate, Replacement Subs

Again, `gsub` is a great tool but sometimes the user wants to match a
pattern, extract that pattern, operate a function over that pattern, and
then replace the original match. The `fgsub` function allows the user to
perform this operation. It is a stripped down version of `gsubfn` from
the **gsubfn** package. For more versatile needs please see the
**gsubfn** package.

In this example the regex looks for words that contain a lower case
letter followed by the same letter at least 2 more times. It then
extracts these words, splits them appart into letters, reverses the
string, pastes them back together, wraps them with double angle braces,
and then puts them back at the original locations.

    fgsub(
        x = c(NA, 'df dft sdf', 'sd fdggg sd dfhhh d', 'ddd'),
        pattern = "\\b\\w*([a-z])(\\1{2,})\\w*\\b",
        fun = function(x) {paste0('<<', paste(rev(strsplit(x, '')[[1]]), collapse =''), '>>')}
    )

    ## [1] NA                            "df dft sdf"                 
    ## [3] "sd <<gggdf>> sd <<hhhfd>> d" "<<ddd>>"

In this example we extract numbers, strip out non-digits, coerce them to
numeric, cut them in half, round up to the closest integer, add the
commas back, and replace back into the original locations.

    fgsub(
        x = c(NA, 'I want 32 grapes', 'he wants 4 ice creams', 'they want 1,234,567 dollars'),
        pattern = "[\\d,]+",
        fun = function(x) {prettyNum(ceiling(as.numeric(gsub('[^0-9]', '', x))/2), big.mark = ',')}
    )

    ## [1] NA                          "I want 16 grapes"         
    ## [3] "he wants 2 ice creams"     "they want 617,284 dollars"

### Stashing Character Pre-Sub

There are times the user may want to stash a set of characters before
subbing out and then return the stashed characters. An example of this
is when a researcher wants to remove punctuation but not emoticons. The
`subholder` function provides tooling to stash the emoticons, allow a
punctuation stripping, and then return the emoticons. First I'll create
some fake text data with emoticons, then stash the emoticons (using a
unique text key to hold their place), then I'll strip out the
punctuation, and last put the stashed emoticons back.

    (fake_dat <- paste(hash_emoticons[1:11, 1, with=FALSE][[1]], DATA$state))

    ##  [1] "#-) Computer is fun. Not too fun."         
    ##  [2] "%) No it's not, it's dumb."                
    ##  [3] "%-) What should we do?"                    
    ##  [4] "',:-l You liar, it stinks!"                
    ##  [5] "',:-| I am telling the truth!"             
    ##  [6] "*) How can we be certain?"                 
    ##  [7] "*-) There is no way."                      
    ##  [8] "*<|:-) I distrust you."                    
    ##  [9] "*\\0/* What are you talking about?"        
    ## [10] "0:) Shall we move on?  Good then."         
    ## [11] "0:-) I'm hungry.  Let's eat.  You already?"

    (m <- sub_holder(fake_dat, hash_emoticons[[1]]))

    ##  [1] "zzzplaceholderaazzz Computer is fun. Not too fun."        
    ##  [2] "zzzplaceholderbazzz No it's not, it's dumb."              
    ##  [3] "zzzplaceholdercazzz What should we do?"                   
    ##  [4] "zzzplaceholderdazzz You liar, it stinks!"                 
    ##  [5] "zzzplaceholdereazzz I am telling the truth!"              
    ##  [6] "zzzplaceholderfazzz How can we be certain?"               
    ##  [7] "zzzplaceholdergazzz There is no way."                     
    ##  [8] "zzzplaceholderhazzz I distrust you."                      
    ##  [9] "zzzplaceholderiazzz What are you talking about?"          
    ## [10] "zzzplaceholderjazzz Shall we move on?  Good then."        
    ## [11] "zzzplaceholderkazzz I'm hungry.  Let's eat.  You already?"

    (m_stripped <-strip(m$output))

    ##  [1] "zzzplaceholderaazzz computer is fun not too fun"     
    ##  [2] "zzzplaceholderbazzz no it's not it's dumb"           
    ##  [3] "zzzplaceholdercazzz what should we do"               
    ##  [4] "zzzplaceholderdazzz you liar it stinks"              
    ##  [5] "zzzplaceholdereazzz i am telling the truth"          
    ##  [6] "zzzplaceholderfazzz how can we be certain"           
    ##  [7] "zzzplaceholdergazzz there is no way"                 
    ##  [8] "zzzplaceholderhazzz i distrust you"                  
    ##  [9] "zzzplaceholderiazzz what are you talking about"      
    ## [10] "zzzplaceholderjazzz shall we move on good then"      
    ## [11] "zzzplaceholderkazzz i'm hungry let's eat you already"

    m$unhold(m_stripped)

    ##  [1] "#-) computer is fun not too fun"      
    ##  [2] "%) no it's not it's dumb"             
    ##  [3] "%-) what should we do"                
    ##  [4] "',:-l you liar it stinks"             
    ##  [5] "',:-| i am telling the truth"         
    ##  [6] "*) how can we be certain"             
    ##  [7] "*-) there is no way"                  
    ##  [8] "*<|:-) i distrust you"                
    ##  [9] "*\\0/* what are you talking about"    
    ## [10] "0:) shall we move on good then"       
    ## [11] "0:-) i'm hungry let's eat you already"

Of course with clever regexes you can achieve the same thing:

    ord_emos <- hash_emoticons[[1]][order(nchar(hash_emoticons[[1]]))]

    ## This step ensures that longer strings are matched first but can 
    ## fail in cases that use quantifiers.  These can appear short but in
    ## reality can match long strings and would be ordered last in the 
    ## replacement, meaning that the shorter regex took precedent.
    emos <- paste(
        gsub('([().\\|[{}^$*+?])', '\\\\\\1', ord_emos),
        collapse = '|'
    )

    gsub(
        sprintf('(%s)(*SKIP)(*FAIL)|[^\'[:^punct:]]', emos), 
        '', 
        fake_dat, 
        perl = TRUE
    )

    ##  [1] "#-) Computer is fun Not too fun"        
    ##  [2] "%) No it's not it's dumb"               
    ##  [3] "%-) What should we do"                  
    ##  [4] "',:-l You liar it stinks"               
    ##  [5] "',:-| I am telling the truth"           
    ##  [6] "*) How can we be certain"               
    ##  [7] "*-) There is no way"                    
    ##  [8] "*<|:-) I distrust you"                  
    ##  [9] "*\\0/* What are you talking about"      
    ## [10] "0:) Shall we move on  Good then"        
    ## [11] "0:-) I'm hungry  Let's eat  You already"

The pure regex approach can be a bit trickier (less safe) and more
difficult to reason about. It also relies on the less general
`(*SKIP)(*FAIL)` backtracking control verbs that are only implemented in
a few applications like Perl & PCRE. Still, it's nice to see an
alternative regex approach for comparison.

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

### Dates

    x <- c(NA, '11-16-1980 and 11/16/1980', "and 2017-02-08 but then there's 2/8/2017 too")

    replace_date(x)

    ## [1] NA                                                                                                             
    ## [2] "November sixteenth, one thousand nine hundred eighty and November sixteenth, one thousand nine hundred eighty"
    ## [3] "and February eighth, two thousand seventeen but then there's February eighth, two thousand seventeen too"

    replace_date(x, replacement = '<<DATE>>')

    ## [1] NA                                          
    ## [2] "<<DATE>> and <<DATE>>"                     
    ## [3] "and <<DATE>> but then there's <<DATE>> too"

### Emojis

Similar to emoticons, emoji tokens may be ignored if they are not in a
computer readable form. `replace_emoji` replaces emojis with their word
forms equivalents.

    x <- read.delim(system.file("docs/r_tweets.txt", package = "textclean"), 
        stringsAsFactors = FALSE)[[3]][1:3]

    x

    ## [1] "Hello, helpful! ðŸ“¦â\235ŒðŸ‘¾ debugme: Easy & efficient debugging for R packages ðŸ‘¨ðŸ\217»â\200\215ðŸ’» @GaborCsardi https://buff.ly/2nNKcps  #rstats"
    ## [2] "Did you ever get bored and accidentally create a ðŸ“¦ to make #Rstats speak on a Mac? I have -> "                                            
    ## [3] "A gift to my fellow nfl loving #rstats folks this package is ðŸ’¥ðŸ’¥"

    replace_emoji(x)

    ## [1] "Hello, helpful! package cross mark alien monster debugme: Easy & efficient debugging for R packages man <f0><9f><8f><bb><e2><80><8d> laptop computer @GaborCsardi https://buff.ly/2nNKcps #rstats"
    ## [2] "Did you ever get bored and accidentally create a package to make #Rstats speak on a Mac? I have -> "                                                                                              
    ## [3] "A gift to my fellow nfl loving #rstats folks this package is collision collision "

### Emoticons

Some analysis techniques examine words, meaning emoticons may be
ignored. `replace_emoticon` replaces emoticons with their word forms
equivalents.

    x <- c(
        "text from: http://www.webopedia.com/quick_ref/textmessageabbreviations_02.asp",
        "... understanding what different characters used in smiley faces mean:",
        "The close bracket represents a sideways smile  )",
        "Add in the colon and you have sideways eyes   :",
        "Put them together to make a smiley face  :)",
        "Use the dash -  to add a nose   :-)",
        "Change the colon to a semi-colon ; and you have a winking face ;)  with a nose  ;-)",
        "Put a zero 0 (halo) on top and now you have a winking, smiling angel 0;) with a nose 0;-)",
        "Use the letter 8 in place of the colon for sunglasses 8-)",
        "Use the open bracket ( to turn the smile into a frown  :-("
    )

    replace_emoticon(x)

    ##  [1] "text from: http skeptical /www.webopedia.com/quick_ref/textmessageabbreviations_02.asp"         
    ##  [2] "... understanding what different characters used in smiley faces mean:"                         
    ##  [3] "The close bracket represents a sideways smile )"                                                
    ##  [4] "Add in the colon and you have sideways eyes :"                                                  
    ##  [5] "Put them together to make a smiley face smiley "                                                
    ##  [6] "Use the dash - to add a nose smiley "                                                           
    ##  [7] "Change the colon to a semi-colon ; and you have a winking face wink with a nose wink "          
    ##  [8] "Put a zero 0 (halo) on top and now you have a winking, smiling angel 0 wink with a nose 0 wink "
    ##  [9] "Use the letter 8 in place of the colon for sunglasses smiley "                                  
    ## [10] "Use the open bracket ( to turn the smile into a frown frown "

### Grades

In analysis where grades may be discussed it may be useful to convert
the letter forms into word meanings. The `replace_grade` can be used for
this task.

    text <- c(
        "I give an A+",
        "He deserves an F",
        "It's C+ work",
        "A poor example deserves a C!"
    )
    replace_grade(text)

    ## [1] "I give an very excellent excellent"
    ## [2] "He deserves an very very bad"      
    ## [3] "It's slightly above average work"  
    ## [4] "A poor example deserves a average!"

### HTML

Sometimes HTML tags and symbols stick around like pesky gnats. The
`replace_html` function makes light work of them.

    x <- c(
        "<bold>Random</bold> text with symbols: &nbsp; &lt; &gt; &amp; &quot; &apos;",
        "<p>More text</p> &cent; &pound; &yen; &euro; &copy; &reg;"
    )

    replace_html(x)

    ## [1] " Random  text with symbols:   < > & \" '" 
    ## [2] " More text  cents pounds yen euro (c) (r)"

### Incomplete Sentences

Sometimes an incomplete sentence is denoted with multiple end marks or
no punctuation at all. `replace_incomplete` standardizes these sentences
with a pipe (`|`) endmark (or one of the user's choice).

    x <- c("the...",  "I.?", "you.", "threw..", "we?")
    replace_incomplete(x)

    ## [1] "the|"   "I|"     "you."   "threw|" "we?"

    replace_incomplete(x, '...')

    ## [1] "the..."   "I..."     "you."     "threw..." "we?"

### Internet Slang

Often in informal written and spoken communication (e.g., Twitter,
texting, Facebook, etc.) people use Internet slang, shorter
abbreviations and acronyms, to replace longer word sequences. These
replacements may obfuscate the meaning when the machine attempts to
analyze the text. The `replace_internet_slang` function replaces the
slang with longer word equivalents that are more easily analyzed by
machines.

    x <- c(
        "TGIF and a big w00t!  The weekend is GR8!",
        "NP it was my pleasure: EOM",
        'w8...this n00b needs me to say LMGTFY...lol.',
        NA
    )

    replace_internet_slang(x)

    ## [1] "thank god, it's friday and a big hooray!  The weekend is great!"                   
    ## [2] "no problem it was my pleasure: end of message"                                     
    ## [3] "wait...this newbie needs me to say let me google that for you...laughing out loud."
    ## [4] NA

### Kerning

In typography kerning is the adjustment of spacing. Often, in informal
writing, adding manual spaces (a form of kerning) coupled with all
capital letters is used for emphasis (e.g., `"She's the B O M B!"`).
These word forms would look like noise in most analysis and would likely
be removed as a stopword when in fact they likely carry a great deal of
meaning. The `replace_kern` function looks for 3 or more consecutive
capital letters with spaces in between and removes the spaces.

    x <- c(
        "Welcome to A I: the best W O R L D!",
        "Hi I R is the B O M B for sure: we A G R E E indeed.",
        "A sort C A T indeed!",
        NA
    )

    replace_kern(x)

    ## [1] "Welcome to A I: the best WORLD!"              
    ## [2] "Hi I R is the BOMB for sure: we AGREE indeed."
    ## [3] "A sort CAT indeed!"                           
    ## [4] NA

### Money

There are times one may want to replace money mentions with text or
normalized versions. The `replace_money` function is designed to
complete this task.

    x <- c(NA, '$3.16 into "three dollars, sixteen cents"', "-$20,333.18 too", 'fff')
     
    replace_money(x)

    ## [1] NA                                                                                  
    ## [2] "three dollars and sixteen cents into \"three dollars, sixteen cents\""             
    ## [3] "negative twenty thousand three hundred thirty three dollars and eighteen cents too"
    ## [4] "fff"

    replace_money(x, replacement = '<<MONEY>>')

    ## [1] NA                                               
    ## [2] "<<MONEY>> into \"three dollars, sixteen cents\""
    ## [3] "<<MONEY>> too"                                  
    ## [4] "fff"

### Names

Often one will want to standardize text by removing first and last
names. The `replace_names` function quickly removes/replaces common
first and last names. This can be made more targeted by feeding a vector
of names extracted via a named entity extractor.

    x <- c(
        "Mary Smith is not here",
         "Karen is not a nice person",
         "Will will do it",
        NA
    )
     
    replace_names(x)

    ## [1] "  is not here"         " is not a nice person" " will do it"          
    ## [4] NA

    replace_names(x, replacement = '<<NAME>>')

    ## [1] "<<NAME>> <<NAME>> is not here" "<<NAME>> is not a nice person"
    ## [3] "<<NAME>> will do it"           NA

### Non-ASCII Characters

R can choke on non-ASCII characters. They can be re-encoded but the new
encoding may lack interpretability (e.g., ¢ may be converted to `\xA2`
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

    ## [1] "Hello World"                 "6 Ekstrom"                  
    ## [3] "Joreskog"                    "bisschen Zurcher"           
    ## [5] "This is a (C) but not a (R)" "6 / 2 = 3"                  
    ## [7] "fractions 1/4, 1/2, 3/4"     "cows go mu"                 
    ## [9] "30 cent"

    replace_non_ascii(x, remove.nonconverted = FALSE)

    ## [1] "Hello World"                 "6 Ekstrom"                  
    ## [3] "Joreskog"                    "bisschen Zurcher"           
    ## [5] "This is a (C) but not a (R)" "6 / 2 = 3"                  
    ## [7] "fractions  1/4,  1/2,  3/4"  "cows go <c2> mu "           
    ## [9] "30<c2> cent "

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

    ## [1] "I like  ice cream cones." "They are  percent good"

### Ratings

Some texts use ratings to convey satisfaction with a particular object.
The `replace_rating` function replaces the more abstract rating with
word equivalents.

    x <- c("This place receives 5 stars for their APPETIZERS!!!",
         "Four stars for the food & the guy in the blue shirt for his great vibe!",
         "10 out of 10 for both the movie and trilogy.",
         "* Both the Hot & Sour & the Egg Flower Soups were absolutely 5 Stars!",
         "For service, I give them no stars.", "This place deserves no stars.",
         "10 out of 10 stars.",
         "My rating: just 3 out of 10.",
         "If there were zero stars I would give it zero stars.",
         "Rating: 1 out of 10.",
         "I gave it 5 stars because of the sound quality.",
         "If it were possible to give them 0/10, they'd have it."
    )

    replace_rating(x)

    ##  [1] "This place receives best for their APPETIZERS!!!"                    
    ##  [2] " better for the food & the guy in the blue shirt for his great vibe!"
    ##  [3] " best for both the movie and trilogy."                               
    ##  [4] "* Both the Hot & Sour & the Egg Flower Soups were absolutely best !" 
    ##  [5] "For service, I give them terrible ."                                 
    ##  [6] "This place deserves terrible ."                                      
    ##  [7] " best stars."                                                        
    ##  [8] "My rating: just below average ."                                     
    ##  [9] "If there were terrible I would give it terrible ."                   
    ## [10] "Rating: extremely below average ."                                   
    ## [11] "I gave it best because of the sound quality."                        
    ## [12] "If it were possible to give them terrible , they'd have it."

### Ordinal Numbers

Again, some analysis requires numbers, including ordinal numbers, to be
converted to text form. `replace_ordinal` attempts to perform this task
for ordinal number 1-100 (i.e., 1st - 100th).

    x <- c(
        "I like the 1st one not the 22nd one.", 
        "For the 100th time stop those 3 things!",
        "I like the 3rd 1 not the 12th 1."
    )
    replace_ordinal(x)

    ## [1] "I like the  first  one not the  twenty second  one."
    ## [2] "For the  hundredth  time stop those 3 things!"      
    ## [3] "I like the  third  1 not the  twelfth  1."

    replace_ordinal(x, TRUE)

    ## [1] "I like the  first  one not the  twentysecond  one."
    ## [2] "For the  hundredth  time stop those 3 things!"     
    ## [3] "I like the  third  1 not the  twelfth  1."

    replace_ordinal(x, remove = TRUE)

    ## [1] "I like the    one not the    one."   
    ## [2] "For the    time stop those 3 things!"
    ## [3] "I like the    1 not the    1."

    replace_number(replace_ordinal(x))

    ## [1] "I like the  first  one not the  twenty second  one."
    ## [2] "For the  hundredth  time stop those three things!"  
    ## [3] "I like the  third  one not the  twelfth  one."

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

    ## [1] "I am  at  Jon's  and  Jim's  with  Marry"
    ## [2] "I owe  dollar 41 for food"               
    ## [3] "two is 10 percent  of a  number "

### Time Stamps

Often times the researcher will want to replace times with a text or
normalized version. The `replace_time` function works well for this
task. Notice that replacement takes a function that can operate on the
extracted pattern.

    x <- c(
        NA, '12:47 to "twelve forty-seven" and also 8:35:02',
        'what about 14:24.5', 'And then 99:99:99?'
    )

    ## Textual: Word version
    replace_time(x)

    ## [1] NA                                                                                       
    ## [2] "twelve forty seven to \"twelve forty-seven\" and also eight thirty five and two seconds"
    ## [3] "what about fourteen twenty four and five seconds"                                       
    ## [4] "And then 99:99:99?"

    ## Normalization: <<TIME>>
    replace_time(x, replacement = '<<TIME>>')

    ## [1] NA                                                    
    ## [2] "<<TIME>> to \"twelve forty-seven\" and also <<TIME>>"
    ## [3] "what about <<TIME>>"                                 
    ## [4] "And then 99:99:99?"

    ## Normalization: hh:mm:ss or hh:mm
    replace_time(x, replacement = function(y){
            z <- unlist(strsplit(y, '[:.]'))
            z[1] <- 'hh'
            z[2] <- 'mm'
            if(!is.na(z[3])) z[3] <- 'ss'
            textclean::collapse(z, ':')
        }
    )

    ## [1] NA                                                 
    ## [2] "hh:mm to \"twelve forty-seven\" and also hh:mm:ss"
    ## [3] "what about hh:mm:ss"                              
    ## [4] "And then 99:99:99?"

    ## Textual: Word version (forced seconds)
    replace_time(x, replacement = function(y){
            z <- replace_number(unlist(strsplit(y, '[:.]')))
            z[3] <- paste0('and ', ifelse(is.na(z[3]), '0', z[3]), ' seconds')
            paste(z, collapse = ' ')
        }
    )

    ## [1] NA                                                                                                     
    ## [2] "twelve forty seven and 0 seconds to \"twelve forty-seven\" and also eight thirty five and two seconds"
    ## [3] "what about fourteen twenty four and five seconds"                                                     
    ## [4] "And then 99:99:99?"

### Tokens

Often an analysis requires converting tokens of a certain type into a
common form or removing them entirely. The `mgsub` function can do this
task, however it is regex based and time consuming when the number of
tokens to replace is large. For example, one may want to replace all
proper nouns that are first names with the word name. The
`replace_token` provides a fast way to replace a group of tokens with a
single replacement.

This example shows a use case for `replace_token`:

    ## Set Up the Tokens to Replace
    nms <- gsub("(^.)(.*)", "\\U\\1\\L\\2", lexicon::common_names, perl = TRUE)
    head(nms)

    ## [1] "Mary"      "Patricia"  "Linda"     "Barbara"   "Elizabeth" "Jennifer"

    ## Set Up the Data
    x <- textshape::split_portion(sample(c(sample(lexicon::grady_augmented, 20000), 
        sample(nms, 10000, TRUE))), n.words = 12)
    x$text.var <- paste0(x$text.var, sample(c('.', '!', '?'), length(x$text.var), TRUE))
    head(x$text.var)

    ## [1] "oothecae clotty Towanda newsier maestros Richie prophetesses savvying bulldozed boccies lordings invigorates!"
    ## [2] "moating gourde exacta echinoids polynyas rottennesses Jolene Sylvia trish polluting Carolyn suaver?"          
    ## [3] "Vince superimposed halakah cabochon wencher Dortha Natalya Francisca India Milagro metalworks Krissy."        
    ## [4] "Phylis unscrupulously capstones Marcellus Neville snottier haling rejectees mome cottony lonelinesses sneaky!"
    ## [5] "accouter contemplated presentable interest Rivka Ozell scows eyeletting mote apodal ac depurated!"            
    ## [6] "Jani vicugnas fodders galoshes clown biggies arlinda bescorches geothermal inducement selflessnesses spriggy!"

    head(replace_tokens(x$text.var, nms, 'NAME'))

    ## [1] "oothecae clotty NAME newsier maestros NAME prophetesses savvying bulldozed boccies lordings invigorates!"     
    ## [2] "moating gourde exacta echinoids polynyas rottennesses NAME NAME trish polluting NAME suaver?"                 
    ## [3] "NAME superimposed halakah cabochon wencher NAME NAME NAME NAME NAME metalworks NAME."                         
    ## [4] "NAME unscrupulously capstones NAME NAME snottier haling rejectees mome cottony lonelinesses sneaky!"          
    ## [5] "accouter contemplated presentable interest NAME NAME scows eyeletting mote apodal ac depurated!"              
    ## [6] "NAME vicugnas fodders galoshes clown biggies arlinda bescorches geothermal inducement selflessnesses spriggy!"

This demonstration shows how fast token replacement can be with
`replace_token`:

    ## mgsub
    tic <- Sys.time()
    head(mgsub(x$text.var, nms, "NAME"))

    ## [1] "oothecae clotty NAME newsier maestros NAME prophetesses savvying bulldozed boccies lordings invigorates!"     
    ## [2] "moating gourde exacta echinoids polynyas rottennesses NAME NAME trish polluting NAME suaver?"                 
    ## [3] "NAME superimposed halakah cabochon wencher NAME NAME NAME NAME NAME metalworks NAME."                         
    ## [4] "NAME unscrupulously capstones NAME NAME snottier haling rejectees mome cottony lonelinesses sneaky!"          
    ## [5] "accouter contemplated presentable interest NAME NAME scows eyeletting mote apodal ac depurated!"              
    ## [6] "NAME vicugnas fodders galoshes clown biggies arlinda bescorches geothermal inducement selflessnesses spriggy!"

    (toc <- Sys.time() - tic)

    ## Time difference of 8.119677 secs

    ## replace_tokens
    tic <- Sys.time()
    head(replace_tokens(x$text.var, nms, "NAME"))

    ## [1] "oothecae clotty NAME newsier maestros NAME prophetesses savvying bulldozed boccies lordings invigorates!"     
    ## [2] "moating gourde exacta echinoids polynyas rottennesses NAME NAME trish polluting NAME suaver?"                 
    ## [3] "NAME superimposed halakah cabochon wencher NAME NAME NAME NAME NAME metalworks NAME."                         
    ## [4] "NAME unscrupulously capstones NAME NAME snottier haling rejectees mome cottony lonelinesses sneaky!"          
    ## [5] "accouter contemplated presentable interest NAME NAME scows eyeletting mote apodal ac depurated!"              
    ## [6] "NAME vicugnas fodders galoshes clown biggies arlinda bescorches geothermal inducement selflessnesses spriggy!"

    (toc <- Sys.time() - tic)

    ## Time difference of 0.06850314 secs

Now let's amp it up with 20x more text data. That's 50,000 rows of text
(600,080 words) and 5,493 replacement tokens in 1.5 seconds.

    tic <- Sys.time()
    out <- replace_tokens(rep(x$text.var, 20), nms, "NAME")
    (toc <- Sys.time() - tic)

    ## Time difference of 1.512028 secs

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

### Word Elongation

In informal writing people may use a form of text embellishment to
emphasize or alter word meanings called elongation (a.k.a. "word
lengthening"). For example, the use of "Whyyyyy" conveys frustration.
Other times the usage may be to be more sexy (e.g., "Heyyyy there").
Other times it may be used for emphasis (e.g., "This is so gooood").

The `replace_word_elongation` function replaces these un-normalized
forms with the most likely normalized form. The `impart.meaning`
argument can replace a short list of known elongations with semantic
replacements.

    x <- c('look', 'noooooo!', 'real coooool!', "it's sooo goooood", 'fsdfds',
        'fdddf', 'as', "aaaahahahahaha", "aabbccxccbbaa", 'I said heyyy!',
        "I'm liiiike whyyyyy me?", "Wwwhhatttt!", NA)

    replace_word_elongation(x)

    ##  [1] "look"             "no!"              "real cool!"      
    ##  [4] "it's so good"     "fsdfds"           "fdf"             
    ##  [7] "as"               "ahahahahaha"      "aabbccxccbbaa"   
    ## [10] "I said hey!"      "I'm like why me?" "what!"           
    ## [13] NA

    replace_word_elongation(x, impart.meaning = TRUE)

    ##  [1] "look"                     "sarcastic!"              
    ##  [3] "real cool!"               "it's so good"            
    ##  [5] "fsdfds"                   "fdf"                     
    ##  [7] "as"                       "ahahahahaha"             
    ##  [9] "aabbccxccbbaa"            "I said hey sexy!"        
    ## [11] "I'm like frustration me?" "what!"                   
    ## [13] NA
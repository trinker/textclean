NEWS 
====

Versioning
----------

Releases will be numbered with the following semantic versioning format:

&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor 
  and patch)
* New additions without breaking backward compatibility bumps the minor 
  (and resets the patch)
* Bug fixes and misc changes bumps the patch


textclean 0.8.0 -
----------------------------------------------------------------

**BUG FIXES**

* `fgsub` had a bug in which the the original `pattern` in `fgsub` matches the 
  location in the string but when the replacement occurs this was done on the 
  entire string rather than the location of the first `pattern` match.  This
  means the extracted string was used as a search and might be found in places
  other than the original location (e.g., a leading boundary in '^T' replaced
  with '__' may have led to '__he __itle' rather than '__he Title' as expected
  in the string 'The Title').  See #35 for details.  The fix will add some time 
  to the computation but is safer.

**NEW FEATURES**

*  `replace_to`/`replace_from` added to remove from/to begin/end of string to/from 
  a character(s).
  
* The following replacement functions were added to provide remediation for 
  problems found in `check_text`: `replace_email`, `replace_hash`, 
  `replace_tag`, & `replace_url`.

**MINOR FEATURES**

**IMPROVEMENTS**

* `replace_non_ascii` did not replace all non-ASCII characters.  This has been
  fixed by an explicit replacement of '[^ -~]+' which are all non-ASCII characters.
  See <a href="https://github.com/trinker/textclean/issues/34">issue #34</a> for details.

**CHANGES**



textclean 0.7.3
----------------------------------------------------------------

Maintenance release to bring package up to date with the lexicon package API changes.


textclean 0.7.0 - 0.7.2
----------------------------------------------------------------

**NEW FEATURES**

* `match_tokens` added to find all the tokens that match a regex(es) within a
  given text vector.  This useful when combined with the `replace_tokens` 
  function.
  
* Fixed versions of `drop_element`/`keep_element` added to allow for dropping
  elements specified by a known vector rather than a regex.

* The `collapse` and `glue` functions from the **glue** package are reexported
  for easy string manipulation.
  
* `replace_date` added for normalizing dates.

* `replace_time` added for normalizing time stamps.

* `replace_money` added for normalizing money references.

* `mgsub` picks up a `safe` argument using the **mgsub** package as the backend.
  In addition `mgsub_regex_safe` added to make the usage explicit.  The safe mode
  comes at the cost of speed.

**IMPROVEMENTS**

* `replace_names` drops the replacement of 
    `c('An', 'To', 'Oh', 'So', 'Do', 'He', 'Ha', 'In', 'Pa', 'Un')` which are 
    likely words and not names.
    
* `replace_html` picks ups some additional symbol replacments including:
  `c("&trade;", "&ldquo;", "&rdquo;", "&lsquo;", "&rsquo;", "&bull;", "&middot;", 
  "&sdot;", "&ndash;", "&mdash;", "&ne;", "&frac12;", "&frac14;", "&frac34;", 
  "&deg;", "&larr;", "&rarr;", "&hellip;")`.



textclean 0.6.0 - 0.6.3
----------------------------------------------------------------

**NEW FEATURES**

* `replace_kern` added to replace a form of informal emphasis in which the
  writer takes words &gt;2 letters long, capitalizes the entire word, and places
  spaces in between each letter.  This was contributed by Stack Overflow's
  @ctwheels: https://stackoverflow.com/a/47438305/1000343.

* `replace_internet_slang` added to replace Internet acronyms and abbreviations
  with machine friendly word equivalents.
  
* `replace_word_elongation` added to replace word elongations (a.k.a. "word 
  lengthening") with the most likely normalized word form.  See 
  http://www.aclweb.org/anthology/D11-105 for details.
  
* `fgsub` added for the ability to match, extract, operate a function over the
  extracted strings, & replace the original matches with the extracted strings.
  This performs similar functionality to `gsubfn::gsubfn` but is less powerful.
  For more powerful needs see the **gsubfn** package.



textclean 0.4.0 - 0.5.1
----------------------------------------------------------------

**BUG FIXES**

* `replace_grade` did not use `fixed = TRUE` for its call to `mgsub`.  This could
  result in the plus signs being interpreted as meta-characters.  This has been 
  corrected.

**NEW FEATURES**

* `replace_names` added to remove/replace common first and last names from text 
  data.
  
* `make_plural` added to make a vector of singular noun forms plural.

* `replace_emoji` and `replace_emoji_identifier` added for replacing emojis with
  text or an identifier token for use in the **sentimentr** package.

**MINOR FEATURES**

* `mgsub_regex` and `mgsub_fixed` to provide wrappers for `mgsub` that makes
  their use apparent without setting the `fixed` command.
  
* `replace_curly_quote` added to replace curly quotes with straight versions.

**IMPROVEMENTS**

* `replace_non_ascii` now uses `stringi::stri_trans_general` to coerce more 
  non-ASCII characters to ASCII format.
  
* `check_text` now checks for HTML characters/tags.  Thanks to @Peter Gensler
  for suggesting this (see <a href="https://github.com/trinker/textclean/issues/15">issue #15</a>). 

**CHANGES**

* `filter_` functions deprecated in favor of `drop_`/`keep_` versions of filter
  functions.  This was change was to address the opposite meaning that **dplyr**'s 
  `filter` has, which retains rows matching a pattern be default.



textclean 0.3.1
----------------------------------------------------------------

**BUG FIXES**

* `replace_tokens` added to complement `mgsub` for times when the user wants to 
  replace fixed tokens with a single value or remove them entirely.  This yields 
  an optimized solution that is much faster than `mgsub`.

**CHANGES**

* `mgusb` no longer uses `trim = TRUE` by default.

textclean 0.2.1 - 0.3.0
----------------------------------------------------------------

**BUG FIXES**

* `check_text` reported to use `replace_incomplete` rather than 
  `add_missing_endmark` when endmark is missing.
  
**NEW FEATURES**

* The `replace_emoticon`, `replace_grade` and `replace_rating` functions have 
  been moved from the **sentimentr** package to **textclean** as these are 
  cleaning functions.  This makes the functions more modular and generalizable 
  to all types of text cleaning.  These functions are still imported and 
  exported by **sentimentr**.
  
* `replace_html` added to remove html tags and repalce symbols with appropriate
  ASCII symbols.
  
* `add_missing_endmarks` added to detect missing endmarks and replace with the 
  desired symbol.

**IMPROVEMENTS**

* `replace_number` now uses the *english* package making it faster and more 
  maintainable.  In addition, the function now handles decimal places as well.



textclean 0.1.0 - 0.2.0
----------------------------------------------------------------

**BUG FIXES**

* `check_text` reported `NA` as non-ASCII.  This has been fixed.

**NEW FEATURES**

* `check_text` added to report on potential problems in a text vector.

* `replace_ordinal` added to replace ordinal numbers (e.g., 1st) with word 
  representation (e.g., first).
  
* `swap` added to swap two patterns simultaneously.

* `filter_element` added to exclude matching elements from a vector.



textclean 0.0.1 
----------------------------------------------------------------

This package is a collection of tools to clean and process text.  Many of these tools have been taken from the **qdap** package and revamped to be more intuitive, better named, and faster.
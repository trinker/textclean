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



textclean 0.4.0 - 
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
  their use apprent without setting the `fixed` command.
  
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
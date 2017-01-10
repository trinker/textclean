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


textclean 0.1.0 -
----------------------------------------------------------------

**BUG FIXES**

* `check_text` reported `NA` as non-ASCII.  This has been fixed.

**NEW FEATURES**

* `check_text` added to report on potential problems in a text vector.

* `replace_ordinal` added to replace ordinal numbers (e.g., 1st) with word 
  representation (e.g., first).
  
* `swap` added to swap two patterns simultaneously.

* `filter_element` added to exclude matching elements from a vector.

**MINOR FEATURES**

**IMPROVEMENTS**

**CHANGES**


textclean 0.0.1 
----------------------------------------------------------------

This package is a collection of tools to clean and process text.  Many of these tools have been taken from the **qdap** package and revamped to be more intuitive, better named, and faster.
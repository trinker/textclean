textclean   [![Follow](https://img.shields.io/twitter/follow/tylerrinker.svg?style=social)](https://twitter.com/intent/follow?screen_name=tylerrinker)
============


[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/textclean.svg?branch=master)](https://travis-ci.org/trinker/textclean)
[![Coverage
Status](https://coveralls.io/repos/trinker/textclean/badge.svg?branch=master)](https://coveralls.io/r/trinker/textclean?branch=master)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>

<img src="inst/textclean_logo/r_textclean2.png" width="200" alt="textclean Logo">

**textclean** is a collection of tools to clean and process text.


Table of Contents
============

-   [Functions](#functions)
-   [Installation](#installation)
-   [Contact](#contact)

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
<td align="left"><code>replace_contractions</code></td>
<td align="left">replacement</td>
<td align="left">Replace contractions with both words</td>
</tr>
<tr class="odd">
<td align="left"><code>replace_incomplete</code></td>
<td align="left">replacement</td>
<td align="left">Replace incomplete sentence endmarks</td>
</tr>
<tr class="even">
<td align="left"><code>replace_non_ascii</code></td>
<td align="left">replacement</td>
<td align="left">Replace non-ascii with equivalent or remove</td>
</tr>
<tr class="odd">
<td align="left"><code>replace_number</code></td>
<td align="left">replacement</td>
<td align="left">Replace common numbers</td>
</tr>
<tr class="even">
<td align="left"><code>replace_symbol</code></td>
<td align="left">replacement</td>
<td align="left">Replace common symbols</td>
</tr>
<tr class="odd">
<td align="left"><code>replace_white</code></td>
<td align="left">replacement</td>
<td align="left">Replace regex white space characters</td>
</tr>
<tr class="even">
<td align="left"><code>has_endmark</code></td>
<td align="left">check</td>
<td align="left">Check if an element has an endmark</td>
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
    pacman::p_load_gh("trinker/textclean")

Contact
=======

You are welcome to:    
- submit suggestions and bug-reports at: <https://github.com/trinker/textclean/issues>    
- send a pull request on: <https://github.com/trinker/textclean/>    
- compose a friendly e-mail to: <tyler.rinker@gmail.com>    
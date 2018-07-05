#' @importFrom glue glue
#' @export
glue::glue

#' @export
#' @inherit glue::glue_collapse
collapse <- function(x, sep = "", width = Inf, last = "") {
  if (utils::packageVersion("glue") > "1.2.0") {
    utils::getFromNamespace("glue_collapse", "glue")(x = x, sep = sep, width = width, last = last)
  } else {
    utils::getFromNamespace("collapse", "glue")(x = x, sep = sep, width = width, last = last)
  }
}

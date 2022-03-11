#' Strip line returns from text
#'
#' Strip line returns from text
#'
#' @param x text to strip out escapes etc
#' @export

text_sanitiser <- function(x) gsub("(\r)|(\n)|(\t)","",x)

#' Letter sequence for excel columns
#'
#' Generates a letter sequence that matches excel columns.
#'
#' @param x Column number

letter_seq <- function(x) {
  if (max(x) > 26*26*26) stop("Number out of range")
  d1 <- LETTERS[(x-1)%%26+1]
  d2 <- ifelse(x<=26,"",rep(LETTERS,each=26)[(x-26-1)%%(26*26)+1])
  d3 <- ifelse(x<=26*26 + 26,"",rep(rep(LETTERS,each=26),each=26)[(x-26*26-1)%%(26*26*26)+1])
  paste0(d3,d2,d1)
}

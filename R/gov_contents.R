#' Check gov.uk links for potential files
#'
#' Check gov.uk search results for potential files to download
#'
#' @param links links on gov.uk to check for files to download
#' @import httr

gov_contents <- function(links) {
  # url format
  urls <- map(links, ~ modify_url("https://www.gov.uk/api/content", path = .))

  # Get the data links
  map(urls,get_data_links_limited)
}

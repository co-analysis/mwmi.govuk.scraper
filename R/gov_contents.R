#' Check gov.uk links for potential files
#'
#' Takes a vector of results for pages and scrapes links to embedded data
#' returns a list as long as the input with:
#' url: original url requested
#' meta_data: data.table of meta data including org and date
#' data_titles: a vector of text titles for data files
#' data_links: a vector of links to data files
#'
#' @param links links on gov.uk to check for files to download
#' @import httr
#' @export

gov_contents <- function(links) {
  # url format
  urls <- map(links, ~ modify_url("https://www.gov.uk/api/content", path = .))

  # Get the data links
  map(urls,get_data_links_limited)
}

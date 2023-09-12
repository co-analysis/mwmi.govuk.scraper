#' Internal function
#'
#' Internal function
#'
#' @param url_to_scrape url on gov.uk
#' @param spreadsheets_only (default=TRUE) filters links to only return those which have a spreadsheet file type
#' @import rvest

get_data_links <- function(url_to_scrape, spreadsheets_only=TRUE) {
  # Extracting content
  html_text <- rvest::read_html(url_to_scrape) # no error catching...

  # Meta data
  # Todo: parse 'from' by using the hyperlinks (i.e. each dept is within a link)
  meta_data_raw <- html_text %>%
    rvest::html_nodes(".gem-c-metadata")
  meta_terms <- meta_data_raw %>%
    rvest::html_nodes(".gem-c-metadata__term") %>%
    rvest::html_text(trim=TRUE)
  meta_definitions <- meta_data_raw %>%
    rvest::html_nodes(".gem-c-metadata__definition") %>%
    rvest::html_text(trim=TRUE)
  meta_data <- data.frame(terms=meta_terms,definitions=meta_definitions)

  # Find links to attached data in the html
  # data_links <- html_text %>% rvest::html_nodes(".attachment .attachment-details a") %>%
  #   rvest::html_attr("href") %>% grep("((ods)|(csv)|(xls)|(xlsx))$",
  #                                     ., value = TRUE, ignore.case = TRUE)
  data_links <- html_text %>%
    rvest::html_nodes(".gem-c-attachment .gem-c-attachment__details a") %>%
    rvest::html_attr("href")

  # Find text titles for files
  # data_titles <- html_text %>%
  #   rvest::html_nodes(".attachment .attachment-details h3") %>%
  #   rvest::html_text()
  data_titles <- html_text %>%
    rvest::html_nodes(".gem-c-attachment .gem-c-attachment__details h2") %>%
    rvest::html_text(trim=TRUE)

  if (spreadsheets_only==TRUE) {
    spreads = grepl("((ods)|(csv)|(xls)|(xlsx))$", data_links, ignore.case = TRUE)
    data_links <- data_links[spreads]
    data_titles <- data_titles[spreads]
  }


  print(paste0(length(data_links)," results from ",url_to_scrape))

  list(url_scraped=url_to_scrape,meta_data=meta_data,data_links=data_links,data_titles=data_titles)
}

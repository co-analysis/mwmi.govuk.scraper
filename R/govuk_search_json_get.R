#' Internal function to query gov.uk and parse JSON
#'
#' Internal function to query gov.uk and parse JSON
#'
#' @param q structured query
#' @import httr
#' @import jsonlite

gov_search_json_get <- function(q) {
  # Preparing the URL
  url <- modify_url("https://www.gov.uk", path = "api/search.json", query=q)

  # API requests
  response <- GET(url)

  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }

  if (http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  # Extracting content
  json_text <- content(response, "text")

  # Converting content into Dataframe
  dataframe <- jsonlite::fromJSON(json_text)

  dataframe
}



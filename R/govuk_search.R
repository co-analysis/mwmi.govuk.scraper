#' Search gov.uk for a specific term
#'
#' Search gov.uk for a specific term and return results as a data frame
#'
#' @param search_term Phrase to search for on gov.uk
#' @export
#' @import lubridate

# https://www.gov.uk/api/search.json?q=taxes
# Gov.uk search api
gov_search <- function(search_term='"workforce management information"') {
  query_list = list(q=search_term, # search term to use
                    filter_format="publication", filter_detailed_format="transparency-data", # filters on document type
                    fields="title", fields="organisations", fields="link", fields="public_timestamp") # fields to return

  # Count results as max return is 1000
  search_n <- gov_search_json_get(q=append(query_list,list(count=0)))$total
  if (search_n>=10000) {
    stop("More than 10 pages of results, refine search")
  }

  # iterator to get full results set
  result_starts <- (1:(ceiling(search_n/1000))-1)*1000

  # Get all results and combine
  map(result_starts,~ gov_search_json_get(q=append(query_list,list(start=.,count=1000)))$results) %>%
    bind_rows %>%
    mutate(public_timestamp=ymd_hms(public_timestamp))
}

# a <- gov_search('"workforce management information"')

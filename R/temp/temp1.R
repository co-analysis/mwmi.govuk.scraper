gov_contents(a$link[1:2])

library(httr)
library(rvest)
b <- modify_url("https://www.gov.uk/api/content", path = a$link[1])

# Get the data links
# get_data_links(b)
url_to_scrape <- b

# Extracting content
html_text <- read_html(url_to_scrape) # no error catching...

# Meta data
# Todo: parse 'from' by using the hyperlinks (i.e. each dept is within a link)
meta_data_raw <- html_text %>%
  html_nodes(".gem-c-metadata")
meta_terms <- meta_data_raw %>%
  html_nodes(".gem-c-metadata__term") %>%
  html_text(trim=TRUE)
meta_definitions <- meta_data_raw %>%
  html_nodes(".gem-c-metadata__definition") %>%
  html_text(trim=TRUE)
meta_data <- data.frame(terms=meta_terms,definitions=meta_definitions)

# Find links to attached data in the html
data_links <- html_text %>%
  html_nodes(".attachment .attachment-details a") %>%
  html_attr("href") %>%
  grep("((ods)|(csv)|(xls)|(xlsx))$",.,value=TRUE,ignore.case=TRUE)

# Find text titles for files
data_titles <- html_text %>%
  html_nodes(".attachment .attachment-details h3") %>%
  html_text

print(paste0(length(data_links)," results from ",url_to_scrape))

list(url_scraped=url_to_scrape,meta_data=meta_data,data_links=data_links,data_titles=data_titles)

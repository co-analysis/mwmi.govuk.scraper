# library(devtools)
# library(usethis)

devtools::install()
library(mwmi.govuk.scraper)
a <- gov_search()


devtools::document()
usethis::use_package('readODS')

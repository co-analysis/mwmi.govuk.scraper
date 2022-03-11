# library(devtools)
# library(usethis)

devtools::document()
devtools::install()
library(mwmi.govuk.scraper)
a <- gov_search()


devtools::document()
usethis::use_package('readODS')

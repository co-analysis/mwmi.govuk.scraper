#
# # Input files
# template_files <- list.files("./data/templates/original",
#                              pattern="^[^~]",
#                              include.dirs=FALSE,
#                              full.names=TRUE,
#                              recursive=TRUE)
#
# # Create output file names, run conversion code
# template_rds_files <- template_files %>%
#   paste0(.,".rds") %>%
#   gsub("templates/original","templates/rds",.)
#
# source("./R/scraper functions/file_handler.R")
# template_conversion_results <- file_handler(template_files,template_rds_files)
#
# # Convert a blank copy to use when filling in missing returns
# file_handler("data/templates/import/blank accessible template.xlsx","data/templates/import/blank accessible template.xlsx.rds")
#

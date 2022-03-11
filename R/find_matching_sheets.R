#' Functions to check against template format
#'
#' Functions to check against template format
#'
#' @param gov_rds_file rds file to check
#' @export

find_matching_sheets <- function(gov_rds_file) {
  raw_data <- readRDS(gov_rds_file)
  matching_detail <- map(raw_data,matching_to_templates)
  matching <- map(matching_detail,~ .x$match) %>% unlist()
  template_matched <- map(matching_detail,~ .x$template) %>% unlist()

  print(gov_rds_file)
  list(
    file=gov_rds_file,
    any_sheets=any(matching),
    which_sheets=which(matching),
    template=template_matched[which(matching)])
}



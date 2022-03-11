#' Internal function
#'
#' Internal function
#'
#' @param raw_sheet_data check match on imported file

# Functions to check against template format
matching_to_templates <- function(raw_sheet_data) {
  does_data_match_a_template <- list(match=FALSE,template=NULL)
  try({
    template_matches <- raw_sheet_data %>%
      mutate(sheet_chr=text_sanitiser(chr)) %>%
      select(address,sheet_chr) %>%
      right_join(template_formats,by="address") %>%
      group_by(template) %>%
      summarise(match=all(!is.na(sheet_chr) & sheet_chr==template_chr))

    does_data_match_a_template <- list(
      match=any(template_matches$match),
      template=template_matches$template[template_matches$match==TRUE][1])
  })
  does_data_match_a_template
}

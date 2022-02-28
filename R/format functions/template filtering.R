
text_sanitiser <- function(x) gsub("(\r)|(\n)|(\t)","",x)

# Read templates into a dataset to merge on
template_format_files <- list.files("./data/templates/rds",
                             pattern="^[^~]",
                             include.dirs=FALSE,
                             full.names=TRUE,
                             recursive=TRUE)
template_formats <- map(template_format_files,~ readRDS(.x)[[1]] %>%
                          filter(!is.na(chr)) %>%
                          mutate(template_chr=text_sanitiser(chr)) %>%
                          select(address,row,col,template_chr) %>%
                          mutate(template=gsub(".*?\\/([^\\/]+)\\.rds","\\1",.x))) %>%
  bind_rows


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



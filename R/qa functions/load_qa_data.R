load_qa_data <- function() {
  # Load current files
  gov_datalinks <- list.files("data/gov_meta",pattern="gov_datalinks",full.names=TRUE) %>%
    sort(decreasing=TRUE) %>%
    head(1) %>%
    read_rds
  
  gov_files <- list.files("data/gov_files",pattern="^[^~]",include.dirs=FALSE,full.names=TRUE,recursive=TRUE)
  
  gov_rds <- list.files("data/gov_files_rds",pattern=".rds$",include.dirs=FALSE,full.names=TRUE,recursive=TRUE)
  
  match_format_results <- readRDS(paste0("data/gov_meta/match_format_results.rds"))
  which_matching <- readRDS(paste0("data/gov_meta/which_matching.rds"))
  
  formed_data <- readRDS("data/output/formed_data.RDS")
  
  cleaned_data <- readRDS("data/output/cleaned_data.RDS")
  
  list(gov_datalinks=gov_datalinks,
    gov_files=gov_files,
    gov_rds=gov_rds,
    match_format_results=match_format_results,
    which_matching=which_matching,
    formed_data=formed_data,
    cleaned_data=cleaned_data
    )
}
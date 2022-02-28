# Format a labelled data set
labelled_data_format <- function(lab_data_set) {
  # Pull out and reformat meta data - date and organisation details
  meta_lab <- lab_data_set %>%
    filter(group%in%c("date","org"),!is.na(chr)) %>%
    select(group,sub_group,row,chr) %>%
    pivot_wider(id_cols=row,names_from=c(group,sub_group),names_sep="_",values_from=chr)
  
  # Extract data, format, and merge back in the metadata
  blank_cols=c(dbl=NA_real_,chr=NA_character_) # to fill in columns if they don't exist - depends on import
  formed_data <- lab_data_set %>%
    add_column(!!!blank_cols[setdiff(names(blank_cols),names(.))]) %>%
    filter(!group%in%c("date","org"),!is.na(chr) | !is.na(dbl),!is.na(group)) %>%
    mutate(value=gsub("[^0-9\\.\\-]","",chr) %>% as.numeric) %>% # get rid of any non numeric characters (e.g. £ ,)
    mutate(value=ifelse(is.na(value),as.numeric(dbl),value)) %>%
    select(row,group,sub_group,measure,value,file) %>%
    inner_join(meta_lab) %>% # Drops any rows without metadata
    select(-row)
}

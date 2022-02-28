library(tidyverse)
library(magrittr)
library(readxl)
library(unpivotr)
# library(tidyxl)

letter_seq <- function(x) {
  if (max(x) > 26*26*26) stop("Number out of range")
  d1 <- LETTERS[(x-1)%%26+1]
  d2 <- ifelse(x<=26,"",rep(LETTERS,each=26)[(x-26-1)%%(26*26)+1])
  d3 <- ifelse(x<=26*26 + 26,"",rep(rep(LETTERS,each=26),each=26)[(x-26*26-1)%%(26*26*26)+1])
  paste0(d3,d2,d1)
}

# Read a single sheet from a csv file and convert to long form 'unpivotr' format
csv_sheet_cells <- function(file_name,sheet_name) {
  sheet_data <- NULL
  try({
    sheet_data <- read_csv(file_name,col_names=FALSE,show_col_types=FALSE) %>%
      as_cells %>%
      mutate(sheet=sheet_name,file=file_name,file_type="csv") %>%
      mutate(address=paste0(letter_seq(col),row))
  })
  sheet_data
}

# Read all sheets in a csv file, convert to cells, save as list of tables in RDS
csv_cells <- function(data_file,data_out_file) {
  print(paste0("Trying: ",data_file))
  csv_data <- NULL
  try({
    csv_data <- map2(data_file,"csv data",~ csv_sheet_cells(.x,.y))
  })
  
  # create directory to save to
  dir.create(gsub("\\/[^\\/]+$","",data_out_file),showWarnings=FALSE,recursive=TRUE)
  # save
  saveRDS(csv_data,data_out_file)
  
  return <- !is.null(csv_data)
}

# map input files and output files to conversion function
csv_handler <- function(data_file_list,file_out_list) {
  map2(data_file_list,file_out_list,~ csv_cells(.x,.y))
}


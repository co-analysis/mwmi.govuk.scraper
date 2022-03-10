#' Internal function
#'
#' Internal function
#'
#' @param file_name xls file to convert
#' @param sheet_name sheet names to iterate over
#' @import readxl
#' @import unpivotr

# Read a single sheet from an XLS/x file and convert to long form 'unpivotr' format
xls_sheet_cells <- function(file_name,sheet_name) {
  sheet_data <- NULL
  try({
    sheet_data <- readxl::read_excel(file_name,sheet=sheet_name,col_names=FALSE) %>%
      unpivotr::as_cells() %>%
      mutate(sheet=sheet_name,file=file_name,file_type=gsub(".*(xlsx?)$","\\1",file_name)) %>%
      mutate(address=paste0(letter_seq(col),row))
  })
  sheet_data
}

#' Internal function
#'
#' Read a single sheet from an ODS file and convert to long form 'unpivotr' format
#'
#' @param file_name ods file to convert
#' @param sheet_name sheet names to iterate over
#' @import readODS
#' @import unpivotr

ods_sheet_cells <- function(file_name,sheet_name) {
  sheet_data <- NULL
  try({
    sheet_data <- readODS::read_ods(file_name,sheet=sheet_name,col_names=FALSE) %>%
      unpivotr::as_cells() %>%
      mutate(sheet=sheet_name,file=file_name,file_type="ods") %>%
      mutate(address=paste0(letter_seq(col),row))
  })
  sheet_data
}

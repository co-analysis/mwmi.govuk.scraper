#' Internal function
#'
#' Internal function
#'
#' @param file_name csv file to convert
#' @param sheet_name ignored
#' @import readr

# Read a single sheet from a csv file and convert to long form 'unpivotr' format
csv_sheet_cells <- function(file_name,sheet_name) {
  sheet_data <- NULL
  try({
    sheet_data <- readr::read_csv(file_name,col_names=FALSE,show_col_types=FALSE) %>%
      as_cells %>%
      mutate(sheet=sheet_name,file=file_name,file_type="csv") %>%
      mutate(address=paste0(letter_seq(col),row))
  })
  sheet_data
}

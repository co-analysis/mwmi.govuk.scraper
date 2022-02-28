#' Read a range of spreadsheet file types in as unformatted cells
#'
#' Read a range of spreadsheet file types in as unformatted cells.
#'
#' @param in_files Vector of files to read in
#' @param out_files Vector of file names to export to
#' @export

file_handler <- function(in_files,out_files) {
  # Get input file extension
  file_type <- in_files %>%
    gsub(".*?([^\\.]+)$","\\1",.) %>%
    tolower

  # Choose which function to use for each file
  handler_function <- case_when(
      file_type == "xls" ~ list(xls_cells),
      file_type == "xlsx" ~ list(xls_cells),
      file_type == "csv" ~ list(csv_cells),
      file_type == "ods" ~ list(ods_cells),
      TRUE ~ list(function(x,y,z) "Unhandled file type")
      )

  # Run the selected function on each file
  pmap(list(in_files,out_files,handler_function),map2)
}


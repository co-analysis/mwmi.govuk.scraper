#' Internal function
#'
#' Internal function
#'
#' @param data_file_list xls file to convert
#' @param file_out_list location for rds conversion

# map input files and output files to conversion function
xls_handler <- function(data_file_list,file_out_list) {
  map2(data_file_list,file_out_list,~ xls_cells(.x,.y))
}


#' Internal function
#'
#' Internal function
#'
#' @param data_file_list xls file to convert
#' @param file_out_list location for rds conversion
#' @import readxl

# Read all sheets in an XLS/x file, convert to cells, save as list of tables in RDS
xls_cells <- function(data_file,data_out_file) {
  print(paste0("Trying: ",data_file))
  xls_data <- NULL
  try({
    sheet_names <- readxl::excel_sheets(data_file) ;
    xls_data <- map2(data_file,sheet_names,~ xls_sheet_cells(.x,.y))
  })

  # create directory to save to
  dir.create(gsub("\\/[^\\/]+$","",data_out_file),showWarnings=FALSE,recursive=TRUE)
  # save
  saveRDS(xls_data,data_out_file)

  return <- !is.null(xls_data)
}

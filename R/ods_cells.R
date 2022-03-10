#' Internal function
#'
#' Read all sheets in an ODS file, convert to cells, save as list of tables in RDS
#'
#' @param data_file_list ods file to convert
#' @param file_out_list location for rds conversion
#' @import readODS

ods_cells <- function(data_file,data_out_file) {
  print(paste0("Trying: ",data_file))
  ods_data <- NULL
  try({
    sheet_names <- readODS::list_ods_sheets(data_file) ;
    ods_data <- map2(data_file,sheet_names,~ ods_sheet_cells(.x,.y))
  })

  # create directory to save to
  dir.create(gsub("\\/[^\\/]+$","",data_out_file),showWarnings=FALSE,recursive=TRUE)
  # save
  saveRDS(ods_data,data_out_file)

  return <- !is.null(ods_data)
}

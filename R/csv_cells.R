#' Internal function
#'
#' Internal function
#'
#' @param data_file_list csv file to convert
#' @param file_out_list location for rds conversion

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


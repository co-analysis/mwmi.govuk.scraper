get_gov_file <- function(file_url, dl_stem, url_stem) {
  # Get file location after the stem, used to ensure uniqueness
  folder_stub <- file_url %>%
    gsub(paste0("^",url_stem),"",.) %>%
    gsub("/[^/]+$","",.)
  # Create directory
  dir.create(paste0(dl_stem,folder_stub),showWarnings=FALSE,recursive=TRUE)
  
  # Get file name
  file_name <- gsub(".*/([^/]+$)","\\1",file_url)
  
  # Make DL location
  dl_location <- paste0(dl_stem, folder_stub, "/", file_name)
  
  # Download
  dl_result <- try(download.file(file_url, dl_location, quiet=TRUE, mode="wb"),silent=TRUE)[1] %>%
    ifelse(.==0,"Successful",.)
  print(paste0(file_name," ",dl_result))
  
  # Return
  data.frame(data_link=file_url,dl_location,dl_result)
}
# Restrict to a sensible number of downloads per second (unclear what use limit is
# get_gov_file_limited <- limit_rate(get_gov_file, rate(n=50,period=1))
# Unneccesary

# Download the provided file list
# file_list: vector of urls for files to download
# dl_stem: Local file location to use for downloaded 
# url_stem: stem of the url to strip, remainder subfolders will be used when saving locally
gov_downloads <- function(file_list, ...) {
  # Map across files
  dl_tracking <- map(file_list, function(file_name=.x,...) get_gov_file(file_name, ...), ...) # note the triple ellipses to pass an argument into map

  # Return
  dl_tracking %>% bind_rows
}


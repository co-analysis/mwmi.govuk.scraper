#' Internal function
#'
#' Internal function
#'
#' @param file_url url on gov.uk
#' @param dl_stem where to download to
#' @param url_stem stem for url

get_gov_file <- function(file_url, dl_stem, url_stem) {
  if (startsWith(file_url,url_stem)) { # Check that URL matches specified pattern

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
    # Check file size
    download_size <- as.numeric(httr::HEAD(file_url)$headers$`content-length`)
    if (download_size >= 25000000) {
      dl_result <- "File too large"
    } else {
      dl_result <- try(download.file(file_url, dl_location, quiet=TRUE, mode="wb"),silent=TRUE)[1] %>%
        ifelse(.==0,"Successful",.)
    }
    print(paste0(file_name," ",dl_result))

    # Return
    data.frame(data_link=file_url,dl_location,dl_result)

  } else {
    # Return error if URL doesn't match specified pattern
    data.frame(data_link=file_url,dl_location=NA,dl_result="Malformed URL")
  }
}

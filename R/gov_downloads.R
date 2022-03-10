#' Download files from gov.uk
#'
#' Download from gov.uk
#'
#' @param file_list vector of urls for files to download
#' @param dl_stem Local file location to use for downloaded
#' @param url_stem stem of the url to strip, remainder subfolders will be used when saving locally
#' @export

# Download the provided file list
gov_downloads <- function(file_list, ...) {
  # Map across files
  dl_tracking <- map(file_list, function(file_name=.x,...) get_gov_file(file_name, ...), ...) # note the triple ellipses to pass an argument into map

  # Return
  dl_tracking %>% bind_rows
}


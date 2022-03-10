#' Internal function wrapping get_data_links
#'
#' Internal function wrapping get_data_links
#'
#' @import ratelimitr

# Use ratelimitr package to restrict to the allowed number of calls per second - consistently faster
get_data_links_limited <- ratelimitr::limit_rate(get_data_links, ratelimitr::rate(n=10,period=1))

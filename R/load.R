#' Load GTFS
#'
#' Loads spgtfs data from zip file returned by \code{spgtfs_download}.
#'
#' @param zipfile zip file returned by \code{spgtfs_download}.
#'
#' @export
spgtfs_load <- function(zipfile = 'data-raw/gtfs/gtfs.zip') {
  d <- dirname(zipfile)
  utils::unzip(zipfile, exdir = d)
  arqs <- c("agency.txt", "calendar.txt", "fare_attributes.txt",
            "fare_rules.txt", "frequencies.txt", "routes.txt",
            "shapes.txt", "stops.txt", "stop_times.txt", "trips.txt")
  gtfs <- arqs %>%
    tibble::enframe() %>%
    dplyr::select(arq = value) %>%
    dplyr::group_by(arq) %>%
    dplyr::do(data = {
      sprintf('%s/%s', d, .$arq) %>%
        data.table::fread(encoding = 'UTF-8') %>%
        tibble::as_tibble()
      }) %>%
    dplyr::ungroup() %>%
    tibble::remove_rownames()
  file.remove(sprintf('%s/%s', d, arqs))
  gtfs
}

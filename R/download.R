#' Download SP-GTFS data
#'
#' Download SP-GTFS data from SPTrans site. If you don't have login and
#' password,
#' \href{http://www.sptrans.com.br/desenvolvedores/Default.aspx?login}{click
#' here}.
#'
#' @param login login.
#' @param pwd password.
#' @param path folder where gtfs.zip will be written.
#'
#' @export
spgtfs_download <- function(login, pwd, path = 'data-raw/gtfs') {
  u_login <- 'http://www.sptrans.com.br/desenvolvedores/Default.aspx?login'
  r_login <- httr::GET(u_login)
  body_login <- list('__LASTFOCUS' = '',
                     '__EVENTTARGET' = 'btnDevPlaceLogin',
                     '__EVENTARGUMENT' = '',
                     '__VIEWSTATE' = get_tags(r_login, '#__VIEWSTATE'),
                     '__VIEWSTATEGENERATOR' = get_tags(r_login, '#__VIEWSTATEGENERATOR'),
                     '__PREVIOUSPAGE' = get_tags(r_login, '#__PREVIOUSPAGE'),
                     '__EVENTVALIDATION' = get_tags(r_login, '#__EVENTVALIDATION'),
                     'busca' = '|',
                     'tipoHeaderPesquisa'='',
                     'devPlaceUserName' = login,
                     'devPlaceUserPass' = pwd)
  r_logged <- httr::POST(u_login, body = body_login)
  u_gtfs <- "http://www.sptrans.com.br/desenvolvedores/GTFS.aspx"
  r_gtfs <- httr::GET(u_gtfs)
  body_gtfs <- list(
    "__EVENTTARGET" = "btDownloadGTFS",
    "__EVENTARGUMENT" = "",
    "__VIEWSTATE" = get_tags(r_gtfs, '#__VIEWSTATE'),
    "__VIEWSTATEGENERATOR" = get_tags(r_gtfs, '#__VIEWSTATEGENERATOR'),
    "__EVENTVALIDATION" = get_tags(r_gtfs, '#__EVENTVALIDATION'),
    "busca" = "|",
    "tipoHeaderPesquisa" = ""
  )
  dir.create(path, showWarnings = FALSE, recursive = TRUE)
  r <- httr::POST(u_gtfs, body = body_gtfs, encode = 'form',
                  httr::write_disk(sprintf('%s/gtfs.zip', path),
                                   overwrite = TRUE),
                  httr::progress())
  invisible(as.character(r$content))
}

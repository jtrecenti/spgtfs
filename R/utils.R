#' Get value of a tag by CSS path
#'
#' This is useful for ASPX pages to get parameters inside \code{__VIEWSTATE} and
#' other stuff.
#'
#' @param req object returned by a \code{httr::GET} request.
#' @param tipo CSS path of the item (e.g. \code{#__VIEWSTATE}).
#'
#' @export
get_tags <- function(req, tipo) {
  req %>%
    httr::content('text') %>%
    xml2::read_html() %>%
    rvest::html_node(tipo) %>%
    rvest::html_attr('value')
}

#' Pipe operator
#'
#' See \code{\link[magrittr]{\%>\%}} for more details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

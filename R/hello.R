#' Say hello
#'
#' @param name character; who to greet
#' @return character
#' @export
#' @examples
#' hello()
#' hello("Marc")
hello <- function(name = "world") {
  sprintf("Hello world, %s!", name)
}

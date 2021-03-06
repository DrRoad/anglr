#' Auto aspect ratio
#'
#' Automatically modify the aspect ratio of a scene to 
#' rescale drastically different data ranges into something more
#' pleasing. 
#' 
#' This is typically used to rescale data in different units, for example longitude and
#' latitude in degrees and elevation in metres. 
#'
#' @param x exaggeration for x
#' @param y exaggeration for y
#' @param z exaggeration for z
#' @param keep_xy should xy be forced to maintain their current aspect ratio
#' @param exag should the x, y, z factors be applied, set to `FALSE` to ignore 
#' @param verbose keep shush
#'
#' @return the output of `rgl::par3d` invisibly
#' @export
#'
#' @examples
#' topo <- copy_down(silicate::SC(simpleworld), gebco1)
#' plot3d(topo)
#' 
#' auto_3d(z = 4)
auto_3d <- function(x = 1, y = 1, z = 1, keep_xy = TRUE, exag = TRUE, verbose = TRUE) {
  thr <- apply(matrix(rgl::par3d()$bbox, 2), 2, function(a) diff(a))
  dxy <- thr[2]/thr[1]
  asp <- 1/(thr/min(thr))
  if (keep_xy) asp[1:2] <- 1
  if (exag) asp <- asp * c(x, y, z)
  #if (!is.null(getOption("rgl.useNULL")) && interactive() && runif(1, 0, 1) > 0.96) {
  #  message("rgl NULL device in use, do you need to run rgl::rglwidget()?")
  #}
  if (verbose) {
    psp <- format(asp, digits = 3)
    print(sprintf("original axis lengths x,y,z: %s", paste(format(thr), collapse = ",", sep = "")))
    print(sprintf("applying 'aspect3d(%s, %s, %s)'", psp[1], psp[2], psp[3]))
  }
  rgl::aspect3d(asp[1], asp[2], asp[3])
}


widg <- function() {
  rgl::rglwidget()
}
maybe_geom_column <- function(x, ...) {
  names(x)[purrr::map_lgl(x, ~ inherits(.x, "list"))]
}

check_is_geom_column <- function(x, ...) {
  any(class(x[[1]]) == "sfg")
}

find_geom_column <- function(x) {
  purrr::map(maybe_geom_column(x), check_is_geom_column)
}
# 
#     i <- which(lgl)
#   nms <- names(x)
#   if (length(i) > 1) {
#     message(sprintf("found these geom columns %s using %s", 
#                     paste(nms[i], collapse = ", "), 
#                     nms[i[1]]))
#     i <- i[1]
#   }
#   if (length(i) == 1) {
#     nm <- nms[i]
#     return(x[[nm]])
#   }
#   message("no geom column found")
#   NULL
# }


#' @importFrom utils head
path2seg <- function(x) {
  ## this is a trick of array logic to generate paired indexes from a sequence
  head(suppressWarnings(matrix(x, nrow = length(x) + 1, ncol = 2, byrow = FALSE)), -2L)
}

trimesh_cols <- function(n) {
  viridis::viridis(n)
}
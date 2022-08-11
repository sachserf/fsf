#' wrapper for tuneR::setWavPlayer
#' @param path2player Character. Specify path to audioplayer
#'
#' @export
audioplayer_set_path <- function(path2player = "/usr/bin/play") {
  tuneR::setWavPlayer(path2player)
}

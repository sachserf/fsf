#' play random xeno canto from list of birds (birdlife course)
#'
#' @export
birdlife_xc <- function() {

  set.seed(sample(1:1e6, 1))

  require(warbleR)
  require(tidyverse)
  require(tuneR)

  df <- rio::import("~/notes/feldornithologie/prüfung/birdlist2learn.xlsx") %>%
    as_tibble() %>%
    mutate(wiss = paste(Gattung, Art)) %>%
    select(-Gattung, -Art)

  # sample
  x <- df %>% sample_n(1) %>% select(wiss) %>% c() %>% unlist()
  #paste(x, "type:song q_gt:C") # quality A or B
  xcmeta <- warbleR::querxc(qword = paste(x, "type:song q:A", "area:europe", "len_lt:30"),
                            download = FALSE)

  down <- xcmeta %>% sample_n(1)

  url <- paste0("https:", down$Url, "/download")
  target <- paste0("/tmp/", down$file.name, ".mp3")
  download.file(url, target)

  printout <- down %>%
    select(starts_with("Other_species")) %>%
    select_if(~sum(!is.na(.)) > 0) %>%
    bind_cols(main = x, .) %>%
    unlist() %>% c %>% paste(collapse = "\n")

  message(printout)

  z <- tuneR::readMP3(target)

  tuneR::getWavPlayer()
  tuneR::setWavPlayer("/usr/bin/play")
  tuneR::play(z)
}


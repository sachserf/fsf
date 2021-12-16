#' play random recording from Remo Probst from list of birds (birdlife course)
#'
#' @export
#'
birdlife_remo <- function(){
library(tidyverse)

df <- rio::import("~/notes/feldornithologie/prüfung/birdlist2learn.xlsx") %>%
  as_tibble() %>%
  mutate(wiss = paste(Gattung, Art)) %>%
  select(-Gattung, -Art) %>%
  mutate(mp3 = list.files("/home/sachserf/Music/Vogelarten_MP3"))

path2mp3 <-  "/home/sachserf/Music/Vogelarten_MP3"
sam <- df %>% sample_n(1) %>% select(mp3) %>% unlist() %>% c()

message(sam)

z <- tuneR::readMP3(file.path(path2mp3, sam))
tuneR::setWavPlayer("/usr/bin/play")
tuneR::play(z)

}

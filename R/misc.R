
now <- function() {
  return(format(Sys.time(), "%Y%m%d%H%M%S"))
}

file_txt_pre_ext <- function(filename, txt_pre_ext = now()) {
  file_name_se <- tools::file_path_sans_ext(filename)
  file_ext <- stringr::str_sub(filename, nchar(file_name_se) + 1, nchar(filename))
  file_dest <- file.path(dir_dest, paste0(file_name_se, txt_pre_ext, file_ext))
  return(file_dest)
}


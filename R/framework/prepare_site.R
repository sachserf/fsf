#'Prepare and render a local website
#'
#'@description The function will prepare given Rmd-files to simplify the process
#'  of building websites. It should fasten the process of creating webpages by 
#'  using a predefined template and layout. After calling this function you can 
#'  use rmarkdown::render_site() to render a local website.
#'@param Rmd_input Character. A vector of Rmd-Files that should be placed within
#'  a single directory.
#'@param target_dir Character. Path to the output directory of the website.
#'@param index_menu Logical. If False there will not be an additional button for
#'  the main page.
#'@param index_name Character. Alternative name for the index (main page).
#'@param page_name Character. Name for the homepage.
#'@note If there is no "index.Rmd" in input_Rmd a template will be used to 
#'  create an index_Rmd-file.
#'@note Required Version of the package rmarkdown: v0.9.6
#'@return A _site.yml and optionally an index.Rmd
#'@author Frederik Sachser
#'@seealso \code{\link[rmarkdown]{render_site}}
#'@export
prepare_site <- 
  function(Rmd_input, target_dir, index_menu = FALSE, index_name = "Home", page_name = basename(getwd())) 
  {
    # prepare objects 
    if (dir.exists(target_dir) == TRUE) {
      unlink(target_dir, recursive = TRUE)
    }
    dir.create(target_dir, recursive = TRUE)
    
    source_dir <- dirname(Rmd_input[1])
    
    nr_subdir <- nchar(source_dir) - nchar(gsub(pattern = "/", 
                                                replacement = "", x = source_dir))
    nr_subdir <- nr_subdir + 1
    paste_nr_subdir <- paste(rep("..", nr_subdir), collapse = "/")
    target_dir_inc_subdir <- file.path(paste_nr_subdir, target_dir)
    target_yaml <- file.path(source_dir, "_site.yml")
    index_filepath <- file.path(source_dir, "index.Rmd")
    basename_html <- basename(gsub(pattern = ".Rmd", replacement = ".html", 
                                   x = Rmd_input))
    basename_noxt <- basename(gsub(pattern = ".Rmd", replacement = "", 
                                   x = Rmd_input))
    
    basename_noxt <- gsub(pattern = "index", replacement = index_name, x = basename_noxt, fixed = TRUE)
    
    # write index.Rmd
    if (file.exists(index_filepath) == FALSE) {
      list_of_files <- list.files(source_dir, pattern = 'Rmd')
      cat("# This website is a collection of compiled notebooks of the project: \"`r basename(dirname(dirname(getwd())))`\". \n            \n            Compiled at `r Sys.time()`\n            \n            The following files have been compiled: ", list_of_files," \n            \n            ```{r, echo = FALSE}\n            list.files(pattern = 'Rmd')\n            if ('devtools' %in% installed.packages() == TRUE) {\n            devtools::session_info()\n            } else {\n            sessionInfo()\n            }\n            ```\n            \n            ", 
          file = index_filepath)
    }
    # optionally delete index-button
    if (index_menu == FALSE & "index.Rmd" %in% basename(Rmd_input) == TRUE) {
      Rmd_input <- Rmd_input[-grep(pattern = "index.Rmd", x = Rmd_input)]
    }
    # write yaml
    #  print_lines <- function() {
    print_lines <- function() {
      for (i in seq_along(basename_noxt)) {
        cat("    - text: ", "'", basename_noxt[i], "'", "\n", 
            "      href: ", basename_html[i], "\n", sep = "")
      }
    }
    sink(target_yaml)
    c(cat("name: '", page_name, "'\noutput_dir: '", target_dir_inc_subdir, 
          "'\nnavbar:\n  title: '", page_name, "'\n  left:\n", 
          sep = ""), print_lines(), cat("output:\n  html_document:\n    theme: cosmo\n    highlight: textmate\n"))
    sink()
  }


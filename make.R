############ make-like file ############

# This project was build by using the package <<framework>> (v1.8.33)
# visit https://github.com/sachserf/framework/blob/master/README.md for a short introduction
# visit https://sachserf.github.io for further information and tutorials

############ PREAMBLE ############

# detach package:framework
if ('package:framework' %in% search() == TRUE) {
  detach(package:framework)
}

# detach localfun
if ('localfun' %in% search() == TRUE) {
    detach(localfun)
}

# clear Global environment
rm(list = ls(all.names = TRUE, envir = .GlobalEnv))

# initialize new environment: <<localfun>>
localfun <- new.env(parent = .GlobalEnv)

# source every R-file within directory <<fun_dir>>
# and assign them to the environment <<localfun>>
sapply(list.files(
        'R',
        pattern = '*.R$',
        full.names = TRUE,
        recursive = TRUE
    ), source, local = localfun)

# attach the environment <<localfun>>
attach(localfun)

# remove the environment <<localfun>> from .GlobalEnv
rm(localfun)

############ PACKAGES ############

# install packages without loading:
pkg_install(c('utils', 
        'tools',
        'rmarkdown',
        'knitr',
        'rstudioapi'),
    attach = FALSE)

# install and load packages:
pkg_install(c('tidyverse'),
    attach = TRUE)

############ SOURCE ############

# fill in R/Rmd-files in chronological order
instructions(
    source_files = c('prepare.Rmd','visualize.Rmd','analyze.Rmd','report.Rmd'), 
    spin_index = 999,
    cache_index = 999,
    cache_dir = '.cache',
    source_dir = 'scripts',
    data_dir = 'data',
    target_dir_figure = 'out/fig',
    target_dir_docs = 'out/docs',
    rename_figure = TRUE,
    rename_docs = TRUE,
    knitr_cache = FALSE
)

############ SUPPLEMENT ############

# save all data frames (within .GlobalEnv)
write_dataframe(target_dir_data = 'out/data', file_format = 'csv')

# write session_info
session_info()

# backup (optionally change target directory and excluded files/dir)
#backup(exclude_directories = 'packrat|.git|data|.cache|out/data|out/fig|out/docs',
#       exclude_files = '*.RData|*.Rhistory|*.rds', delete_target = TRUE)

# print summary of instructions
summary_instructions(cache_dir = '.cache')


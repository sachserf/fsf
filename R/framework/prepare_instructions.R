#' prepare_instructions
#'
#' @description This function processes the given instructions.
#' @inheritParams instructions
#' @note This function is part of a family of functions each of which end with
#'   '_instructions'. The order to call these functions is:
#'   'prepare_instructions', 'implement_instructions', 'check_instructions',
#'   'delete_deprecated_instructions', 'execute_instructions' and optionally
#'   'output_instructions'. There is a wrapper for these functions called
#'   'instructions'.
#' @return RData file within the cache directory containing all information of
#'   the given instructions.
#' @seealso \code{\link{instructions}}, \code{\link{implement_instructions}},
#'   \code{\link{check_instructions}},
#'   \code{\link{delete_deprecated_instructions}},
#'   \code{\link{execute_instructions}}, \code{\link{output_instructions}}
#' @author Frederik Sachser
#' @export
prepare_instructions <-
  function(source_files,
           spin_index = 0,
           cache_index = 0,
           cache_dir = ".cache",
           source_dir = "in/src",
           data_dir = "in/data",
           target_dir_figure = "out/figure",
           target_dir_docs = "out/docs",
           rename_figure = TRUE,
           rename_docs = TRUE,
           knitr_cache = TRUE)
  {
    # call file_path for input
    cache_dir <- file.path(cache_dir)
    source_dir <- file.path(source_dir)
    if (is.null(data_dir) == FALSE) {
      data_dir <- file.path(data_dir)
    }
    if (is.null(target_dir_figure) == FALSE) {
      target_dir_figure <- file.path(target_dir_figure)
    }
    if (is.null(target_dir_docs) == FALSE) {
      target_dir_docs <- file.path(target_dir_docs)
    }

    # specify file paths (add source_dir if necessary)
    path_included <- grepl(pattern = source_dir, x = source_files)
    source_files <- ifelse(path_included == TRUE, file.path(source_files), file.path(source_dir, source_files))
    path_snapshot_source_dir <-
      file.path(cache_dir, "snapshot_source_dir.rds")
    path_snapshot_data_dir <-
      file.path(cache_dir, "snapshot_data_dir.rds")

    # check if source_files exists
    if (any(file.exists(source_files) == FALSE) == TRUE) {
      stop(
        "At least one source_file does not exist. Check file path and retry. File paths should be relative to the source_dir."
      )
    }

    # delete and rebuild cache
    if (length(cache_index) == 1 && cache_index == 0) {
      lapply(X = c(cache_dir, target_dir_figure, target_dir_docs), FUN = unlink, recursive = TRUE)
    }
    if (dir.exists(cache_dir) == FALSE) {
      dir.create(cache_dir)
    }

    # specify indices
    if (length(cache_index) == 1 && cache_index == 999) {
      cache_index <- 1:length(source_files)
    }
    if (length(spin_index) == 1 && spin_index == 999) {
      spin_index <- 1:length(source_files)
    }

    # delete deprecated instructions
    if (file.exists(file.path(cache_dir, "instructions.RData"))) {
      unlink(x = file.path(cache_dir, "instructions.RData"),
             recursive = TRUE)
    }
    
    # if knitr_cache = TRUE make sure that target_dir_figure = NULL
    if (knitr_cache == TRUE) {
      target_dir_figure <- NULL
    } 

    # write input to 'instructions.RData'
    save(
      source_files,
      spin_index,
      cache_index,
      cache_dir,
      source_dir,
      data_dir,
      target_dir_figure,
      target_dir_docs,
      path_snapshot_source_dir,
      path_snapshot_data_dir,
      rename_figure,
      rename_docs,
      knitr_cache,
      file = file.path(cache_dir, "instructions.RData")
    )
  }

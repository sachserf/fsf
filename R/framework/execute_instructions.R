#' Execute your instructions!
#'
#' @description The function will execute the instructions (source/render
#'   specified files etc). Among other things it is a wrapper for the function
#'   'specify_instructions'.
#' @inheritParams project_framework
#' @note This function is part of a family of functions each of which end with
#'   '_instructions'. The order to call these functions is:
#'   'prepare_instructions', 'implement_instructions', 'check_instructions',
#'   'delete_deprecated_instructions', 'execute_instructions' and optionally
#'   'output_instructions'. There is a wrapper for these functions called
#'   'instructions'.
#' @seealso \code{\link{prepare_instructions}},
#'   \code{\link{implement_instructions}}, \code{\link{check_instructions}},
#'   \code{\link{delete_deprecated_instructions}}, \code{\link{instructions}},
#'   \code{\link{output_instructions}}, \code{\link{specify_instructions}}
#' @author Frederik Sachser
#' @export
execute_instructions <-
  function (cache_dir = ".cache")
  {
    # check prerequisites
    if (any(file.exists(
      file.path(cache_dir, "df_source_files_temp.rds"),
      file.path(cache_dir, "instructions.RData")
    ) == FALSE)) {
      stop(
        "Required files in cache are missing. Recall preceding functions of the 'framework instructions'-family and retry. For details see ?instructions"
      )
    }
    # reload instructions
    load(file.path(cache_dir, "instructions.RData"))
    # reload temporary df_source_files
    df_source_files <-
      readRDS(file = file.path(cache_dir, "df_source_files_temp.rds"))

    # create all required directories in cache
    sapply(
      X = dirname(df_source_files$image_cache),
      FUN = dir.create,
      recursive = TRUE,
      showWarnings = FALSE
    )

    # call specify_instructions()
    for (i in 1:nrow(df_source_files)) {
      specify_instructions(
        target_dir_docs = target_dir_docs,
        target_dir_figure = target_dir_figure,
        source_dir = source_dir,
        filename = df_source_files$filename[i],
        image_cache = df_source_files$image_cache[i],
        instruction = df_source_files$instruction[i],
        docs_out = df_source_files$docs_out[i],
        filename_noxt = df_source_files$filename_noxt[i],
        basename_noxt = df_source_files$basename_noxt[i],
        temp_docs_out = df_source_files$temp_docs_out[i],
        figure_source = df_source_files$figure_source[i],
        figure_out = df_source_files$figure_out[i],
        use_spin = df_source_files$use_spin[i],
        file_ext = df_source_files$file_ext[i],
        knitr_cache
      )
    }

    # remove df_source_files_temp.rds
    file.remove(file.path(cache_dir, "df_source_files_temp.rds"))
    # write df_source_files.rds (stored information for subsequent function calls)
    saveRDS(object = df_source_files,
            file = file.path(cache_dir,
                             "df_source_files.rds"))

    # remove deprecated snapshots
    if (file.exists(path_snapshot_source_dir) == TRUE) {
      file.remove(path_snapshot_source_dir)
    }
    if (file.exists(path_snapshot_data_dir) == TRUE) {
      file.remove(path_snapshot_data_dir)
    }

    # write new snapshots
    snapshot_source_dir <- utils::fileSnapshot(path = source_dir,
                                               md5sum = TRUE,
                                               recursive = TRUE)
    saveRDS(object = snapshot_source_dir, file = path_snapshot_source_dir)

    if (is.null(data_dir) == FALSE & length(list.files(data_dir)) > 0) {
      snapshot_data_dir <- utils::fileSnapshot(path = data_dir,
                                               md5sum = TRUE,
                                               recursive = TRUE)
      saveRDS(object = snapshot_data_dir, file = path_snapshot_data_dir)
    }
  }

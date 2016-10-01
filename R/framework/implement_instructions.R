#' Implement specified instructions
#'
#' @description This function will prepare implement the given instructions
#'   (e.g. specify instruction depending on file extension).
#' @inheritParams project_framework
#' @note This function is part of a family of functions each of which end with
#'   '_instructions'. The order to call these functions is:
#'   'prepare_instructions', 'implement_instructions', 'check_instructions',
#'   'delete_deprecated_instructions', 'execute_instructions' and optionally
#'   'output_instructions'. There is a wrapper for these functions called
#'   'instructions'.
#' @seealso \code{\link{prepare_instructions}},
#'   \code{\link{delete_deprecated_instructions}},
#'   \code{\link{check_instructions}}, \code{\link{instructions}},
#'   \code{\link{execute_instructions}}, \code{\link{output_instructions}}
#' @author Frederik Sachser
#' @export
implement_instructions <-
  function(cache_dir = ".cache")
  {
    # check prerequisites
    if (file.exists(file.path(cache_dir, "instructions.RData")) ==
        FALSE) {
      stop(
        "Required files in cache are missing. Recall preceding functions of the 'framework instructions'-family and retry. For details see ?instructions"
      )
    }
    # reload instructions

    load(file.path(cache_dir, "instructions.RData"))

    # prepare df_cache
    # specify rownames
    row_names <- seq_along(source_files)
    # specify basename without extension
    basename_noxt <-
      basename(tools::file_path_sans_ext(source_files))
    # specify filename without extension
    filename_noxt <- tools::file_path_sans_ext(source_files)
    # specify file_ext
    file_ext <- tools::file_ext(source_files)

    # check support of source files
    if (any(file_ext %in% c("R", "Rmd", "Rnw", "md")) == FALSE) {
      stop(
        "At least one source file is not supported. Supported file formats are R, Rmd, md and Rnw."
      )
    }

    # specify directory for rendered figures
    figure_source <- paste0(filename_noxt, "_files")


    # specify path to image of the file
    image_cache <- paste0(file.path(cache_dir, filename_noxt,
                                    basename(filename_noxt)), ".RData")


    # specify names for target files in output
    filename_out <- gsub(pattern = source_dir, replacement = "",
                         filename_noxt)
    filename_out <-
      gsub(pattern = "/", replacement = "_", filename_out)
    if (is.null(target_dir_figure) == FALSE) {
    figure_out <- file.path(target_dir_figure, paste0(row_names,
                                                      filename_out))
    } else {
      figure_out <- getwd()
    }
    if (is.null(target_dir_docs) == FALSE) {
    docs_out <- file.path(target_dir_docs, paste0(row_names))
    temp_docs_out <- file.path(target_dir_docs,
                               "temp_files",
                               paste0(row_names, filename_out))
    } else {
      docs_out <- cache_dir
      temp_docs_out <- file.path(docs_out,
                                 "temp_files",
                                 paste0(row_names, filename_out))
    }

    # arrange df_source_files
    df_source_files <-
      data.frame(
        row_names,
        filename = source_files,
        basename_noxt,
        filename_noxt,
        file_ext,
        figure_source,
        image_cache,
        figure_out,
        docs_out,
        temp_docs_out,
        stringsAsFactors = FALSE
      )

    # specify instruction depending on file extension
    df_source_files$instruction_ext <- NA
    df_source_files$instruction_ext[which(df_source_files$file_ext ==
                                            "R")] <- "source"
    df_source_files$instruction_ext[which(df_source_files$file_ext ==
                                            "Rmd")] <- "render"
    df_source_files$instruction_ext[which(df_source_files$file_ext ==
                                            "md")] <- "render"
    df_source_files$instruction_ext[which(df_source_files$file_ext ==
                                            "Rnw")] <- "knit"

    # specify which R-files to spin
    df_source_files$use_spin <- FALSE
    df_source_files$use_spin[spin_index] <- TRUE
    if (any(df_source_files$file_ext != "R")) {
      df_source_files[which(df_source_files$file_ext != "R"),
                      "use_spin"] <- NA
    }

    # specify instructions as defined in input
    df_source_files$instruction_no_cache <-
      df_source_files$instruction_ext
    if (length(which(df_source_files$use_spin == TRUE)) > 0) {
      df_source_files[which(df_source_files$use_spin == TRUE),
                      "instruction_no_cache"] <- "render"
    }

    # specify cache-files according to input
    df_source_files$use_cache_input <- FALSE
    df_source_files$use_cache_input[cache_index] <- TRUE

    # Make sure that there is no outdated df_source_files_temp.rds
    if (file.exists(file.path(cache_dir, "df_source_files_temp.rds"))) {
      unlink(x = file.path(cache_dir, "df_source_files_temp.rds"),
             recursive = TRUE)
    }

    # write temporary df_source_files
    saveRDS(object = df_source_files,
            file = file.path(cache_dir,
                             "df_source_files_temp.rds"))
  }

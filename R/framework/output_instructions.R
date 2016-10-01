#' Reorganize your output!
#' 
#' @description This function will rename and move the whole output of your
#'   instructions into predefined target directories.
#' @inheritParams project_framework
#' @note This function is part of a family of functions each of which end with 
#'   '_instructions'. The order to call these functions is: 
#'   'prepare_instructions', 'implement_instructions', 'check_instructions', 
#'   'execute_instructions' and optionally 'output_instructions'. There is a 
#'   wrapper for these functions called 'instructions'.
#' @seealso \code{\link{prepare_instructions}}, 
#'   \code{\link{implement_instructions}}, \code{\link{check_instructions}}, 
#'   \code{\link{delete_deprecated_instructions}}, 
#'   \code{\link{execute_instructions}}, \code{\link{instructions}}
#' @author Frederik Sachser
#' @export
output_instructions <- function(cache_dir = ".cache") {
  # check prerequisites
  if (any(file.exists(
    file.path(cache_dir, "df_source_files.rds"),
    file.path(cache_dir, "instructions.RData")
  ) == FALSE)) {
    stop(
      "Required files in cache are missing. Recall preceding functions of the 'framework instructions'-family and retry. For details see ?instructions"
    )
  }
  # reload instructions
  load(file.path(cache_dir, "instructions.RData"))
  # reload df_source_files
  df_source_files <-
    readRDS(file = file.path(cache_dir, "df_source_files.rds"))

  # create all required directories for output
  if (rename_docs == TRUE) {
    sapply(
      X = c(
        dirname(df_source_files$docs_out),
        df_source_files$temp_docs_out
      ),
      FUN = dir.create,
      recursive = TRUE,
      showWarnings = FALSE
    )
  }

  if (rename_figure == TRUE) {
    sapply(
      X = dirname(df_source_files$figure_out),
      FUN = dir.create,
      recursive = TRUE,
      showWarnings = FALSE
    )
  }
  # copy figures from source to output (delete from source)
  if (is.null(target_dir_figure) == FALSE) {
    for (i in 1:nrow(df_source_files)) {
      if (length(list.files(df_source_files$figure_source[i])) >
          0) {
        current_figures <- list.files(
          df_source_files$figure_source[i],
          full.names = TRUE,
          recursive = TRUE
        )
        if (rename_figure == TRUE) {
          figure_out_files <- paste0(df_source_files$figure_out[i],
                                     "_",
                                     basename(current_figures))
        } else {
          figure_out_files <- file.path(
            target_dir_figure,
            gsub(
              pattern = paste0(source_dir, "/"),
              replacement = "",
              x = (current_figures),
              fixed = TRUE
            )
          )
          lapply(
            X = dirname(figure_out_files),
            FUN = dir.create,
            recursive = TRUE,
            showWarnings = FALSE
          )
        }
        file.copy(from = current_figures, to = figure_out_files)
        unlink(df_source_files$figure_source[i], recursive = TRUE)
      }
    }
  }

  # copy rendered files from source to output (delete from source)
  if (is.null(target_dir_docs) == FALSE) {
    for (i in 1:nrow(df_source_files)) {
      files_source_dir <- list.files(source_dir, full.names = TRUE, recursive = TRUE)
      filename_dot <- paste0(df_source_files$filename_noxt[i], ".")
      source_docs <-
        files_source_dir[grep(pattern = filename_dot,
                              x = files_source_dir,
                              fixed = TRUE)]
      render_docs <-
        source_docs[-which(source_docs == df_source_files$filename[i])]
      if (rename_docs == TRUE) {
        pdf_html_docx_source <-
          render_docs[grep(pattern = ".pdf|.html|.docx", x = render_docs)]
        pdf_html_docx_output <-
          paste0(df_source_files$docs_out[i],
                 "_",
                 basename(pdf_html_docx_source))
        file.copy(from = pdf_html_docx_source, to = pdf_html_docx_output)
        temp_docs_source <-
          render_docs[!render_docs %in% pdf_html_docx_source]
        file.copy(from = temp_docs_source, to = df_source_files$temp_docs_out[i])
      } else {
        # if rename_docs == FALSE
        docs_out_files <- file.path(target_dir_docs,
                                    gsub(
                                      pattern = paste0(source_dir, "/"),
                                      replacement = "",
                                      x = render_docs,
                                      fixed = TRUE)
                                    )
        lapply(
          X = dirname(docs_out_files),
          FUN = dir.create,
          recursive = TRUE,
          showWarnings = FALSE
        )
        file.copy(from = render_docs,
                  to = docs_out_files)
      }
      unlink(render_docs)
    }
  }
}

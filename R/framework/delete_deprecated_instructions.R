#' Keep your output clean!
#'
#' @description This function will delete all deprecated files frem your last
#'   session.
#' @inheritParams project_framework
#' @note This function is part of a family of functions each of which end with
#'   '_instructions'. The order to call these functions is:
#'   'prepare_instructions', 'implement_instructions', 'check_instructions',
#'   'delete_deprecated_instructions', 'execute_instructions' and optionally
#'   'output_instructions'. There is a wrapper for these functions called
#'   'instructions'.
#' @seealso \code{\link{prepare_instructions}},
#'   \code{\link{implement_instructions}}, \code{\link{check_instructions}},
#'   \code{\link{instructions}}, \code{\link{execute_instructions}},
#'   \code{\link{output_instructions}}
#' @author Frederik Sachser
#' @export
delete_deprecated_instructions <- function(cache_dir = ".cache") {
  # check prerequisites
  if (all(file.exists(
    file.path(cache_dir, "df_source_files_temp.rds"),
    file.path(cache_dir, "df_source_files.rds"),
    file.path(cache_dir, "instructions.RData")
  ) == TRUE)) {
    # reload instructions
    load(file.path(cache_dir, "instructions.RData"))
    # reload df_source_files (last session)
    df_last_session <-
      readRDS(file = file.path(cache_dir, "df_source_files.rds"))
    
    
    # specify index of source-files that have been excluded since the last session
    delete_index <-
      which(df_last_session$filename %in% source_files == FALSE)
    
    
    ########## hier weiter ##########
    df_source_files <-
      readRDS(file = file.path(cache_dir, "df_source_files_temp.rds"))
    delete_index_2 <-
      which(df_last_session$filename %in% df_source_files$filename[which(df_source_files$order_change == TRUE)] == TRUE)
    delete_index <- unique(c(delete_index, delete_index_2))
    #    if (isTRUE(delete_index > 0)) {
    #        delete_index <- delete_index:nrow(df_last_session)
    #   }
    #    which(df_last_session$order_change == TRUE)
    #    which(df_source_files$order_change == TRUE)
    #
    #    delete_index <- unique(c(delete_index, which(df_last_session$order_change == TRUE)))
    #################################
    #################################
    # delete deprecated files from of input that will be processed
    #    df_source_files$filename[which(df_source_files$order_change == TRUE)]
    
    
    #    grep(pattern = paste(df_source_files$filename[which(df_source_files$order_change == TRUE)]), x = df_last_session$filename, fixed = TRUE)
    #    delete_index_2 <- which(df_source_files$instruction == "source" | df_source_files$instruction == "nothing")
    #    df_source_files[delete_index_2, ]
    
    if (isTRUE(length(delete_index) > 0)) {
      # figures
      the_figures <- df_last_session[delete_index, "figure_out"]
      for (i in seq_along(the_figures)) {
        unlink(file.path(
          dirname(the_figures[i]),
          list.files(
            path = dirname(the_figures[i]),
            pattern = basename(the_figures[i])
          )
        ), recursive = TRUE)
      }
      
      # temp_docs
      the_temp_docs <- df_last_session[delete_index, "temp_docs_out"]
      for (i in seq_along(the_temp_docs)) {
        unlink(file.path(
          dirname(the_temp_docs[i]),
          list.files(
            path = dirname(the_temp_docs[i]),
            pattern = basename(the_temp_docs[i])
          )
        ), recursive = TRUE)
      }
      
      # docs
      the_docs <-
        paste0(df_last_session[delete_index, "docs_out"], "_", df_last_session[delete_index, "basename_noxt"])
      for (i in seq_along(the_docs)) {
        unlink(file.path(
          dirname(the_docs[i]),
          list.files(
            path = dirname(the_docs[i]),
            pattern = basename(the_docs[i])
          )
        ), recursive = TRUE)
      }
      
      # image_cache
      the_image <- df_last_session[delete_index, "image_cache"]
      for (i in seq_along(the_image)) {
        unlink(file.path(
          dirname(the_image[i]),
          list.files(
            path = dirname(the_image[i]),
            pattern = basename(the_image[i])
          )
        ), recursive = TRUE)
      }
      
    }
  }
}

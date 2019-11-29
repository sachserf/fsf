#' Write a bunch of dataframes
#'
#' @description This function will write multiple dataframes into separate files.
#' @param target_dir_data Character. Target directory for data.
#' @param listofdf Character vector. Specify a vector of dataframes to write. Choose 'GlobalEnv' to write all data frames currently inside your global environment.
#' @param data_extension Character. Specify file extension for data frames. Possible values: 'csv', 'RData' and 'rds'.
#' @param rebuild_target_dir_data Logical. Delete target_dir_data before writing current data frames.
#' @param summarize_df Logical. Should a list of written data frames be printed to console?
#' @author Frederik Sachser
#' @export
write_data <-
  function(listofdf = "GlobalEnv", target_dir_data = "data", data_extension = "RData", rebuild_target_dir_data = FALSE, summarize_df = TRUE)
  {
    target_dir_data <- file.path(target_dir_data)
    if (listofdf == "GlobalEnv") {
      listofdf <- names(which(sapply(.GlobalEnv, is.data.frame) ==
                                TRUE))
    }
    if (dir.exists(target_dir_data) == FALSE) {
      dir.create(target_dir_data, recursive = TRUE)
    }

    if (rebuild_target_dir_data == TRUE) {
      # delete all existing data
      unlink(list.files(target_dir_data, full.names = TRUE), recursive = TRUE)
    }

    # write files
    if (data_extension == "csv") {
      csv_fun <- function(objectname) {
        filename <- paste(file.path(target_dir_data, objectname),
                          "csv", sep = ".")
        utils::write.table(x = get(objectname), file = filename,
                           sep = ";", row.names = FALSE)
      }
      lapply(listofdf, FUN = csv_fun)
    }
    if (data_extension == "rds") {
      rds_fun <- function(objectname) {
        filename <- paste(file.path(target_dir_data, objectname),
                          "rds", sep = ".")
        saveRDS(object = get(objectname), file = filename)
      }
      lapply(listofdf, FUN = rds_fun)
    }
    if (data_extension == "RData") {
      RData_fun <- function(objectname) {
        filename <- paste(file.path(target_dir_data, objectname),
                          "RData", sep = ".")
        save(file = filename, list = objectname)
      }
      lapply(listofdf, FUN = RData_fun)
    }

    if (!is.null(summarize_df) && summarize_df == TRUE) {
      #    cat("\n\n#############################################\n############ Writing data #############\n#############################################\n")
      message('\ndata:\n')
      writeLines(text = paste0("Wrote the following data frames into diretory '", target_dir_data, "':\n", paste(listofdf, collapse = "\n")), con = stdout())
    }
  }



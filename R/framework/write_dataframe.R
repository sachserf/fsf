#' Save a bunch of dataframes
#' 
#' @description This function will write multiple dataframes into separate 
#'   files. File extension can be of type 'RData', 'rds' or 'csv'.
#' @param listofdf Character. Specify a vector of dataframes to write. Choose
#'   "GlobalEnv" if you want to write all dataframes within your Global
#'   Environment to separated files.
#' @param target_dir_data Character. File path to the target directory.
#' @param file_format Character. Choose between 'csv', 'rds' or 'RData'.
#' @author Frederik Sachser 
#' @export
write_dataframe <- 
  function(listofdf = "GlobalEnv", target_dir_data = "out/data", file_format = "csv") 
  {
    target_dir_data <- file.path(target_dir_data)
    if (listofdf == "GlobalEnv") {
      listofdf <- names(which(sapply(.GlobalEnv, is.data.frame) == 
                                TRUE))
    }
    if (dir.exists(target_dir_data) == FALSE) {
      dir.create(target_dir_data, recursive = TRUE)
    }
    
    # delete all existing data
    unlink(list.files(target_dir_data, full.names = TRUE), recursive = TRUE)
    
    # write files
    if (file_format == "csv") {
      csv_fun <- function(objectname) {
        filename <- paste(file.path(target_dir_data, objectname), 
                          "csv", sep = ".")
        utils::write.table(x = get(objectname), file = filename, 
                           sep = ";", row.names = FALSE)
      }
      lapply(listofdf, FUN = csv_fun)
    }
    if (file_format == "rds") {
      rds_fun <- function(objectname) {
        filename <- paste(file.path(target_dir_data, objectname), 
                          "rds", sep = ".")
        saveRDS(object = get(objectname), file = filename)
      }
      lapply(listofdf, FUN = rds_fun)
    }
    if (file_format == "RData") {
      RData_fun <- function(objectname) {
        filename <- paste(file.path(target_dir_data, objectname), 
                          "RData", sep = ".")
        save(file = filename, list = objectname)
      }
      lapply(listofdf, FUN = RData_fun)
    }
  }

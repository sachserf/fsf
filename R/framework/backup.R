#' Copy a directory into timestamp-dir
#' 
#' @description The function will copy the specified directory and create a 
#'   directory at the target. The target directory will be named after the
#'   current date and time.
#' @param target_dir Character. Path to the target directory. Alternatively use 
#'   'project_subdir' to point to a subfolder of your current working directory.
#' @param source_dir Character. Path to the source directory. Default is the 
#'   current working directory.
#' @param delete_target Logical. If TRUE all directories within the target 
#'   directory will be deleted! Only the current version of your backup will be 
#'   existent.
#' @param exclude_directories Character. Specify directories to exclude from 
#'   backup. If you want to exclude multiple directories use | as separator. 
#'   Choose FALSE if you don not want to exclude any directories.
#' @param exclude_files Character. Specify files to exclude from backup. If you 
#'   want to exclude multiple directories use | as separator. Choose FALSE if 
#'   you don not want to exclude any files
#' @note Beware! If you choose an existing target directory and option 
#'   delete_target = TRUE: ALL EXISTING FILES WILL BE DELETED!
#' @author Frederik Sachser
#' @export
backup <- 
function(target_dir = "project_subdir", source_dir = file.path(getwd()), 
    delete_target = FALSE, exclude_directories = FALSE, exclude_files = FALSE) 
{
    projname <- paste("BACKUP_", basename(getwd()), sep = "")
    if (target_dir == "project_subdir") {
        target_dir <- file.path(getwd(), projname)
    }
    else {
        target_dir <- file.path(target_dir, projname)
    }
    stime <- format(Sys.time(), format(Sys.time(), format = "%Y%m%d-%A-%H%M%S"))
    target_dir_stime <- file.path(target_dir, stime)
    sub_directories <- list.dirs(source_dir, full.names = FALSE)
    project_files <- list.files(source_dir, all.files = TRUE, 
        no.. = TRUE, recursive = TRUE)
    dir_exclude <- grep(pattern = target_dir, x = file.path(source_dir, 
        sub_directories))
    if (length(dir_exclude) != 0) {
        sub_directories <- file.path(sub_directories)[-dir_exclude]
    }
    if (exclude_directories != FALSE) {
        dir_exclude_custom <- grep(pattern = exclude_directories, 
            x = file.path(source_dir, sub_directories))
        if (length(dir_exclude_custom) != 0) {
            sub_directories <- file.path(sub_directories)[-dir_exclude_custom]
        }
    }
    project_files_full <- list.files(source_dir, full.names = TRUE, 
        all.files = TRUE, no.. = TRUE, recursive = TRUE)
    file_exclude <- grep(pattern = target_dir, x = project_files_full)
    if (length(file_exclude) != 0) {
        project_files <- file.path(project_files)[-file_exclude]
    }
    if (exclude_directories != FALSE) {
        file_exclude_custom_dir <- grep(pattern = exclude_directories, 
            x = project_files)
        if (length(file_exclude_custom_dir) != 0) {
            project_files <- file.path(project_files)[-file_exclude_custom_dir]
        }
    }
    if (exclude_files != FALSE) {
        file_exclude_custom_file <- grep(pattern = exclude_files, 
            x = project_files)
        if (length(file_exclude_custom_file) != 0) {
            project_files <- file.path(project_files)[-file_exclude_custom_file]
        }
    }
    dir_create_or_exist <- function(thedirectory) {
        if (dir.exists(thedirectory) == FALSE) {
            dir.create(thedirectory, recursive = TRUE)
        }
    }
    if (delete_target == TRUE) 
        unlink(target_dir, recursive = TRUE)
    dir_create_or_exist(target_dir)
    lapply(file.path(target_dir_stime, sub_directories), dir_create_or_exist)
    file.copy(from = file.path(source_dir, project_files), to = file.path(target_dir_stime, 
        project_files), recursive = FALSE)
}

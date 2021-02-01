#' insert docx comment
#'
#' @param highlight Character. Text that should be higlighted (to comment on).
#' @param comment Character. The Comment inside the box.
#' @param name Character. Name of coment author.
#' @param thedate Character. Date of the comment.
#'
#' @export
#'
cmt <- function(highlight = "", comment, name = Sys.info()["user"], thedate = Sys.time()) {

  # adapted from:
  # https://stackoverflow.com/questions/57892419/add-a-ms-word-comment-via-rmarkdown

  if (isTRUE(knitr:::pandoc_to() == "docx")) {

    filelist <- list.files(path = ".", pattern = "\\.Rmd$", recursive = FALSE)

    filelist <- filelist[!grepl("_draft.Rmd", filelist)]
    readlist <- lapply(filelist, readLines)
    names(readlist) <- filelist
    #    expressionindex <- list()
    thisexpression <- list()

    for (i in seq_along(filelist)) {
      #      expressionindex[[i]] <- grep("r cmt", readlist[[i]])
      thisexpression[[i]] <- grep(comment, readlist[[i]])
    }

    my_id <- as.integer(paste0(foo, thisexpression[foo])) # paste doc-number and line

    #    which(thisexpression %in% expressionindex)
    #    my_id <- sum(sapply(expressionindex, length))

    paste0('[', comment, ']{.comment-start id="',my_id,'" author="',name,'"','date="',thedate,'"}', highlight, '[]{.comment-end id="',my_id,'"}')
  }
}

#' COMpare COMmon COLumns of multiple dataframes
#'
#' @description This function will count and print the number of common columns of given dataframes and check consistency of additional values. Comparison is based on colnames. For single dataframes the output is per default a representation of `lapply(<dataframe>, class)` (formatted as a dataframe).
#' @param ... Objects of class data.frame.
#' @param custom_fun object of class function. `comcomcol` acts as a functional and takes another function as input (wrapper for lapply). Specify any function for comparison. Default is `class`.
#' @param freq_only Logical. Specify if custom_fun should be included.
#' @param freq_sort Logical. Specify if output should be sorted according to frequency of common columns.
#' @author Frederik Sachser
#' @export

comcomcol <-
  function(...,
           custom_fun = class,
           freq_only = FALSE,
           freq_sort = TRUE) {
    # prepare input
    thelist <- list(...)
    # check if first element of list is a dataframe (possible input: single object (list or single dataframes), multiple objects)
    if (is.data.frame(thelist[[1]]) == FALSE) {
      thelist <- unlist(thelist, recursive = FALSE)
    }

    ilength <- length(thelist)
    listnames <- list()

    # extract names and count freq
    for (i in 1:ilength) {
      listnames[[i]] <- names(thelist[[i]])
    }
    listnames <- table(unlist(listnames))
    listnames <- as.data.frame(listnames)

    # sort output according to freq
    if (freq_sort == TRUE) {
      listnames <- listnames[order(listnames[, "Freq"]), ]
    }

    # add information about class
    if (freq_only == TRUE) {
      if (length(unique(listnames$Freq)) != 1) {
        message("Length of unique column names differ.")
      } else {
        message("Length of unique column names is equal.")
      }
      return(listnames)
    } else {
      # create list of classes
      classlist <- list()
      for (i in 1:ilength) {
        classlist[[i]] <- lapply(thelist[[i]], custom_fun)
      }
      # unlist first order
      unclasslist <- unlist(classlist, recursive = FALSE)

      # prepare output dataframe: expand columns
      for (i in 3:(ilength + 2)) {
        listnames[i] <- NA
      }

      # write information about classes into expanded columns of output dataframe

      for (i in seq_along(listnames$Var1)) {
        varexists <- c(rep(NA, ilength))
        for (j in 1:ilength) {
          varexists[j] <- listnames$Var1[i] %in% lapply(classlist, names)[[j]]
        }

        classindex <- which(names(unclasslist) == listnames$Var1[i])

        listnames[i, 3:(2 + ilength)][which(varexists == TRUE)] <-
          paste(unclasslist[classindex], sep = ", ")
      }

      # rename columns of output dataframe
      names(listnames) <- c("VARIABLE", "FREQ", sapply(substitute(placeholderFunction(...))[-1], deparse))

      # check consistency of classes
      outvec <- c()
      for (i in 1:nrow(listnames)) {
        outvec[i] <- length(unique(c(listnames[i, 3:ncol(listnames)])))
      }

      # add length of unique values of custom function
      listnames <- cbind(listnames[1:2], UNIQ = outvec, listnames[3:ncol(listnames)])

      list_out <- list()
      if (any(outvec == 1)) {
        list_out$COMMON <- listnames[(outvec == 1), ]
      }
      if (any(outvec > 1)) {
        list_out$DIFFERENT <- listnames[(outvec > 1), ]
      }

      list_out$SUMMARY <- paste(ifelse(is.null(list_out$DIFFERENT), "0", nrow(list_out$DIFFERENT)), "columns differ.", nrow(list_out$COMMON), "columns are equal.")

      return(list_out)
    }
  }


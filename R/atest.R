#' add Test-statement to predefined dataframe
#'
#' @param object The object to be testet (should be a vector). In case of a list only first element will be used for evaluation.
#' @param expect Character. Statement to be evaluated
#' @param description A description of the test. Must be unique for all collected tests within the dataframe.
#' @param test_df Specify dataframe where evaluation should be added.
#' @param assign Logical. Choose TRUE to add the evaluation to the test_df.
#'
#' @export
#'
#' @seealso \code{\link[fsf]{utest}}, \code{\link[fsf]{stest}}
#' @examples atest(iris$Species, "%in% c('setosa', 'virginica', 'versicolor')")
atest <- function(object, expect, description, test_df = test_dataframe, assign = TRUE) {
  out <- deparse(substitute(test_df))

  if (is.list(object)) object <- object[[1]]
  obj_class <- class(object)

  if (missing(description)) description <- paste(substitute(object))

  if (isTRUE(exists(paste(substitute(test_df))))) {
    if (description %in% test_df[, "DESCRIPTION"]) {
      return(warning("duplicated description - choose different and retry"))
    }
  }

  values <- base::unique(object)

  if (!obj_class %in% "numeric") {
    diffs <- paste0("'", values,"' ", expect) # add "'" to add possibility to compare character strings (hint: '2.3' == 2.3 is TRUE)
  } else {
    diffs <- paste(values, expect) # paste numeric values as is (otherwise mathematical operators might fail - e.g. %% does not work with character (and conversion will fail))
  }

  EVALUATION <- all(sapply(parse(text = diffs), eval))
  VALUE <- paste0(values, collapse = ", ")
  #  DIFF <- paste0(diffs, collapse = ", ")

  if (isTRUE(exists(paste(substitute(test_df))))) {
    newrow <- nrow(test_df) + 1
    test_df[newrow, "DESCRIPTION"] <- description
    test_df[newrow, "VALUE"] <- VALUE
    test_df[newrow, "EXPECT"] <- expect
    #    test_df[newrow, "DIFF"] <- DIFF
    test_df[newrow, "EVALUATION"] <- EVALUATION
  } else {
    message("Cannot find test_df. Creating from scratch.")
    test_df <- data.frame(DESCRIPTION = description,
                          VALUE = VALUE,
                          EXPECT = expect,
                          #                          DIFF = DIFF,
                          EVALUATION = EVALUATION,
                          stringsAsFactors = FALSE)
  }

  stest(test_df = test_df, return = FALSE)

  if (isTRUE(assign)) {
    message("Assigning test_df to global environment.")
    assign(out, test_df, envir = .GlobalEnv)
    print(unique(object))
    invisible(test_df)
  } else return(test_df)
}

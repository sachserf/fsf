#' cat howto 2 column layout in Rmd-documents
#'
#' @export
rmd_2col_layout <- function() {
  cat("## 2col layout

:::::: {.columns}
::: {.column}
Content of the left column.
:::

::: {.column}
Content of the right column.
:::
::::::")
}

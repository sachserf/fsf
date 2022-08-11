#' Traceplot for jagsUI objects
#'
#' @param jagsUI_object Object of class jagsUI.
#' @param filepath Optional. Specify filepath (including adequate extension) in case you want to save the figure. Printing will be supressed.
#' @param mytitle Optional. Specify title.
#'
#' @export
ggtraceplot <- function(jagsUI_object, filepath = NULL, title) {
  mytraceplot <- data.frame(c(jagsUI_object$sims.list), index = 1:(jagsUI_object$mcmc.info$n.samples/jagsUI_object$mcmc.info$n.chains), chain = rep(1:jagsUI_object$mcmc.info$n.chains, each = jagsUI_object$mcmc.info$n.samples/jagsUI_object$mcmc.info$n.chains)) %>%
    pivot_longer(cols = 1:length(names(jagsUI_object$sims.list))) %>%
    left_join(., data.frame(Rhat = t(data.frame(jagsUI_object$Rhat)), name = names(jagsUI_object$Rhat), stringsAsFactors = FALSE), by = "name") %>%
    mutate(name = paste0("Trace of ", name, ", Rhat = ", round(Rhat, digits = 2))) %>%

    ggplot() +
    geom_line(aes(index, value, col = factor(chain)), alpha = .8, size = .1) +
    facet_wrap("name", scales = "free") +
    theme_minimal() +
    theme(legend.position = "none") +
    ggtitle(title)

  if (!is.null(filepath)) {
    mytraceplot %>% ggsave(filename = filepath)
  } else (print(mytraceplot))
}

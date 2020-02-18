#' density strip with some defaults
#'
#' @param jagsout object oc class jagsUI.
#' @param parameters_index integer vector. Specify index for parameters (intended for output of output from jagsUI).
#'
#' @seealso \code{\link[denstrip]{denstrip}}
#' @export
dstrip <- function(jagsout, parameters_index) {
  plot(jagsout$nothing, xlim=c(min(unlist(jagsout$sims.list[parameters_index])), max(unlist(jagsout$sims.list[parameters_index]))), ylim=c(1, length(parameters_index)), xlab="", ylab="", type="n", axes = F, main = "Density strip plots")
  axis(1)
  axis(2, at = seq_along(parameters_index), labels = names(jagsout$sims.list)[parameters_index], las = 1)
  abline(v = simdata$N)
  for(k in 1:length(parameters_index)){
    index <- parameters_index[k]
    denstrip::denstrip(unlist(jagsout$sims.list[index]), at = k, ticks = jagsout$summary[index, c(3,5,7)])
  }
}

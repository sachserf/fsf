#' sf - custom ggplot-theme
#'
#' @param base_size Integer. Specify font size.
#' @param base_family Character. Specify font.
#' @param x_angle Integer. Specify angle (0-360 degree) to rotate labels of x-axis.
#' @param strip_bg_blank Logical. Should background of strip should be grey or blank?
#' @param legend_bg_blank Logical. Should background of legend should be grey or blank?
#'
#' @author Frederik Sachser
#' @export
gg_theme_sf <- function(base_size=12, base_family="Helvetica", x_angle = 45, strip_bg_blank = FALSE, legend_bg_blank = TRUE) {
  ggplot2::theme_bw(base_size = base_size, base_family = base_family) + # %+replace%
    ggplot2::theme(
      # text
      text = ggplot2::element_text(colour = "black"),

      # plot
      plot.background =      ggplot2::element_rect(fill = NA, colour = NA),
      plot.margin =          ggplot2::unit(c(0.5, 0.5, 0.5, 0.5), "lines"),

      # panel
      panel.background =     ggplot2::element_rect(fill = NA, colour = "gray77", size = 0.3, linetype = "solid"),
      panel.border =         ggplot2::element_rect(fill = NA, colour = "gray77", size = 0.3, linetype = "solid"),
      panel.spacing.x =      ggplot2::unit(0.5, "lines"),
      panel.spacing.y =      ggplot2::unit(0.5, "lines"),
      panel.grid.major.x =   ggplot2::element_blank(),
      panel.grid.major.y =   ggplot2::element_line(size = 0.2, linetype = 'dotted', colour = "black"),
      panel.grid.minor =     ggplot2::element_line(size = 0.2, linetype = 'dotted', colour = "grey"),

      # facet headers
      strip.text.x =         ggplot2::element_text(size = 10, colour = "black", margin = ggplot2::margin(t = 2, r = 2, b = 2, l = 2, unit = "pt")),
      # strip.background: see condition below

      # axis
      axis.text.x =          ggplot2::element_text(size = 12, colour = c("black", "black"), vjust = 0.5, angle = x_angle),
      axis.text.y =          ggplot2::element_text(size = 12, colour = "black", angle = 0, hjust = -0.1),
      axis.ticks.x =         ggplot2::element_blank(),
      axis.ticks.length =    ggplot2::unit(0.2, "cm"),

      # legend
      legend.text =          ggplot2::element_text(face = "italic"),
      legend.position =      "top",
      legend.direction =     "horizontal",
      legend.key =           ggplot2::element_blank(),
      legend.margin =        ggplot2::margin(t = 5, r = 5, b = 5, l = 5, unit = "pt")
      # legend.background: see condition below
    ) +
    if (strip_bg_blank == TRUE) {
      ggplot2::theme(strip.background =   ggplot2::element_blank())
    } else {
      ggplot2::theme(strip.background =   ggplot2::element_rect(colour = "darkgrey", fill = "grey93"))
    } +
    if (legend_bg_blank == TRUE) {
      ggplot2::theme(legend.background =  ggplot2::element_blank())
    } else {
      ggplot2::theme(
        legend.background =      ggplot2::element_rect(colour = "darkgrey", fill = NA)
      )
    }
}

#' Set up customized skimr output
#'
#' @export
skim_set <- function() {
  skim_num <- list(missing = NULL,
                   complete = NULL,
                   n = NULL,
                   mean = NULL,
                   sd = NULL,
                   p0 = NULL,
                   p25 = NULL,
                   p50 = NULL,
                   p75 = NULL,
                   p100 = NULL,
                   hist = NULL,
                   N = ~length(x = .),
                   "NA" = ~skimr::n_missing(x = .),
                   #                 "!NA" = ~skimr::n_complete(x = .),
                   "#0" = ~length(which(. == 0)),
                   Mean = ~mean(x = ., na.rm = TRUE),
                   median = ~stats::median(., na.rm = TRUE),
                   s = ~stats::sd(x = ., na.rm = TRUE),
                   mad = ~stats::mad(x = ., na.rm = TRUE),
                   iqr = ~stats::IQR(x = ., na.rm = TRUE),
                   Q1 = ~stats::quantile(x = ., probs = 0.25, na.rm = TRUE),
                   Q3 = ~stats::quantile(x = ., probs = 0.75, na.rm = TRUE),
                   min = ~min(., na.rm = TRUE),
                   max = ~max(., na.rm = TRUE),
                   p025 = ~stats::quantile(x = ., probs = 0.025, na.rm = TRUE),
                   p975 = ~stats::quantile(x = ., probs = 0.975, na.rm = TRUE),
                   sem = ~stats::sd(x = ., na.rm = TRUE)/sqrt(length(na.omit(.))),
                   cv = ~stats::sd(x = ., na.rm = TRUE)/mean(x = ., na.rm = TRUE), # coefficient of variation
                   CIlow = ~stats::t.test(.)$conf.int[1],
                   CIup = ~stats::t.test(.)$conf.int[2],
                   #                 p_sw = ~stats::shapiro.test(x = .)$p.value,
                   skew = ~e1071::skewness(.), # positiv skewness = right tail longer
                   kurtosis = ~e1071::kurtosis(.), # flat-topped (platykurtic) distribution: negative; pointy (leptokurtic) distribution: positive
                   histogram = ~skimr::inline_hist(.))

  skim_logical <- list("FALSE" = ~sum(!., na.rm = TRUE),
                       "TRUE" = ~sum(., na.rm = TRUE),
                       barchart = ~skimr::inline_hist(as.integer(na.omit(.))))

  skim_char <- list(barchart = ~skimr::inline_hist(as.integer(as.factor(na.omit(.)))))

  skim_fac <- list(barchart = ~skimr::inline_hist(as.integer(na.omit(.))))

  skimr::skim_with_defaults()
  skimr::skim_with(numeric = skim_num,
                   factor = skim_fac,
                   integer = skim_num,
                   logical = skim_logical,
                   character = skim_char)
  skimr::skim_format_defaults()
  skimr::skim_format(numeric = list(digits = 2),
                     integer = list(digits = 2),
                     .levels = list(max_char = 5))
}

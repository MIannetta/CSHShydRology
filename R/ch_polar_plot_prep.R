#' Creates a data structure to be passed to \code{ch_polar_plot}.
#'
#' Could be used to move data from a different type of analysis different to the \code{binned_MannWhitney} function which uses flows. The two series need to be of the same length and their length is related to the step size. For examples 73 periods links to 5 day periods.
#'
#' @param station Typically a station number
#' @param plot_title Polar plot title - usually a station name
#' @param step The number of days binned
#' @param x0 Time series of length n for a single seasonal cycle
#' @param x1 Time series of length n for a single seasonal cycle
#' @param stat Time series of length n for statistical test value for each bin
#' @param prob Time series of length n of probability of test value
#' @param test_s Vector with values of -1, 0, 1 for significance, -1 negative, 1 positive, 0 not significant
#' @param variable Name of variable plotted. Default is "discharge"
#' @param bin_method Default is "unstated"
#' @param test_method Default is "unstated"
#' @param lline1 Names of first period, default is "Period 1"
#' @param lline2 Names of second period, default is "Period 2"
#' @param pvalue Value of p used. Default is 0.05
#' @return Returns a list containing:
#' \describe{
#'  \item{StationID}{ID of station}
#'  \item{Station_lname}{Name of station}
#'  \item{variable}{Name of variable}
#'  \item{bin_width}{Smoothing time step}
#'  \item{range1}{range1 years}
#'  \item{range2}{range2 years}
#'  \item{p_used}{p value used}
#'  \item{fail}{TRUE if test failed due to missing values}
#'  \item{bin_method}{method used for binning}
#'  \item{test_method}{Mann-Whitney U}
#'  \item{series}{a data frame containing:}
#' 	\item{period}{period numbers i.e. 1:365/step}
#' 	\item{period1}{median values for each bin in period 1}
#' 	\item{period2}{median values for each bin in period 2}
#' 	\item{mwu}{Mann Whitney U-statistic for each bin between the two periods}
#' 	\item{prob}{probability of U for each period}
#' 	\item{code}{significance codes for each bin}
#' 	}
#' @references
#' Whitfield, P.H. and A.J. Cannon. 2000. Polar plotting of seasonal hydrologic
#' and climatic data. Northwest Science 74: 76-80.
#'
#' Whitfield, P.H., Cannon, A.J., 2000. Recent variations in climate and hydrology
#' in Canada. Canadian Water Resources Journal 25: 19-65.

#'
#' @author Paul Whitfield <paul.h.whitfield@gmail.com>
#'
#' @export
#' @seealso \code{\link{ch_binned_MannWhitney}} \code{\link{ch_polar_plot}}


ch_polar_plot_prep <- function(station, plot_title, step, x0, x1, stat, prob, test_s, variable = "discharge",
                            bin_method = "unstated", test_method = "unstated",
                            lline1 = "Period 1", lline2 = "Period 2", pvalue = 0.05) {
  fail <- FALSE

  if (length(x0) != length(x1)) return(paste("Arrays of x unequal length", length(x0), length(x1)))
  if (length(x0) != length(stat)) return(paste("Arrays of x0 and stat unequal length", length(x0), length(stat)))
  if (length(x0) != length(prob)) return(paste("Arrays of x0 and prob unequal length", length(x0), length(prob)))
  if (length(x0) != length(test_s)) return(paste("Arrays of x0 and test_s unequal length", length(x0), length(test_s)))

  period <- c(1:length(x0))


  series <- data.frame(period, x0, x1, stat, prob, test_s)
  names(series) <- c("period", "period1", "period2", "stat", "prob", "code")


  result <- list(station, plot_title, variable, step, lline1, lline2, pvalue, fail, bin_method, test_method, series)

  names(result) <- c(
    "StationID", "Station_lname", "variable", "bin_width", "range1", "range2",
    "p_used", "fail", "bin_method", "test_method", "series"
  )
  return(result)
}

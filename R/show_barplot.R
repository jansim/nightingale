# filepath: /Users/jan/Work/LMU/teaching/DRA/2505 - HDRUK Project/nightingale/R/show_barplot.R

#' Create a Bar Plot of Mortality Data
#'
#' This function creates a bar plot visualization of mortality data from the
#' Crimean War, showing deaths per 1000 soldiers per year. The plot includes
#' a vertical line marking when Nightingale's sanitary improvements were
#' implemented in February/March 1855.
#'
#' @param mortality_data A data frame containing mortality data with columns
#'   for date and various causes of death. Defaults to the `mortality` dataset.
#' @param include_total Logical. Whether to include the total mortality column
#'   in the visualization. Defaults to FALSE.
#'
#' @return A ggplot2 object representing the bar plot of mortality data.
#'
#' @examples
#' # Basic bar plot without total column
#' show_barplot()
#'
#' # Bar plot including total mortality
#' show_barplot(include_total = TRUE)
#'
#' @export
show_barplot <- function(mortality_data = mortality, include_total = FALSE) {
  if (!include_total) {
    mortality_data <- mortality_data |>
      dplyr::select(-total)
  }

  # Inspired by:
  # https://www.datawrapper.de/blog/recreating-nightingale-rose-chart
  mortality_data |>
    tidyr::pivot_longer(-date, names_to = "cause_of_death", values_to = n_deaths) |>
    ggplot2::ggplot() +
    ggplot2::aes(
      x = date,
      y = n_deaths,
      fill = cause_of_death
    ) +
    ggplot2::geom_col(position = "dodge") +
    ggplot2::theme_classic() +
    ggplot2::labs(
      x = "",
      y = "Deaths per 1000 soldiers per year"
    ) +
    ggplot2::scale_x_datetime(date_labels = "%B %Y") +
    # Nightingale's improvements were implemented in Feb / March 1855
    ggplot2::geom_vline(xintercept = as.POSIXct("1855-02-15"), linetype = "dashed")
}

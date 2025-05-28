show_barplot <- function(mortality_data = mortality, include_total = FALSE) {
  if (!include_total) {
    mortality_data <- mortality_data |>
      dplyr::select(-total)
  }

  # Inspired by:
  # https://www.datawrapper.de/blog/recreating-nightingale-rose-chart
  mortality_data |>
    tidyr::pivot_longer(-date) |>
    ggplot2::ggplot() +
    ggplot2::aes(
      x = date,
      y = value,
      fill = name
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

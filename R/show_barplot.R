show_barplot <- function(mortality_data = mortality, include_total = FALSE) {
  if (!include_total) {
    mortality_data <- mortality_data |>
      select(-total)
  }

  # Inspired by:
  # https://www.datawrapper.de/blog/recreating-nightingale-rose-chart
  mortality_data |>
    pivot_longer(-date) |>
    ggplot() +
    aes(
      x = date,
      y = value,
      fill = name
    ) +
    geom_col(position = "dodge") +
    theme_classic() +
    labs(
      x = "",
      y = "Deaths per 1000 soldiers per year"
    ) +
    scale_x_datetime(date_labels = "%B %Y") +
    # Nightingale's improvements were implemented in Feb / March 1855
    geom_vline(xintercept = as.POSIXct("1855-02-15"), linetype = "dashed")
}

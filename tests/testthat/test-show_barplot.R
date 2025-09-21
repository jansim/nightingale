# Create sample test data
test_mortality_data <- data.frame(
  date = as.POSIXct(c("1854-04-01", "1854-05-01", "1854-06-01")),
  disease = c(100, 150, 80),
  wounds = c(50, 75, 40),
  other = c(30, 45, 25),
  total = c(180, 270, 145)
)

test_that("show_barplot returns a ggplot object and excludes total by default", {
  plot <- show_barplot(test_mortality_data)
  expect_s3_class(plot, "ggplot")

  plot_data <- ggplot2::ggplot_build(plot)$data[[1]]
  # Should have 9 rows (3 dates × 3 categories, excluding total)
  expect_equal(nrow(plot_data), 9)
})

test_that(
  "show_barplot includes total column when metrics = c('disease', 'wounds', 'other', 'total')",
  {
    plot <- show_barplot(test_mortality_data, metrics = c("disease", "wounds", "other", "total"))
    plot_data <- ggplot2::ggplot_build(plot)$data[[1]]

    # Should have 12 rows (3 dates × 4 categories, including total)
    expect_equal(nrow(plot_data), 12)
  }
)

test_that("show_barplot should validate metrics", {
  expect_error(
    show_barplot(test_mortality_data, metrics = c("disease", "invalid_metric"))
  )
})

test_that("show_barplot visual appearance", {
  plot <- show_barplot(test_mortality_data, highlight_intervention = FALSE)
  suppressMessages({
    plot <- plot +
      ggplot2::scale_x_date(
        date_breaks = ggplot2::waiver(),
        breaks = as.Date(c("1854-04-01", "1854-05-01", "1854-06-01")),
        labels = scales::label_date(format = "%m/%Y", locale = NULL)
      )
  })
  vdiffr::expect_doppelganger("barplot_default", plot)
})

library(tidyverse)

mortality <- read_csv(
  "data-raw/mortality-raw.csv",
  col_names = c(
    "date",
    "disease",
    "wounds",
    "other",
    "total"
  ),
  skip = 1
) |>
  separate(date, c("month", "year")) |>
  fill(year, .direction = "down") |>
  unite("date", month:year, sep = " ") |>
  mutate(
    date = parse_date_time(date, orders = c("m/Y"))
  )

usethis::use_data(mortality, overwrite = TRUE)

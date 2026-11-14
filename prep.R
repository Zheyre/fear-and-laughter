library(dplyr)
library(readr)
library(ggplot2)
library(scales)

genre_colors <- c(Horror = "#e11d48", Comedy = "#e0a100",
                  Action = "grey65", Adventure = "grey65", Drama = "grey65")

movies <- read_csv("data/movie_profit.csv", show_col_types = FALSE, name_repair = "minimal") |>
  select(-1) |>
  filter(genre %in% names(genre_colors)) |>
  distinct(movie, release_date, .keep_all = TRUE) |>
  mutate(
    date = as.Date(release_date, "%m/%d/%Y"),
    year = as.integer(format(date, "%Y")),
    month = as.integer(format(date, "%m")),
    return_ratio = worldwide_gross / production_budget
  ) |>
  filter(worldwide_gross > 0)

theme_fear <- function() {
  theme_minimal(base_size = 13) +
    theme(legend.position = "none")
}

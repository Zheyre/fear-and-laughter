library(dplyr)
library(readr)
library(ggplot2)
library(scales)

genre_colors <- c(Horror = "#e11d48", Comedy = "#f5c451",
                  Action = "#5b4f50", Adventure = "#5b4f50", Drama = "#5b4f50")

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
  theme_minimal(base_size = 14) +
    theme(
      plot.background = element_rect(fill = "#0d0a0b", color = NA),
      panel.background = element_rect(fill = "#0d0a0b", color = NA),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "#2a1f20"),
      text = element_text(color = "#efe6d2"),
      axis.text = element_text(color = "#cfcfcf"),
      plot.title = element_text(face = "bold", size = 20, family = "serif"),
      plot.title.position = "plot",
      plot.subtitle = element_text(color = "#bdbdbd"),
      plot.caption = element_text(color = "#8a8a8a"),
      legend.position = "none"
    )
}

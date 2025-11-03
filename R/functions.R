# Functions
# plot_billDepth_v_billLength <- function(data, selected_species, selected_island) {
#   # Filter the data for the selected species and island
#   filtered_data <- data |>
#     na.omit() |>
#     dplyr::filter((species == selected_species) & (island == selected_island))
#
#   min_depth <- min(filtered_data$bill_depth_mm, na.rm = TRUE)
#   max_depth <- max(filtered_data$bill_depth_mm, na.rm = TRUE)
#   min_length <- min(filtered_data$bill_length_mm, na.rm = TRUE)
#   max_length <- max(filtered_data$bill_length_mm, na.rm = TRUE)
#
#   # Create scatterplot
#   p <- ggplot2::ggplot(filtered_data, ggplot2::aes(
#     x = bill_length_mm, y = bill_depth_mm
#   )) +
#     ggplot2::geom_point() +
#     ggplot2::xlim(min_length, max_length) +
#     ggplot2::ylim(min_depth, max_depth) +
#     ggplot2::labs(
#       x = "Bill Length (mm)",
#       y = "Bill Depth (mm)",
#       title = paste0(
#         "Species: ", selected_species
#         ),
#       subtitle = paste0("Island: ", selected_island)
#     ) +
#     ggplot2::theme_bw() +
#     ggplot2::theme(
#       plot.title = ggplot2::element_text(hjust = 0, size = 10),
#       plot.subtitle = ggplot2::element_text(hjust = 0, size = 8)
#     )
#
#   return(p)
# }

plot_depth_v_length_by_species <- function(data, selected_species,
                                           color, xrange, yrange) {
  filtered_data <- data |>
    na.omit() |>
    dplyr::filter(species == selected_species)

  # Create scatterplot
  p <- ggplot2::ggplot(filtered_data, ggplot2::aes(
    x = bill_length_mm, y = bill_depth_mm
  )) +
    ggplot2::geom_point(color = color) +
    ggplot2::xlim(xrange[1], xrange[2]) +
    ggplot2::ylim(yrange[1], yrange[2]) +
    ggplot2::geom_smooth(formula = y ~ x, method = "lm", se = FALSE,
                         color = "darkgray", linewidth = 1) +
    ggplot2::labs(
      x = "Bill Length (mm)",
      y = "Bill Depth (mm)",
      title = paste0(
        "Species: ", selected_species
      )
    ) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(color = "#003478", hjust = 0,
                                         size = 10, face = "bold"),
      axis.title.x = ggplot2::element_text(color = "#747678", size = 8),
      axis.title.y = ggplot2::element_text(color = "#747678", size = 8)
    )

  r <- stats::cor(x = filtered_data$bill_length_mm, y = filtered_data$bill_depth_mm,
                  method = "pearson", use = "pairwise.complete.obs")
  r2 <- formatC(r^2, format = "f", digits = 3)

  my.objects <- list(p = p, r2 = r2)

  return(my.objects)
}

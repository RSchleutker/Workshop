## @knitr Visualization ----

#' Visualize the lines data as a barchart. Maps species on the x-axis and the
#' corresponding quotients of the epithelium width and radius as well as the
#' standard deviation on the y-axis.

library(ggplot2)

Lines$Plot <- ggplot(Lines$Analysis_Full, aes(Species, Mean_QuotientEpiRad)) +
  geom_bar(stat = "identity",
           position = position_identity(),
           width = .75) +
  geom_errorbar(mapping = aes(ymin = Mean_QuotientEpiRad - SD_QuotientEpiRad, ymax = Mean_QuotientEpiRad + SD_QuotientEpiRad),
                width = .25,
                size = .5) +
  scale_y_continuous(name = "Quotient") +
  labs(title = "Lines",
       subtitle = "Quotient of epithelium width and radius of tubuli.") +
  theme_gray(base_size = 9)


Lines$Plot


## @knitr Save_Plot ----

#' Saves the previously created plot as a PDF file.

ggsave("./Results/Lines.pdf",
       plot = Lines$Plot,
       width = 80,
       height = 50,
       units = "mm")
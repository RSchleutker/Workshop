## @knitr Calculate_Statistics_Of_Lines_Data -----

#' Calculate statistics of the diameter data. The data is first grouped by the
#' species, the BirdID, and the Group. Afterwards, all important values are
#' calculated. The calculated data is a new entry of the list.

Lines$Diameter_Analysis <- Lines$Diameter %>%
  group_by(Species, BirdID, Group) %>%
  summarise(n_Diameter = n(),
            Mean_Diameter = mean(`Length [um]`),
            SD_Diameter = sd(`Length [um]`),
            SE_Diameter = SD_Diameter/sqrt(n_Diameter),
            Mean_Radius = Mean_Diameter/2,
            SD_Radius = sd(`Length [um]`/2),
            SE_Radius = SD_Radius/sqrt(n_Diameter),
            Mean_Area = Mean_Radius^2*pi,
            SD_Area = sd((`Length [um]`/2)^2*pi),
            SE_Area = SD_Area/sqrt(n_Diameter))



Lines$WidthEpithelium_Analysis <- Lines$`Width Epithelium` %>%
  group_by(Species, Measured, BirdID, Group) %>%
  summarise(n_EpiWidth = n(),
            Mean_EpiWidth = mean(`Length [um]`),
            SD_EpiWidth = sd(`Length [um]`),
            SE_EpiWidth = SD_EpiWidth/sqrt(n_EpiWidth))



Lines$Analysis_Full <- full_join(Lines$Diameter_Analysis, Lines$WidthEpithelium_Analysis,
                                 by = c("Species", "BirdID", "Group")) %>%
  mutate(QuotientLength = Mean_EpiWidth/Mean_Radius) %>%
  mutate(AreaLumen = (Mean_Radius-Mean_EpiWidth)^2*pi) %>%
  mutate(AreaEpi = Mean_Area - AreaLumen) %>%
  mutate(QuotientArea = AreaEpi/Mean_Area) %>%
  group_by(Species) %>%
  summarise(n = n(),
            Mean_QuotientEpiRad = mean(QuotientLength),
            SD_QuotientEpiRad = sd(QuotientLength),
            Mean_QuotientArea = mean(QuotientArea),
            SD_QuotientArea = sd(QuotientArea))

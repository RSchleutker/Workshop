#' Adding a Year column to make it possible to combine three columns to a full
#' date.

library(tidyr)
library(dplyr)

AirqualityDirty <- airquality %>%
  mutate(Year = 1973)


#' Combining the last three columns to get a valid date.

AirqualityTidy <- AirqualityDirty %>%
  unite(Date, Day, Month, Year, sep = "-")

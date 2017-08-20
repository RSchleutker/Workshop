#' Create an untidy dataframe basing on the myeloid data from the survival
#' package. The last three columns are gathered.

library(tidyr)
library(dplyr)

MyeloidSpread <- survival::myeloid %>%
  gather("Type", "Days", txtime:rltime) %>%
  arrange(id)


#' In order to tidy the data the last two columns are spreaded.

MyeloidTidy <- MyeloidSpread %>%
  spread(Type, Days, convert = TRUE)

#' Read in the tumor dataset- The values are separated by semicolons instead of
#' commas, so have to assigned explicitly.

library(readr)

Tumor_Raw <- read_delim("./Exercises/Tumor/Tumor.csv",
                        ";", trim_ws = TRUE)



#' Split up the 'Age/Gender' column into two separate columns to make it easier
#' to assess the data for each variable apart from the other.

library(tidyr)
library(dplyr)


Tumor <- Tumor_Raw %>%
  separate(`Age/Gender`, c("Age", "Gender"), convert = TRUE)

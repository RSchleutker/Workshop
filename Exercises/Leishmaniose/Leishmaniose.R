#' Read in the Leishamniosa dataset with readr. The year columns countain
#' character data ('No Data') indicating not available data. Thus it is
#' explicitly imported as double datatype marking the 'No Data' cells
#' automatically as NA.

library(readr)

Leishmaniose_Raw <- read_csv("./Exercises/Leishmaniose/Leishmaniose.csv",
                             col_types = cols(`2005` = col_double(),
                                              `2006` = col_double(), `2007` = col_double(),
                                              `2008` = col_double(), `2009` = col_double(),
                                              `2010` = col_double(), `2011` = col_double(),
                                              `2012` = col_double(), `2013` = col_double(),
                                              `2014` = col_double(), `2015` = col_double(),
                                              `2016` = col_double()),
                             skip = 1)


#' The year columns are brought into a long form by creating two new columns: 
#' 'Year' indicates the respective year whereas 'Cases' indicates the respective
#' reported cases. Furthermore, the country column is changed to factor type.

library(tidyr)
library(dplyr)

Leishmaniose <- Leishmaniose_Raw %>%
  gather("Year", "Cases", 2:13) %>%
  mutate(Country = factor(Country, levels = unique(Country)))

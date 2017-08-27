## @knitr Processing_Helper_Function ----

#' Creates function to process lines data. Works only when the Data argument is
#' a list with the appropriate dataframe as a list element. The function uses
#' the names of the named list passed in to assign the BirdID and the Species
#' variables to the dataframes. It also adds a column indicating what was
#' actually measured. This information was previously not provided by the
#' dataframe itself.

Process_Line_Data <- function(Data) {
  require(stringr)
  require(dplyr)
  
  Names = names(Data)
  Split = unlist(str_split(Names, "_"))
  Times = nrow(Data[[1]])/6
  
  Data <- Data[[1]] %>%
    mutate(Measured = rep(c("Diameter", "Diameter", "Width Epithelium", "Width Epithelium", "Width Epithelium", "Width Epithelium"),
                          times = Times)) %>%
    mutate(Group = rep(1:Times, each = 6)) %>%
    mutate(BirdID = Split[2]) %>%
    mutate(Species = Split[1]) %>%
    mutate(File = Names[[1]]) %>%
    select(-Name) %>%
    list()
  
  return(Data)
}


## @knitr Reading_and_Processing_Lines_Data ----

#' The following lines read in and process the lines data. For this, the 
#' appropriate files are first listed as a character vector. Each element is 
#' named with the file name and read in by mapping over the character vector. 
#' The resulting named list of dataframes is processed. Since the names metadata
#' is used for the processing, lmap() is used. The dataframes are then bound to
#' one dataframe and splitted by the measured variable.

library(readr)
library(dplyr)
library(purrr)

Lines <- list.files("./Data/", pattern = "[^_]*_[^_]*_[^_]*_Lines.csv") %>%
  setNames(make.names(.)) %>%
  map(~ read_csv(paste("./Data/", .x, sep = ""), comment = "#")) %>%
  lmap(~ Process_Line_Data(.x)) %>%
  bind_rows() %>%
  split(.$Measured)

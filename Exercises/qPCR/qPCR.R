#' Read in the CSV files from the given folder, bind the rows together, and
#' process the data as is usual for qPCR data according to the ddCt method.

library(readr)
library(tidyr)
library(dplyr)
library(stringr)

qPCR <- list.files("./Exercises/qPCR/", pattern = "^[Plate]") %>%
  map(~ read_delim(paste("./Exercises/qPCR/", .x, sep = ""), ";", comment = "#", trim_ws = TRUE)) %>%
  bind_rows() %>%
  select(1:3, Ct) %>%
  rename(Target = `Target Name`) %>%
  separate(`Sample Name`, c("Duration", "Treatment"), sep = " ") %>%
  group_by(Duration, Treatment) %>%
  mutate(dCt = Ct - Ct[Target == "RPL3"]) %>%
  group_by(Target, Treatment) %>%
  mutate(ddCt = dCt - dCt[Duration == "0h"]) %>%
  ungroup() %>%
  mutate(RQ = 2^(-ddCt)) %>%
  dplyr::filter(Target != "RPL3") %>%
  arrange(Target, Treatment)

write.csv(qPCR, "./Exercises/qPCR/qPCR_Processed.csv", row.names = FALSE)

#' Visualize the previously calculated values with a simple bar chart.

library(ggplot2)

ggplot(qPCR, aes(Duration, RQ, fill = Treatment)) +
  geom_bar(position = position_dodge(width = .75),
           stat = "identity",
           width = .5) +
  facet_wrap(~ Target, scales = "free_y") +
  theme_gray(base_size = 9)

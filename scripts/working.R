library(tidyverse)
library(janitor)


file <- "data/checked_processed_aw_corrections.csv"
dat <- read_csv(file, skip = 1) 

# note: 2019 values were made equal to 2018 values
file <- "data/Human development index (HDI).csv"
hdi <- read_csv(file) %>% clean_names() %>% select(-hdi_rank_2018)

hdi <- hdi %>% 
  pivot_longer(names_to = "year",
               values_to = "index",
               -country) %>% 
  mutate(year = as.numeric(str_remove(year, "x"))) %>% 
  filter(year > 2009) %>% 
  filter(country %in% dat$country)


length(unique(dat$country))
length(unique(hdi$country))

test <- merge(dat, hdi, by = c("country", "year"), all.x = TRUE)

test[is.na(test$index), c("country","year")]

file <- "data/test.csv"
write_csv(test, file)


data_dir <- "data/jif/"
jif_files <- fs::dir_ls(data_dir)


jif <- jif_files %>% 
  map_dfr(read_csv)
names(jif)[2] <- "journal"

test <- merge(dat, jif, by = c("journal", "year"), all.x = TRUE)

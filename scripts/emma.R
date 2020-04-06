# Emma - analysis
# packaes needed
library(tidyverse)

# this sets your working directory to the location of emma.R
# all the other file paths are given relative to this script
here::here()


# import
# character values will be read as character datatypes rather than factors
# which makes processing easier in the first instance
# note: last record contained no info except: 
#     "compares different papers on bone marrow MSCs, 
#     doesn't say anything about prep of cells"
#   This was deleted (perhaps it belongs on another line?)

dat <- read.csv("../data/Data Tab copy v1.csv", stringsAsFactors = FALSE)

# column indices for markers
firstmarker <- which(colnames(dat) == "CD73")
lastmarker <- which(colnames(dat) == "SSEA.4")
# vector of marker names
markers <- names(dat[firstmarker:lastmarker])

datnum <- dat %>% 
  select(markers) %>% 
  mutate_all(list(num = ~ as.numeric(.))) 

# do the same for binary coding: 0 or 1

dat <- cbind(dat, datnum[,24:46])
dat$Stem.Stromal <- factor(dat$Stem.Stromal)
dat$Year <- factor(dat$Year)

# stacked - my preference
ggplot(data = dat, aes(x = Year, fill = Stem.Stromal)) +
  geom_bar(colour = "black") +
  theme_classic() +
  ylab("Frequency") +
  xlab("Year")

              
# besides data summary
datsum <- dat %>% 
  group_by(Stem.Stromal, Year, .drop = FALSE) %>% 
  summarise(n = length(Ref..))
  
# besides
ggplot(data = datsum, aes(x = Year, y = n, fill = Stem.Stromal)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  theme_classic() +
  ylab("Frequency") +
  xlab("Year")

table(dat$Phase)
ggplot(data = dat, aes(x = Phase, fill = Stem.Stromal)) +
  geom_bar(colour = "black") +
  theme_classic() +
  ylab("Frequency") +
  xlab("Phase")

datnum2 <- datnum %>% 
  select(ends_with("_num")) %>% 
  gather(key = marker, value = value)
datnum2$phase <- dat$Phase
datnum2$source <- dat$Source
datnum2$phase <- factor(datnum2$phase)
datnum2$marker <- factor(datnum2$marker)
datnum2$source <- factor(datnum2$source)
ggplot(data = datnum2, aes(x = phase, fill = marker)) +
  geom_bar(colour = "black") +
  theme_classic() +
  ylab("Frequency") +
  xlab("Phase")

datnum2$Ref <- dat$Ref..
ggplot(data = datnum2, aes(x = marker, y = Ref)) +
  geom_tile(aes(fill=value)) +
  theme_classic() +
  ylab("ref") +
  xlab("marker")

#
summary(datnum2$value)
datnum2 %>% 
  filter(!is.na(value)) %>% 
ggplot(aes(x = marker, y = value, colour = source)) +
#  geom_boxplot() +
  geom_jitter(width = .3) +
  theme_classic() +
  ylab("value") +
  xlab("marker")


# is there a link between term used and MOA
table(dat$MOA)
table(dat$Stem.Stromal)
tab <- table(dat$MOA, dat$Stem.Stromal)
chisq.test(tab)

dat <- dat %>%
  mutate(MOA2 = recode_factor(MOA,
                              `differentiation` = "differentiation",
                              `?` = "unknown",
                              `NS` = "unknown",
                                .default = "other"))
table(dat$MOA2)
table(dat$Stem.Stromal)
tab <- table(dat$MOA2, dat$Stem.Stromal)
chisq.test(tab)



data.frame(
  parts = factor(rep(month.abb[1:3], 3), levels=month.abb[1:3]),
  vals = c(10, 20, 30, 6, 14, 40, 30, 20, 10),
  col = rep(c("blue", "black", "red"), 3),
  fct = c(rep("Thing 1", 3),
          rep("Thing 2", 3),
          rep("Thing 3", 3))
) -> xdf

xdf %>%
  count(parts, wt = vals) %>%
  ggplot(aes(fill = parts, values = n)) +
  geom_waffle(n_rows = 20, size = 0.33, colour = "white", flip = TRUE) +
  scale_fill_manual(
    name = NULL,
    values = c("#a40000", "#c68958", "#ae6056"),
    labels = c("Fruit", "Sammich", "Pizza")
  ) +
  coord_equal() +
  theme_ipsum_rc(grid="") +
  theme_enhance_waffle()

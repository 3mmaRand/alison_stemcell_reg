stages <- tibble(
  clicks = 1,
  signups = .47,
  cart = .09,
  buys = .05
) %>%
  gather(stage, percent)

stages
to_poly <- stages %>%
  arrange(percent) %>%
  mutate(
    group = row_number(),
    x1 = 0 + ((1 - percent)/2),
    x4 = percent + ((1 - percent)/2),
    x2 = lag(x1), 
    x3 = lag(x4)
  ) %>%
  mutate(
    x2 = ifelse(is.na(x2), x1, x2),
    x3 = ifelse(is.na(x3), x4, x3)
  ) %>%
  gather(key = xpoint, value = x, -stage,-group, -percent) %>%
  arrange(group, xpoint) %>%
  mutate(y = ifelse(xpoint %in% c("x2", "x3"), group, group + 1))

to_poly

#########################
orig <- data.frame(step_names = c("mesenchymal",
                                  "article",
                                  "cell tissue etc",
                                  "clinical etc",
                                  "not biotech etc"),
                   n = c(65706,
                         47031,
                         7814,
                         5502,
                         2055))

orig$step_names <- fct_relevel(orig$step_names,
                               "mesenchymal",
                               "article",
                               "cell tissue etc",
                               "clinical etc",
                               "not biotech etc")
# prep polygons that connect
to_poly_orig <- orig %>%
  arrange(n) %>%
  mutate(
    group = row_number(),
    x1 = 0 + ((1 - n)/2),
    x4 = n + ((1 - n)/2),
    x2 = lag(x1), 
    x3 = lag(x4)) %>%
  mutate(
    x2 = ifelse(is.na(x2), x1, x2),
    x3 = ifelse(is.na(x3), x4, x3)
  ) %>%
  gather(xpoint, x, -step_names,-group, -n) %>%
  arrange(group, xpoint) %>%
  mutate(y = ifelse(xpoint %in% c("x2", "x3"), group, group + 1))


# EXAMPLE
# Create the placement of the stages in the plot,
#  by just adding a 0.5 to each row number

labels <- orig %>%
  arrange(n) %>%
  mutate(y = row_number() + 0.5)

cbPalette <- brewer.pal(6,"Blues")

to_poly_orig %>%
  ggplot() +
  geom_polygon(aes(x,
                   y,
                   group = group,
                   fill = step_names)) +
  geom_text(aes(x = 0.5,
                y = y,
                label = n),
            data = labels, size = 3) +
  scale_y_continuous(breaks = labels$y,
                     labels = labels$step_names) +
  theme_minimal() +
  theme(
    legend.position = "none", 
    axis.title = element_blank(), 
    axis.text.x = element_blank(), 
    axis.ticks.x = element_blank(), 
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(), 
    panel.grid.minor.y = element_blank()) +
  scale_fill_manual(values = cbPalette)

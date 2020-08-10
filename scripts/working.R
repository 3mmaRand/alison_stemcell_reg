
# empty

route_bar <- summary_route %>% 
  ggplot(aes(x = reorder(route, n), y = n)) +
  geom_bar(stat = "identity", 
           # fill = pal[4],
           fill = "black",
           size = 0, 
           width = 0.8) +
  xlab("") +
  #  geom_text(aes(y = n + 3, label = pc) ) +
  scale_y_continuous(name = NULL, 
                     breaks = seq(0, 25, 5),
                     minor_breaks = seq(0, 25, 1),
                     limits = c(0, 25),
                     expand = c(0, 0)) +
  scale_x_discrete(expand = c(0, 0)) +
  theme_classic() +
  theme(axis.title.y = element_blank(),
        axis.text.x = element_text(size = 8, colour = "black"),
        axis.ticks.y = element_blank(),
        axis.text.y  = element_text(size = 8, colour = "black"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        plot.title = element_text(hjust = 0, size = 4))



library(showtext)
## Loading Google fonts (https://fonts.google.com/)
font_add_google("Gochi Hand", "gochi")
font_add_google("Schoolbell", "bell")
font_add_google("Schoolbell", "Schoolbell")
font_add_google("Coming Soon", "Coming Soon")
font_add_google("Architects Daughter", "Architects Daughter")
font_add_google("Pangolin")

## Automatically use showtext to render text
showtext_auto()
p <- route_bar +
  annotate("text", 
           x = 4, 
           y = 10, 
           label = "Gochi Hand", 
           family = "gochi", 
           size = 10, 
           colour = "#f88f88") +
  geom_curve(aes(x = 3.5, 
                 xend = 4.5, 
                 y = 8, 
                 yend = 4), 
             curvature = 0.4, 
             size = 2,
             arrow = arrow(length = unit(0.0175, "npc")),
             colour = "#6eb4e9") +
  annotate("text", 
           x = 6, 
           y = 12, 
           label = "Schoolbell", 
           family = "Schoolbell", 
           size = 10, 
           colour = "#f88f88") +
  annotate("text", 
           x = 8, 
           y = 15, 
           label = "Coming Soon", 
           family = "Coming Soon", 
           size = 10, 
           colour = "#f88f88") +
  annotate("text", 
           x = 8, 
           y = 18, 
           label = "Architects Daughter", 
           family = "Architects Daughter", 
           size = 10, 
           colour = "#f88f88") +
  annotate("text", 
           x = 8, 
           y = 21, 
           label = "Pangolin", 
           family = "Pangolin", 
           size = 10, 
           colour = "#f88f88")
x11()
print(p)



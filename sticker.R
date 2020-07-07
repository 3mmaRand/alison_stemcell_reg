library(hexSticker)
library(tidyverse)
library(png)
library(grid)
library(ggimage)
img <- "image.png"

# border 95AAD3
# 


sticker(img, package = "MSC-CT",
        p_size=25, 
        p_x = 1,
        p_y = 1.5,
        p_color = "#22A884",
        h_fill = "white",
        h_color = "#440154",
        s_x = 1, s_y = 0.8,
        asp = 0.85,
        s_width = .6,
        filename="hex.png")

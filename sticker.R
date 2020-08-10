library(hexSticker)
library(tidyverse)
library(png)
library(grid)
library(ggimage)
img <- "image.png"

# border 95AAD3
# 

apname <- "CIDMap"
sticker(img, package = apname,
        p_size = 20, 
        p_x = 1,
        p_y = 1.55,
        p_color = "#22A884",
        h_fill = "white",
        h_color = "#440154",
        s_x = 1, s_y = 0.9,
        asp = 0.85,
        s_width = .6,
        filename = "hex.png",
        url = "https://shiny.york.ac.uk/er13/CIDMap",
        u_color = "#22A884",
        u_size = 4.5,
        u_y = 0.080,
        u_x = 0.97)

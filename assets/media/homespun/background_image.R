# 
# library(dplyr); library(ggplot2); library(tidyr)
# 
# remotes::install_github("djnavarro/jasmines")

library(jasmines); library(dplyr); 

# to see list of available palettes
#palette_named() #scico palettes

use_seed(208) %>%
  scene_grid(
    xpos = 1:21,
    ypos = 1:7,
    entity = "gaussian",
  ) %>%
  mutate(ind = 1:n()) %>%
  # unfold_warp(
  #   iterations = 1,
  #   scale = .5, 
  #   output = "layer" 
  # ) %>%
  unfold_tempest(
    iterations = 20,
    scale = .01
  ) %>%
  style_ribbon(
    palette = palette_named("hawaii"),
    #palette = my_pal, 
    colour = "ind",
    alpha = c(.1,.1),
    background = "transparent"
  ) -> p

export_image(p, "assets/media/homespun/test.png", height = 4, width = 9, dpi = 150)


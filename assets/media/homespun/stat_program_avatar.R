
library(ggplot2); library(dplyr); library(maps)
library(wesanderson)

map_id <- map('county', 'idaho', plot = FALSE, fill = TRUE)

lat <- tibble(lat = seq(map_id$range[3], map_id$range[4], by = .22))
long <- tibble(long = seq(map_id$range[1], map_id$range[2], by = .3))
dots <- lat %>% 
  merge(long, all = TRUE)

dots <- dots %>% mutate(country = map.where(map_id, long, lat)) %>% 
  filter(!is.na(country)) 

#cols <- terrain.colors(20)
cols = wes_palette("Zissou1", 10, type = "continuous")


# star trek avatar

ggplot(data = dots, aes(x = long, y = lat)) +   
  geom_point(color = sample(cols, nrow(dots), replace = TRUE), 
             size = 6, alpha = 1, shape = 15) +
  theme_void() +
  coord_map() + 
  theme(plot.margin = unit(c(1.5, 2.5, 1.5, 2.5), "cm")) 

ggsave("assets/media/homespun/avatar_color.png", height = 11, width = 11, 
       bg = "transparent")

# Black and green avatar (not used)
# cols_bw = gray(seq(.2, 0.7, by = 0.1))
# ggplot(data = dots, aes(x = long, y = lat)) +   
#   geom_point(fill = sample(cols_bw, nrow(dots), replace = TRUE), 
#              size = 6, alpha = 1, shape = 21, color = "green1") +
#   theme_void() +
#   coord_map() + 
#   theme(panel.background = element_rect(fill = "grey15"),
#         plot.margin = unit(c(0, 0, 0, 0), "cm")) 
# 
# ggsave("assets/media/homespun/avatar_bw.png", height = 7.3, width = 4.65)

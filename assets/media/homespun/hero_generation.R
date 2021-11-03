
library(ggridges); library(readxl); library(lubridate); 
library(dplyr); library(ggplot2); library(tidyr)


mydata2 <- read_excel("assets/media/homespun/environmental_data.xlsx") %>% 
  mutate(month = month(DateTime, label = TRUE), 
         year = as.character(year(DateTime)), 
         week = as.factor(week(DateTime)))


ggplot(mydata2, aes(x = nmpi_mn, y = week)) +
  geom_density_ridges(scale = 7, rel_min_height = .001,
                      fill = "cyan", color = "transparent", alpha = 0.1) + 
  geom_density_ridges(scale = 7, rel_min_height = 0.001, size = .3,
                      fill = "transparent", color = "cyan") + 
  xlim(c(-10,75)) +
  theme_void() + 
  theme(panel.background = element_rect(fill = 'transparent', color = NA))
  

ggsave("assets/media/homespun/hero.png", width = 4, height = 6)
#goes in content/home
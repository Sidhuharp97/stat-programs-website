
library(ggplot2)

ui_cols <- c("#F1B300", "#181506", "#BBBEBA")
names(ui_cols) <- c("gold", "black", "gray")

idaho <- data.frame(color = c(rep("gold", 5), rep("black", 3), rep("gray", 2)),
                    row = c(1:5, 1:3, 1:2),
                    column = c(rep(1, 5), rep(2, 3), rep(3, 2))) 
 

ggplot(idaho, aes(y = row, x = column, fill = color)) +
  geom_tile(color = "white", lwd = 3.5) +
  guides(fill = "none") + 
  coord_equal() + 
  scale_fill_manual(values = ui_cols) +
  theme_void()

ggsave("assets/media/homespun/logo.png", bg = "white",
       height = 600*2, width = 337*2, units = "px")

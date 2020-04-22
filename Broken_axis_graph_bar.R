#画的条形图的断轴
library(ggplot2)
library(grid)

#读入作图数据
dat <- read.delim('abundance.txt', stringsAsFactors = F)

#ggplot2 绘图
bar_plot <- ggplot(dat, aes(taxonomy, value.mean, fill = group)) +
  geom_col(position = position_dodge(width=0.8)) +
  geom_errorbar(aes(ymin = value.mean - value.sd, ymax = value.mean + value.sd), width = 0.5, position=position_dodge(.8)) +
  labs(x = NULL, y = NULL) +
  scale_y_continuous(breaks=seq(0,90,5),labels = c(seq(0,90,5)))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.title = element_blank())

#ggsave('bar_plot.png', bar_plot, width = 8, height = 5)

#使用 coord_cartesian() 分割作图结果
split1 <- bar_plot + coord_cartesian(ylim = c(0, 4)) + 
  theme(legend.position='none',
        axis.line.y = element_line(),
        axis.line.x = element_line(),
        panel.background = element_rect(fill = "white"))
split2 <- bar_plot + coord_cartesian(ylim = c(4, 20)) +
  theme(axis.text.x = element_blank(), 
        axis.line.y = element_line(),
        axis.ticks.x = element_blank(), legend.position = 'none',
        panel.background = element_rect(fill = "white"))
split3 <- bar_plot + coord_cartesian(ylim = c(60, 90)) + 
  theme(axis.text.x = element_blank(), 
        axis.line.y = element_line(),
        panel.background = element_rect(fill = "white"),
        axis.ticks.x = element_blank(), legend.position = c(0.95, 0.7))

#使用 grid 包组合分割结果
png('bar_plot.split.png', width = 2500, height = 1700, res = 300, units = 'px')
grid.newpage()
plot_site1 <- viewport(x = 0.008, y = 0, width = 0.994, height = 0.4, just = c('left', 'bottom'))
plot_site2 <- viewport(x = 0, y = 0.4, width = 1, height = 0.3, just = c('left', 'bottom'))
plot_site3 <- viewport(x = 0, y = 0.7, width = 1, height = 0.3, just = c('left', 'bottom'))
print(split1, vp = plot_site1)
print(split2, vp = plot_site2)
print(split3, vp = plot_site3)
dev.off()

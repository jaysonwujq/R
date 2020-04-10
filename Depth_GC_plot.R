##Date:2020-4-10
##Purpose:画出深度与GC分布图
##输入文件格式如下
#seq_ID  seq_start       seq_end depth   GC      A       T       G       C
#1       10318520        10318760        1279.67 0.39    0.32    0.29    0.19    0.2
#1       10356924        10357164        1357.48 0.46    0.3     0.24    0.23    0.23

library(ggplot2)
#读取文件

depth_base <- read.delim("./res/TA202H0019-D2A7AA7XKF1-A003L000K946.csv")
#标准化一下
total <-sum(depth_base$depth)
depth_base$depth <-(depth_base$depth/total)*1000000
head(depth_base)
#统计平均 GC 含量（百分比）
GC_mean <- round(mean(depth_base$GC), 2)

#统计平均测序深度（百分比）
depth_mean <- round(mean(depth_base$depth), 2)
depth_base <- subset(depth_base, depth <= 3 * depth_mean)
bks<-pretty(range(depth_base$depth))
#depth 深度、GC 含量散点密度图
depth_GC <- ggplot(depth_base, aes(GC, depth)) +
  geom_point(color = 'gray', alpha = 0.6, pch = 19, size = 0.5)+
  geom_vline(xintercept = GC_mean, color = 'red', lty = 2, lwd = 0.5) + 
  geom_hline(yintercept = depth_mean, color = 'red', lty = 2, lwd = 0.5)+
  stat_density2d(aes(fill = ..density.., alpha = ..density..), geom = 'tile', contour = FALSE, n = 500)+
  scale_y_continuous(breaks = bks)+
  scale_fill_gradientn(colors = c('gray', 'yellow', 'red')) +
  theme(panel.grid.major = element_line(color = 'gray', linetype = 2, size = 0.25), panel.background = element_rect(color = 'black', fill = 'transparent')) +
  labs(x = paste('GC % (Average :', GC_mean, '%)'), y = paste('Depth (Average :', depth_mean, 'X)'),title =("X")) +
  theme(axis.text = element_text(size = 10)) +
  theme(axis.title = element_text(size = 12)) +
  theme(legend.position = 'none',
        plot.title = element_text(hjust = 0.5)
        )

#depth 深度直方密度图
depth_hist <- ggplot(depth_base, aes(depth)) +
  geom_histogram(binwidth = (max(depth_base$depth) - min(depth_base$depth))/100, fill = 'gray', color = 'gray40', size = 0.1) +
  geom_rug(color = 'gray', alpha = 0.6) +
  theme(panel.grid.major = element_line(color = 'gray', linetype = 2, size = 0.25), panel.background = element_rect(color = 'black', fill = 'transparent')) +
  theme(axis.line = element_line(color = 'black', size = 0.3), axis.text = element_text(size = 10), axis.title = element_text(size = 12)) +
  labs(x = '', y = 'Numbers') +
  coord_flip() +
  geom_vline(xintercept = depth_mean, color = 'red', lty = 2, lwd = 0.5)

#GC 含量直方密度图
GC_hist <- ggplot(depth_base, aes(GC)) +
  geom_histogram(binwidth = (max(depth_base$GC) - min(depth_base$GC))/100, fill = 'gray', color = 'gray40', size = 0.1) +
  geom_rug(color = 'gray', alpha = 0.6) +
  theme(panel.grid.major = element_line(color = 'gray', linetype = 2, size = 0.25), panel.background = element_rect(color = 'black', fill = 'transparent')) +
  theme(axis.line = element_line(color = 'black', size = 0.3), axis.text = element_text(size = 10), axis.title = element_text(size = 12)) +
  labs(x = '', y = 'Numbers') +
  geom_vline(xintercept = GC_mean, color = 'red', lty = 2, lwd = 0.5)

png(paste("PB202J0032-C5C7AA7XKF1-A001L000", 'png', sep = '.'), width = 4000, height = 4000, res = 600, units = 'px')
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(3, 3)))
  print(depth_GC, vp = viewport(layout.pos.row = 2:3, layout.pos.col = 1:2))
  print(GC_hist, vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
  print(depth_hist, vp = viewport(layout.pos.row = 2:3, layout.pos.col = 3))
dev.off()

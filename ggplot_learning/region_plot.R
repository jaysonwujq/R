dat <-read.csv("EconomistData.csv")

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pc2<-ggplot(dat,aes(x=CPI,y=HDI,color=Region))+
  geom_smooth(mapping = aes(linetype="r2"),method = "lm",formula = y~x+log(x),se=FALSE,color="red")+
  geom_point(shape=1,size=2.5,stroke=1.25)+
  theme_minimal()+
  #添加需要的标签
  geom_text(aes(label = Country),color="gray20",data=subset(dat,Country %in% pointsToLabel))+
  scale_y_continuous(name = "Human development Index",breaks=seq(0,1,0.1),limits = c(0.2,1))+
  scale_x_continuous(name = "Corruption Perception Index",limits = c(1,10),breaks = seq(1,10,1))+
  theme(
    legend.position="top",
    legend.title = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    text = element_text(family = "Times New Roman",face = "italic"),
    axis.line.x = element_line(color="gray",size = 0.5),
    axis.ticks.x=element_line(color="gray",size = 0.3)
  )

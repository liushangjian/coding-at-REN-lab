d3 = read.table("C:/Users/11967/Desktop/Raman 20210119/20210119-532lshj/graphene-glass14-bl.txt", 
               sep="\t", 
               col.names=c("Raman Shift", "intensity"), 
               fill=FALSE, 
               strip.white=TRUE)
ggplot(data = d3, mapping = aes(d3$Raman.Shift, d3$intensity))+  
  geom_line()+
  labs(
    x = "Raman Shift (cm-1)",
    title="Glass-Graphene14-bl(t=120s,532nm)",
    y = "Inthensity (a.u.)")+    ## 添加标记
  
  
  xlim(800,3400)+
  ylim(-500,10000)+
  theme(
    panel.background = element_rect(fill = "transparent",colour = NA),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank())#,
    #panel.border = element_blank())  ##这个可以去掉背景


d3 = read.table("C:/Users/11967/Desktop/Raman 20210119/20210119-532lshj/graphene-glass14-bl.txt", 
                sep="\t", 
                col.names=c("Raman Shift", "intensity"), 
                fill=FALSE, 
                strip.white=TRUE)
ggplot(data = d3, mapping = aes(d3$Raman.Shift, d3$intensity))+  
  geom_line()+
  labs(
    x = "Raman Shift (cm-1)",
    title="Glass-Graphene14-bl(t=120s,532nm)",
    y = "Inthensity (a.u.)")+    ## 添加标记
  
  
  xlim(800,3400)+
  ylim(-500,10000)+
  theme(
    panel.background = element_rect(fill = "transparent",colour = NA),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank())#,
#panel.border = element_blank())  ##这个可以去掉背景


d5<-d1[-c(1795:1884),]
d4<-data.frame(d3,d5$intensity)

d4<- d4 %>% 
     rename(
      Glass_graphene_light = intensity, 
      Glass_graphene_dark = d5.intensity
    )

md4<-melt(d4,id="Raman.Shift")
ggplot(data = md4, mapping = aes(md4$Raman.Shift, y=value, colour=variable))+  
  geom_line()+
  labs(
    x = "Raman Shift (cm-1)",
    title="Glass-Graphene14-bl vs Glass-Gel (t=120s,532nm)",
    y = "Inthensity (a.u.)")+    ## 添加标记
  
  
  xlim(800,3400)+
  ylim(-500,10000)+
  theme(
    panel.background = element_rect(fill = "transparent",colour = NA),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank())#,
#panel.border = element_blank())  ##这个可以去掉背景
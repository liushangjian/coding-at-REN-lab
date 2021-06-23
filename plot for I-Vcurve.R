
## this file for the graphics of I-V curve

library(ggplot2)
library(dplyr)
library(scales)
library(RColorBrewer)

steps=5
steplen=0.5

## getting the path
pathname<-"C:/Users/11967/Desktop/daliydrive/I-V CURVE/device0525/"
filename<-"I_V Sweep212021_5_25 10_44_29.csv"
theurl<-paste(pathname,filename,sep="")
print(theurl)


## getting the data
ivcurve1<-read.csv(theurl,header=FALSE,sep=",")
ivcurve<-ivcurve1[228:1232,]
colnames(ivcurve)<-c("DataName","Vg","V3","I1","I3")
ivcurve <- as.data.frame(sapply(ivcurve[,2:5], as.numeric))

## drawing
## col1<-palette(rainbow(6))

## https://stackoverflow.com/questions/26508519/how-to-add-elements-to-a-list-in-r-loop

## 这个将怎么样配色的地方也非常专业 https://ggplot2-book.org/scale-colour.html






## here know as.factor https://stackoverflow.com/questions/43359050/error-continuous-value-supplied-to-discrete-scale-in-default-data-set-example
picture2<-ggplot(data = ivcurve, aes(x=Vg, y=I3*1000,color=as.factor(V3),group=as.factor(V3))) +  
  geom_smooth(se=FALSE)+
  scale_color_manual(values = brewer.pal(5, "YlOrRd")) #brewer.pal(5, "RdYlBu")
#  scale_color_manual(values = brewer.pal(5, "Set1")) 
picture2<-
  picture2+labs(
    x = "Vg(V)",
    title="graphene FET I-V curve",
    y = "I(mA)",
    color="V_DS(V)")    ## 添加标记
picture2<-picture2+theme_bw()

ggsave("figure21.tiff",path = "C:/Users/11967/Desktop/daliydrive/I-V CURVE/figures/",device='tiff',dpi = 100)


### 后面的代码都很傻，但是不舍得删掉了

col1<-brewer.pal(steps, "BrBG")
##这个函数很关键，用来在一个给定的色卡里面取出一定数量的颜色

curvelist<-list()
for(i in 1:steps)
{
  curvelist[[i]]<-as.data.frame(ivcurve[ivcurve$V3==steplen*(i-1),])
}
## curvelist<-split.data.frame(ivcurve,ivcurve$V3)
names(curvelist)<-paste0('curve',1:steps)

ggplot(data = as.data.frame(curvelist[[1]]), aes(x=curvelist$curve1$Vg, y=curvelist$curve1$I3)) + geom_line(aes(colour=col1[1]))
+geom_line(as.data.frame(curvelist[[2]]),aes(x=curvelist$curve2$Vg, y=curvelist$curve2$I3),colours(col1[2]))


curve<-ivcurve[ivcurve$V3==0,]
picture<-ggplot(data = curve, aes(x=curve$Vg, y=curve$I3)) + geom_smooth(aes(color=hue_pal()(5)[1]))

picture<-picture+
  labs(
    x = "Vg(V)",
    title="graphene FET I-V curve",
    y = "I(mA)")    ## 添加标记

curve2<-ivcurve[ivcurve$V3==0.5,]
picture<-picture+geom_smooth(data = curve2,aes(x=curve2$Vg,y=curve2$I3,color=hue_pal()(5)[2]))

curve3<-ivcurve[ivcurve$V3==1.0,]
picture<-picture+geom_smooth(data = curve3,aes(x=curve3$Vg,y=curve3$I3,color=hue_pal()(5)[3]))

curve4<-ivcurve[ivcurve$V3==1.5,]
picture<-picture+geom_smooth(data = curve4,aes(x=curve4$Vg,y=curve4$I3,color=hue_pal()(5)[4]))

curve5<-ivcurve[ivcurve$V3==2.0,]
picture<-picture+geom_smooth(data = curve5,aes(x=curve5$Vg,y=curve5$I3,color=hue_pal()(5)[5]))

picture<-picture+theme_bw()

picture<-picture+legend()

picture2<-picture2+scale_color_manual(values = col1)

for(i in 1:steps)
{
  ivcurve<-(ivcurve[ivcurve$V3==i*steplen,]$V3<-paste0((i-1)*steplen,"V"))
}   

for (i in (0:(steps-1))) 
{
  if(i==0)
  {
    curve<-ivcurve[ivcurve$V3==i*steplen,]
    ggplot(data = curve, mapping = aes(Vg, I3*1000))+  
      geom_line(col=col1[1])+
      labs(
        x = "Vg(V)",
        title="graphene FET I-V curve",
        y = "I(mA)")    ## 添加标记
  }
  else
  {
     curve<-ivcurve[ivcurve$V3==i*steplen,]
     geom_line(aes(x=curve$Vg,y=curve$I3),col=col1[i+1])
  }
}

  picture2<-picture2+scale_fill_manual(values =  c('#f3a683', '#f7d794', '#778beb', '#e77f67', '#cf6a87'),
                                       labels=c('1','2','2','3','4'))
bars + scale_fill_brewer(values =  "Set1")
bars + scale_fill_brewer(palette = "Set2")
bars + scale_fill_brewer(palette = "Accent")
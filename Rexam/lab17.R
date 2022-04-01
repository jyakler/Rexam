library(dplyr)
library(ggplot2)
mpg<-as.data.frame(ggplot2::mpg)
library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")
#1
#plot(mpg$hwy~mpg$cty)
ggplot(mpg,aes(cty,hwy))+geom_point(color="blue")

#2
ggplot(mpg,aes(class,fill=drv))+geom_bar()

#3
data<-read.table("data/product_click.log")
data2<-table(data$V2)
V1=as.numeric(table(data$V2))
V2=names(table(data$V2))
df<-data.frame(V1,V2)

ggplot(df,aes(V2,V1,fill=V2))+geom_col()+labs(title="제품당 클릭수",
                                                          subtitle="제품당 클릭수를 바그래프로 표현",
                                              x="제품ID",
                                              y="클릭수")+
  theme_bw()

#4
library(treemap)
data("GNI2014")
treemap(GNI2014,index=c("continent","iso3"),vSize="population",
        title="전세계 인구정보",fontfamily.title="maple",
        border.col="green",fontsize.title=20)

dev.copy(png,"output/result4.png")
dev.off()
install.packages("showtext")
library(showtext)
showtext_auto() 
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

data<-read.table("data/product_click.log")

datat<-table(data$V2)
datat

barplot(datat,main="세로바 그래프 실습",col=terrain.colors(10),col.main="red",cex.main=2,xlab="상품ID",ylab="클릭수")

#그래프 저장
dev.copy(png,"output/clicklog1.png")
dev.off()

#2
data2<-table(substr(data$V1,9,10))
names(data2)<-sprintf("%d",as.numeric(names(data2)))
name1=paste(names(data2),"~",as.numeric(names(data2))+1)
pie(data2,col=rainbow(19),main="파이그래프 실습",family="maple",labels=name1)

dev.copy(png,"output/clicklog2.png")
dev.off()

#3
score<-read.table("data/성적.txt",header=T)
score1<-score[3:5]
rownames(score1)<-c(score$성명)
barplot(as.matrix(t(score1)),main="학생별 점수",col=topo.colors(3),family="maple",legend.text=T,cex.axis=0.7)

dev.copy(png,"output/clicklog3.png")
dev.off()
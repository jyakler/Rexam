library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")


data<-read.table("data/product_click.log",col.names=c("date","type"))
data
date_data<-substr(data$date,1,8)
date_data2=as.POSIXlt(date_data,format="%Y%m%d")
date_data2
date_data2<-weekdays(date_data2)

date_data2<-factor(date_data2,levels=c("월요일","화요일","수요일","목요일","금요일","토요일"))
par(mfrow=c(1,2))
plot(table(date_data2),type="o",family="maple",main="요일별 클릭 수",cex.main=3,col="yellow",
     xlab="",ylab="",ylim=c(0,300),lwd=3
     )

barplot(table(date_data2),main="요일별 클릭수",family="maple",cex.main=3,col=rainbow(6))

dev.copy(png,"output/clicklog4.png",width=800,height=600)
dev.off()


#2
movie_data<-read.csv("data/movie_reviews3.csv")

real_data<-movie_data$vpoint

par(mfrow=c(1,3),family="maple")
hist(real_data,main="영화 평점 히스토그램(auto)",col=heat.colors(10),xlab="평점",ylab="평가자수")
hist(real_data,main="영화 평점 히스토그램(1~5,6~10)",col=c("cyan","pink"),ylim=c(0,500),xlab="평점",ylab="평가자수",breaks=2)
#hist(real_data,main="영화 평점 히스토그램(1~5,6,7,8,9,10)",ylim=c(0,500),xlab="평점",ylab="평가자수",breaks=c(1,5,6,7,8,9,10),probability=F)
hist(real_data,main="영화 평점 히스토그램(1~5,6,7,8,9,10)",xlab="평점",ylab="평가자수",breaks=c(1,5,6,7,8,9,10),freq=T)
#hist(real_data,main="영화 평점 히스토그램(1~5,6,7,8,9,10)",xlab="평점",ylab="평가자수",breaks=c(1,5,6,7,8,9,10),probability=F)

dev.copy(png,"output/clicklog5.png",width=1200,height=400)
dev.off()
#3
par(mfrow=c(1,1))
one<-read.csv("data/one.csv")
one
one2<-sort(one$구별)
boxplot(one$X1인가구~one$구별,
        #data=one,
        las=2,col=topo.colors(26),ann=F)
title("구별 1인가구",col.main="orange")

dev.copy(png,"output/clicklog6.png")
dev.off()
#aggregate(one$X1인가구,by=list(one$구별),FUN=sum)

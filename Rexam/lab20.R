library(fmsb) 
library(ggplot2)
library(dplyr)

data<-read.csv("data/picher_stats_2017.csv",fileEncoding = "UTF-8")
View(data)
rdata<-data %>% select(선수명,승,패,홈런.9,삼진.9,볼넷.9)
ldata<-rdata %>% filter(선수명=="이민호") %>% select(-1)
max.score<-c(15,15,20,30,25)
min.score<-c(0,0,0,0,0)
ds<-rbind(max.score,min.score,ldata)
ds<-data.frame(ds)
colnames(ds)<-c("승","패","홈런","삼진","볼넷")

radarchart(ds,
           pcol="red",
           pfcol=rgb(0.4,0.2,0.1,0.3),
           cglcol="grey",
           cglty=3,
           seg=5,
           axistype=1,
           caxislabels = seq(0,15,3),
           title="이민호 선수의 성적")

dev.copy(png,"output/lab20.png")
dev.off()
#2
sd(iris$Sepal.Width)
mean(iris$Sepal.Width)
quantile(iris$Sepal.Width,0.75)
#2-2
hist(iris$Sepal.Width,xlab="Sepal.Width",ylim=c(0,35),main="꽃받침 너비")
#2-3
min1<-aggregate(iris[,'Sepal.Width'],by=list(iris$Species),FUN=min)


#2-4
max1<-aggregate(iris[,'Sepal.Width'],by=list(iris$Species),FUN=max)
new1<-full_join(max1,min1,by="Group.1")
new1<-mutate(new1,dif=x.x-x.y)
tb<-new1[c(-2,-3)]
tb
#2-5
iris %>% filter(Species=="virginica") %>% select(-5)->test
test
#2-6
cor(test)
plot(test)

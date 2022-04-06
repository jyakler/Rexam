library(tidyr)
library(dplyr)
library(ggplot2)

library(proxy)
library(tm)
library(qgraph)
library(SnowballC)

library(KoNLP)
useSejongDic()
library(jsonlite)
library(httr)
library(tm)
library(qgraph)

library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

#1
data<-read.csv("data/성적2.csv",sep=",",fileEncoding="UTF-8")
View(data)
old<-data
#2
newdata<-data[,3:4]
boxplot(newdata,range=1)
dev.copy(png,"output/result1.png")
dev.off()
mathmean<-newdata %>%  select(수학) %>% 
  filter(수학<=10 & 수학>=0&!is.na(수학))
mathmean<-mean(mathmean$수학,na.rm=T)%/%1
lanmean<-newdata %>%  select(국어) %>% 
  filter(국어<=10 & 국어>=0&!is.na(국어))
lanmean<-mean(lanmean$국어,na.rm=T)%/%1
#10넘는거 평균으로
data$수학 <-ifelse((data$수학)>10,mathmean,data$수학)
data$국어 <-ifelse((data$국어)>10,lanmean,data$국어)
View(data)
#3
data %>% fill(국어,수학,.direction="updown")->data
View(data)
# newdata %>% gather(key="과목",value="점수")->newdata
# ggplot(data=newdata)+geom_boxplot(aes(x=과목,y=점수))
#4
ggplot(data,aes(x=국어,y=수학,color=성명))+geom_point(size=3)
ggsave("output/result2.png")

#문제2
data2<-read.csv("data/reshapedata.csv",sep=",")
data2 %>% gather(key="exam",value="jumsu",-num,-name)->longdata
View(longdata)
longdata %>% spread(key="exam",value="jumsu")->widedata
View(widedata)

longdata %>% separate(exam,into=c('subname','subnum'))->result
View(result)

#문제3

듀크 <-"사과 포도 망고"
둘리 <-"포도 자몽 자두"
또치 <-"복숭아 사과 포도"
도우너 <-"오렌지 바나나 복숭아"
길동 <-"포도 바나나 망고"
희동 <-"포도 귤 오렌지"

설문<-c(듀크,둘리,또치,도우너,길동,희동)
cps<-VCorpus(VectorSource(설문))
DocumentTermMatrix(cps,control=list(wordLengths=c(1,Inf)))->dtm
as.matrix(dtm)->m

#1
m1<-m%*%t(m) 
dist(m1,diag=F,method="cosine") %>% min()->min

as.matrix(dist(m1,diag=F,method="cosine"))->newm
which(newm==min)->a
unique(a%%6)->a
n=c('듀크','둘리','또치','도우너','길동','희동')
for(i in a)
  cat(n[i]," ")

#2
sort(colSums(m)) %>% tail(1)
#3
sort(colSums(m)) %>% head(1)



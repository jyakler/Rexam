library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

#2014~2019 교통사고 데이터 읽어와서 원인간 연관성 찾기
#서울 전체 데이터 -seoul_data
#년도별 구별 사고 갯수 - year_acc2
#기상일 구분( 총 2191일)-weather
#밤사고 night 낮사고 day
raw_data<-read.table("2014_19acc.csv",sep=",",header=T)
View(raw_data)


#전처리 작업
library(dplyr)
raw_data %>% filter(발생지_시도=="서울")->seoul_data

seoul_data %>% mutate(년도=substr(seoul_data$발생일,1,4),발생월=substr(seoul_data$발생일,5,6))->seoul_data
seoul_data %>% group_by(발생지_시군구) ->data2;View(data2)

seoul_data %>% select(발생일,발생시간,발생지_시군구,사고유형_대분류,도로형태_대분류,
                         노면상태,기상상태)->acc1

seoul_data %>% select(발생일,발생시간,노면상태,기상상태,가해당사자종별,가해자성별,가해자연령,
                         가해자신체상해정도,피해당사자종별,피해자성별,피해자연령,피해자신체상해정도)->acc2



library(tidyr)
seoul_data %>%group_by(년도) %>% count(발생지_시군구)->year_acc;View(year_acc)
spread(year_acc,key=발생지_시군구,value=n)->year_acc2
year_acc2<-t(year_acc2)
colnames(year_acc2)<-c("2014","2015","2016","2017","2018","2019")

test<-seoul_data %>% select(발생일,기상상태)
test %>% group_by(발생일) %>% count(기상상태)->test2
test2 %>% select(기상상태)%>% group_by(기상상태) %>% count(기상상태)->weather

library(ggplot2)
library(plotly)
acc2 %>% filter(가해당사자종별!='자전거')->temp
age<- substr(temp$가해자연령,1,2)
age <-ifelse(age=="불명",NA,age)
age<-as.numeric(age)
#hist(age,breaks=100,col=rainbow(80),main="가해자 연령")
ggplot(data=data.frame(age),aes(x=age))+geom_histogram(bins=100,binwidth = 1,na.rm=T,fill=rainbow(90),
                                                       color="black")->g
ggplotly(g)
acc2 %>% filter(가해당사자종별=='자전거')->temp2
age2<-as.numeric(substr(temp2$가해자연령,1,2))
#age2<-substr(acc2$피해자연령,1,2)


#밤 사고율 분석 -유의미
acc2$발생시간<-as.numeric(substr(acc2$발생시간,1,2))
acc2 %>% filter(발생시간>=20 | 발생시간<4) ->night
acc2 %>% filter(4<=발생시간 & 발생시간<20) ->day
day %>% count(기상상태)
night %>% count(기상상태)

#그래프 만들기

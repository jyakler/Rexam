library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")
library(htmlwidgets)
library(htmltools)
#2014~2019 교통사고 데이터 읽어와서 원인간 연관성 찾기
#서울 전체 데이터 -seoul_data
#년도별 구별 사고 갯수 - year_acc2
#기상일 구분( 총 2191일)-weather
#밤사고 night 낮사고 day
register_google(key='AIzaSyCt0Oc-F_-g2KAhVvm7oEheSKzAhQoUMd0')
#사이트 https://www.its.go.kr/opendata/opendataList?service=event
api_key="a3d252ca4a3b4693889d4eb9bdf8e648"
library(ggmap)
library(mapproj)


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
year_acc2[-1,]->year_acc2
for(i in 1:6){
  as.numeric(year_acc2[,i])->year_acc2[,i]
}
data.frame(year_acc2)->year_acc2

#---------------------------------------------------------------------------------------------------------------------
#밤낮 사고율 분석
acc2$발생시간<-as.numeric(substr(acc2$발생시간,1,2))
acc2 %>% filter(발생시간>=20 | 발생시간<4) ->night
acc2 %>% filter(4<=발생시간 & 발생시간<20) ->day
day %>% count(기상상태)->nightw
night %>% count(기상상태)->dayw
time_weather<-inner_join(nightw,dayw,by='기상상태')
colnames(time_weather)<-c("기상상태","낮","밤")
gather(time_weather,key=day_night,value=value_t,-기상상태)->time_weather2
#바그래프 만들기
ggplot(time_weather2,aes(x=기상상태,y=value_t,fill=day_night))+ylab("사고수")+
  geom_bar(stat="identity",position=position_dodge())+
  scale_y_continuous(breaks = c(0,100,1000,10000,50000,150000),trans='log10')+
  geom_text(aes(label=value_t),vjust=1.5,colour="white",position=position_dodge(.9),size=3)+
  scale_fill_manual(values=c("#ee765d","#363a7c"))->g
ggsave("daynightacc.png")
#파이그래프
plot_ly(dayw,labels = ~기상상태, values = ~n, type = 'pie',textposition = 'outside',textinfo = 'label+percent') %>%
  layout(title = '낮',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         margin=10) ->pieday

plot_ly(nightw,labels = ~기상상태, values = ~n, type = 'pie',textposition = 'outside',textinfo = 'label+percent') %>%
  layout(title = '밤',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         autosize=F,width=400,height=600) ->pienight

saveWidget(as.widget(pieday),"pieday.html")
saveWidget(as.widget(pienight),"pienight.html")

#여기부터 화요일작업업
#-------------------------------------------------------------------------------------------------------------------------------
#지도 그리고 구별로 사고개수 보기쉽게 (수평 바그래프로 순서 정렬해서 볼 수 있게)

manual_color=c("강남구"=rainbow(25)[1],"강동구"=rainbow(25)[2],"강북구"=rainbow(25)[3],"강서구"=rainbow(25)[4],"관악구"=rainbow(25)[5],
               "광진구"=rainbow(25)[6],"구로구"=rainbow(25)[7],"금천구"=rainbow(25)[8], "노원구"="#003300",
               "도봉구"=rainbow(25)[10],"동대문구"=rainbow(25)[11],"동작구"=rainbow(25)[12],"마포구"=rainbow(25)[13],
               "서대문구"="#996600", "서초구"=rainbow(25)[15],"성동구"=rainbow(25)[16],"성북구"=rainbow(25)[17],
               "송파구"=rainbow(25)[18],"양천구"=rainbow(25)[19],"영등포구"=rainbow(25)[20],
               "용산구"=rainbow(25)[21],"은평구"=rainbow(25)[22],"종로구"=rainbow(25)[23],"중구"="brown","중랑구"="#6666cc")


temp<-year_acc2
temp %>% mutate(name=row.names(temp))->temp
for(i in 1:6){
  t<-paste(2013+i,"년 구별 사고",sep="")
  temp$name<-factor(temp$name,levels=temp$name[order(temp[,i])])
  temp %>% 
    ggplot(aes(x=name,y=temp[,i],fill=name))+
    geom_bar(stat="identity") +
    scale_fill_manual('구별',values = manual_color)+
    coord_flip() +
    labs(title=t,y="사고수")+
    theme_bw() +
    xlab("")+
    geom_hline(yintercept = c(1000,2000,3000),linetype="dashed",color="black")
  
  filename=paste("region_acc",i+2013,".png",sep="")
  ggsave(filename,dpi=200)
}

#모든 년도 통합 - 아쉬운점 : 코로나로 인한 사고관계 파악하고싶었지만 2020이후자료가 없음
year_acc %>% group_by(발생지_시군구) %>% ggplot(aes(x=발생지_시군구,y=n,fill=년도))+
  geom_bar(stat="identity",position=position_dodge(),width=0.7)+
  labs(y="사고수")+
  theme(axis.text.x=element_text(size=20,face='bold'),axis.title=element_text(size=40))+
  geom_hline(yintercept = c(1000,2000,3000),linetype="dashed",color="black")
ggsave("total_region.png",width=30)

#-------------------------------------------------------------------------------------------------------------------------
#시간별 사고그래프 -유동인구 많을 시간에 사고가 높음- 새벽시간에 차량단독사고율이 높음-> 졸음운전 의심가능
acc1$발생시간<-as.numeric(substr(acc1$발생시간,1,2))
acc1 %>% group_by(발생시간) %>% count(사고유형_대분류)->time_acc


time_acc %>% mutate(pct = paste(as.numeric(sprintf("%0.2f",prop.table(n)))*100,"%",sep="")) %>% ggplot(aes(x=발생시간,y=n,fill=사고유형_대분류))+
  geom_bar(stat="identity",width=0.9)+geom_text(aes(label=pct),size=3,position=position_stack(vjust=.5))+
  labs(title="시간별 사고건수",subtitle="사고유형별로 분류")+theme(plot.title=element_text(size=30))
  
ggsave("timeacc.png",dpi=300,width=12,height=8)  





#수요일
# 연령별 사고(가해 피해 비율),자전거 사고 비율,
# "승용차"             "보행자"             "승합차"             "이륜차"             "자전거"            
# "원동기장치자전거"   "화물차"             "없음"               "특수차"             "건설기계"          
# "불명"               "농기계"             "기타"               "개인형이동수단(PM)" "사륜오토바이(ATV)" 

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
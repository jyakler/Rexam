library(rvest)
site<-"https://comic.naver.com/genre/bestChallenge?&page="
result<-NULL
for(i in 1:50){
  url<-paste(site,i,sep="")
  url<-read_html(url)
  
  #제목
  name<-html_nodes(url,"div.challengeInfo > h6 > a")
  comic.name<-html_text(name,trim=T)
  comic.name
  #요약
  summary<-html_nodes(url,"div.challengeInfo > div.summary")
  comic.summary<-html_text(summary,trim=T)
  comic.summary
  
  #점수
  grade<-html_nodes(url,"div.challengeInfo > div.rating_type > strong")
  comic.grade<-html_text(grade)
  comic.grade
  
  #dataframe
  data<-data.frame(comic.name,comic.summary,comic.grade)
  result<-rbind(result,data)
}

write.csv(result,"navercomic.csv")
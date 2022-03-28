# 동적 데이터 수집
# 사이트에서 데이터 수집후 ajax로 되어있는 페이지 렌더링 시키고 거기서도 데이터 수집


library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , 
                      port = 4445, browserName = "chrome")
remDr$open()

url<-"https://www.megabox.co.kr/movie-detail/comment?rpstMovieNo=21049700"
remDr$navigate(url)
result<-NULL

Sys.sleep(2)
score<-remDr$findElements(using="css selector","div.story-point")
rec<-remDr$findElements(using="css selector","div.story-recommend")
rep<-remDr$findElements(using="css selector","div.story-txt")

scorel<-sapply(score,function(x){x$getElementText()})
recl<-sapply(rec,function(x){x$getElementText()})
repl<-sapply(rep,function(x){x$getElementText()})



a<-cbind(unlist(scorel),unlist(recl),unlist(repl))
#colnames(a)<-c("평점","기준","평가")
result<-cbind(result,a)
#View(result)
for(i in 2:10){
  nextpage<-paste("#contentData > div > div.movie-idv-story > nav > a:nth-child(",i,")",sep="")
  try(nextpageLink<-remDr$findElement(using="css selector",nextpage))
  if(length(nextpageLink)==0)break;
  nextpageLink$clickElement()
  Sys.sleep(2)

  score<-remDr$findElements(using="css selector","div.story-point")
  rec<-remDr$findElements(using="css selector","div.story-recommend")
  rep<-remDr$findElements(using="css selector","div.story-txt")
  scorel<-sapply(score,function(x){x$getElementText()})
  recl<-sapply(rec,function(x){x$getElementText()})
  repl<-sapply(rep,function(x){x$getElementText()})
  
  a<-cbind(unlist(scorel),unlist(recl),unlist(repl))
  result<-rbind(result,a)
}
colnames(result)<-c("평점","기준","평가")
write.csv(result,"movie.csv",fileEncoding = "UTF-8")
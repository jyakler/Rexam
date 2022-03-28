library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , 
                      port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("http://gs25.gsretail.com/gscvs/ko/products/event-goods")

Sys.sleep(1)
tpo<-remDr$findElement(using="css selector","#TWO_TO_ONE")
tpo$clickElement()
table<-NULL

Sys.sleep(2)
goodsn<-remDr$findElements(using="css selector","#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.tit")
goodsp<-remDr$findElements(using="css selector","#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price")

goodsname<-sapply(goodsn,function(x){x$getElementText()})
goodsprice<-sapply(goodsp,function(x){x$getElementText()})
goodsprice<-gsub("[,원]","",goodsprice)

t<-cbind(goodsname,goodsprice)
table<-rbind(table,t)
index=0
oldurl<-0
repeat{
  oldurl<-remDr$findElement(using="css selector","#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > span > a.on")
  oldurl<-as.numeric(oldurl$getElementText())
  index<-index+1
  
  if(index!=oldurl)
    break;
  goodsn<-remDr$findElements(using="css selector","#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.tit")
  goodsp<-remDr$findElements(using="css selector","#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > ul > li > div > p.price")
  
  goodsname<-sapply(goodsn,function(x){x$getElementText()})
  goodsprice<-sapply(goodsp,function(x){x$getElementText()})
  goodsprice<-gsub("[,원]","",goodsprice)
  
  t<-cbind(goodsname,goodsprice)
  table<-rbind(table,t)
  
  nexturl<-"#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(5) > div > a.next"

  
  nextpage<-remDr$findElement(using="css selector",nexturl)
  nextpage$clickElement()

  Sys.sleep(1)
  }
write.csv(table,"gs25_twotoone.csv",fileEncoding = "UTF-8")

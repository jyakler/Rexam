#네이버 블로그 맛집
library(httr)
library(rvest)
library(XML)

searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode("맛집")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

doc2<-xmlParse(doc,encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)
write.table (text,"naverblog.txt",fileEncoding="UTF-8")

#2
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "360"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
url
doc <- xmlParse(url, encoding="UTF-8")
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))


print("[360번 버스정보]")
cat("노선ID :",df[df$busRouteNm==360,"busRouteId"],"\n")
cat("노선길이 :",df[df$busRouteNm==360,"length"],"\n")
cat("기점 :",df[df$busRouteNm==360,"stStationNm"],"\n")
cat("종점 :",df[df$busRouteNm==360,"edStationNm"],"\n")
cat("배차간격 :",df[df$busRouteNm==360,"term"],"\n")

#3
library(jsonlite)
library(httr)
searchUrl<- "https://openapi.naver.com/v1/search/news.json"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode("빅데이터")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

json_data <- content(doc, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data)
df <- data.frame(json_obj)

df$items.title<-gsub("</?b>","",df$items.title)
df$items.title<-gsub("&.+t;","",df$items.title)
df$items.description<-gsub("</?b>","",df$items.description)
df$items.description<-gsub("&.+t;","",df$items.description)
write.table(df,"navernews.txt",fileEncoding = "UTF-8")

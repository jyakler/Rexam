# [ 예제14 ]
# SNS의 Open API 활용
library(httr)
library(rvest)
library(XML)

# URLEncode() : 주어진 문자열을 URL Encoding 규칙(=Query 문자열 인코딩)으로 변환하는 기능 제공
# '가' - 코드값 - UTF-8 : 0xEAB080, EUC-KR(CP949,ANSI) : 0xB0A1
URLencode('ABC')
URLencode('가나다')
URLencode("ABC123 가나다")


searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode("봄")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

# 블로그 내용에 대한 리스트 만들기		
doc2 <- xmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)
text
text <- gsub("</?b>", "", text) # </?b> --> <b> 또는 </b>
text <- gsub("&.+t;", "", text) # &.+t; --> &at;, &abct;, &lt;, &lllt; ... &lt;, &gt;, &quot;, 
#text[81]
text

# [ 예제15 ]
# 네이버 뉴스 연동  
searchUrl<- "https://openapi.naver.com/v1/search/news.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode("코로나")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))
write(doc,"test.txt")
# 네이버 뉴스 내용에 대한 리스트 만들기		
doc2 <- xmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue); 
text
text <- gsub("</?b>", "", text)
text <- gsub("&.+t;", "", text)
text

# [ 예제16 ]
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "146"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
url
doc <- xmlParse(url, encoding="UTF-8")
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
str(df)
View(df)

busRouteId <- df[df$busRouteNm == 146, "busRouteId"]
busRouteId


url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
url
doc <- xmlParse(url, encoding="UTF-8")
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
View(df)
str(df)

# [ 예제17 ]
# 서울시 빅데이터- XML 응답 처리
# http://openapi.seoul.go.kr:8088/796143536a756e69313134667752417a/xml/LampScpgmtb/1/100/

library(XML)
key = '796143536a756e69313134667752417a'
contentType = 'xml'
startIndex = '1'
endIndex = '200'
url = paste0('http://openapi.seoul.go.kr:8088/',key,'/',contentType,'/LampScpgmtb/',startIndex,'/',endIndex,'/')
url
t <- xmlParse(url, encoding="UTF-8")
upNm<- xpathSApply(t,"//row/UP_NM", xmlValue) 
pgmNm<- xpathSApply(t,"//row/PGM_NM", xmlValue)
targetNm<- xpathSApply(t,"//row/TARGET_NM", xmlValue)
price<- xpathSApply(t,"//row/U_PRICE", xmlValue)

df <- data.frame(upNm, pgmNm, targetNm, price)
View(df)
write.csv(df, "output/edu.csv")
#write.csv(df,"output/edu_utf8.csv",fileEncoding = "UTF-8")  엑셀은 utf8지원안함
# [ 예제18 ]

# 고속도로 공공데이터 포털 Open API - XML 응답 처리
library(rvest)
library(XML)
API_key <- "4062158448"
sdate <- "20210824"
stdHour <- "10"
type <- "xml"
url <- paste0("http://data.ex.co.kr/openapi/restinfo/restWeatherList?key=", API_key, "&type=", type, "&sdate=", sdate, "&stdHour=", stdHour)
url
# case 1
doc <- xmlParse(url, encoding="UTF-8")
unitName <- xpathSApply(doc,"//list/unitName", xmlValue) 
unitCode <- xpathSApply(doc,"//list/unitCode", xmlValue)
routeName <- xpathSApply(doc,"//list/routeName", xmlValue)
addr <- xpathSApply(doc,"//list/addr", xmlValue)
weatherContents <- xpathSApply(doc,"//list/weatherContents", xmlValue)
tempValue <- xpathSApply(doc,"//list/tempValue", xmlValue)

df <- data.frame(unitName, unitCode, routeName, addr, weatherContents, tempValue )
View(df)

# case 2
doc <- xmlParse(url, encoding="UTF-8")
df <- xmlToDataFrame(getNodeSet(doc, "//list"))
df
View(df)
names(df)
df_new <- df[c('unitName', 'unitCode', 'routeName', 'addr', 'weatherContents', 'tempValue')]
View(df_new)

?read_html


# [ 예제19 ]
# 고속도로 공공데이터 포털 Open API - JSON 응답 처리

library(jsonlite)
library(httr)
url <- 'https://data.ex.co.kr/openapi/restinfo/restWeatherList?key=4062158448&type=json&sdate=20210821&stdHour=10'
url
response <- GET(url)
json_data <- content(response, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data)
class(json_obj)
df <- data.frame(json_obj)
View(df)
df_new <- df[c('list.unitName', 'list.unitCode', 'list.routeName', 'list.addr', 'list.weatherContents', 'list.tempValue')]
View(df_new)


library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

library(ggmap)
library(ggplot2)
library(leaflet)
library(dplyr)
library(ggiraphExtra)
library(tibble)

register_google(key='AIzaSyDy81EbO46BRSnX1DOgg_F84bhsdbku2z4')
home<-geocode(enc2utf8("성내로 6나길 27"),source="google")
home
cen=c(home$lon,home$lat)
msg="나의 집"
leaflet() %>% addTiles() %>% setView(home$lon,home$lat,zoom=16) %>% 
  addCircles(home$lon,home$lat,popup=msg,color="red")->map1

library(htmltools)
save_html(map1,"output/lab19.html")

#2
library(kormaps2014)
rm(korpop1, korpop2, korpop3)

korpop2 <- rename(korpop2,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동,
                  외국인수=외국인_계_명)
korpop2$외국인수=as.numeric(korpop2$외국인수)
korpop2$name <- iconv(korpop2$name, "UTF-8","CP949")

seoulmap <- kormap2 %>% filter(startsWith(as.character(code), '11'))
seoulpop <- korpop2 %>% filter(startsWith(as.character(code), '11'))
myseoulpop<-seoulpop
ggChoropleth(myseoulpop,aes(fill=외국인수,
                          map_id=code),
             map=seoulmap,
             palette="Spectral",
             title="각 구별 외국인 수",
             interactive=T)->map2
save_html(map2,"output/lab19_2.html")
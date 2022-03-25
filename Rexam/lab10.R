url<-"http://media.daum.net/"
url<-read_html(url)
#/html/body/div[2]/main/section/div/div[1]/div[1]/ul/li[1]/div/div/span/span[2]
#카테고리
category<-html_nodes(url,".txt_category")
newscategory<-html_text(category)
newscategory
#제목
title<-html_nodes(url,xpath="/html/body/div[2]/main/section/div/div[1]/div[1]/ul/li")
title<-html_nodes(title,"div > div > strong > a.link_txt")
newstitle<-html_text(title,trim=T)
newstitle
#dataframe 만들기
data<-data.frame(newscategory,newstitle)
write.csv(data, "output/daum_news.csv")


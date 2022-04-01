#1
library(KoNLP)
#useSejongDic()
data<-read.csv("output/movie_reviews3.csv")
word<-extractNoun(data$vreview)
wname<-unlist(word)
wordcount<-NULL
table<-table(wname)
table<-head(sort(table,decreasing=T),10)
wordcount<-data.frame(wname=names(table),wcount=as.numeric(table))
write.csv(wordcount,"output/movie_top_word.csv")

#2
library(wordcloud2)
data2<-readLines("output/yes24.txt")
words<-gsub("[^가-힣]\\s","",data2)
#words<-gsub("[A-Z,a-z]","",words)
words<-gsub("[[:punct:]]","",words)
words<-gsub("\\d","",words)
word<-extractNoun(words)
cdata<-unlist(word)

cdata<-Filter(function(x){nchar(x)>=2 && nchar(x)<=4},cdata)
wordcount<-table(cdata)
wordcount<-sort(wordcount,decreasing=T)
result<-data.frame(names(wordcount),as.numeric(wordcount))
par(mar=c(1,1,1,1))
result2<-wordcloud2(result,size=0.7,rotateRatio = 0.4)

library(htmlwidgets)
htmltools::save_html(result2,"output/yes24.html")

#1
v<-sample(1:26,10)
sapply(v,function(v) LETTERS[v])

#2
memo<-readLines("data/memo.txt",encoding = "UTF-8")
memo
write(gsub("[[:punct:][:digit:]A-Z,a-z]","",memo),"memo_new.txt")
memo[7]
memo_new<-c()
memo_new<-c(memo_new,gsub("([[:upper:]])","\\L\\1",memo[7],perl=T));memo_new
#3
mybday<-as.Date("1997/09/03")
strptime("1997-09-03","%Y-%m-%d")
a=as.POSIXlt(mybday)
unclass(a)
weekdays(a)

data<-scan("data/iotest2.txt",what="",encoding="utf-8")
cat("가장 많이 등장한 단어는 ",names(which.max(table(data))),"입니다.\n")


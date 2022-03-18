#문제1
data()
names(iris)
length(t(iris))
str(iris)
#문제2
x<-c(1,2,3,4,5)
y<-c(2,4,6,8,10)
df1<-data.frame(x,y)

#문제3
col1<-c(1,2,3,4,5)
col2<-c("a","b","c","d","e")
col3<-c(6,7,8,9,10)
df2<-data.frame(col1,col2,col3)

#문제4
제품명<-c("사과","딸기","수박")
가격<-c(1800,1500,3000)
판매량<-c(24,38,13)
df3<-data.frame(제품명,가격,판매량);df3

#문제5
mean(df3$가격)
mean(df3$판매량)

#문제6
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
gender <- factor(c("M","F","M", "F", "M"))
math <- c(85, 76, 99, 88, 40)
df4<-data.frame(name,gender,math)
str(df4)
df4$stat<-c(76,73,95,82,35)
df4$score<-df4$stat+df4$math
df4$grade<-ifelse(df4$score>=150,"A",ifelse(df4$score>=100,"B",ifelse(df4$score>=70,"C","D")))
df4

#문제7
myemp<-read.csv("data/emp.csv")
str(myemp)
#8
myemp[3:5,]
#9
myemp[,-4]
#10
myemp[,"ename",drop=F]
#11
subset(myemp,select=c("ename","sal"))
#12
subset(myemp,job=="SALESMAN",c("ename","sal","job"))
#13
subset(myemp,sal>=1000&sal<=3000,select=c("ename","sal","deptno"))
#14
subset(myemp,job!="ANALYST",c("ename","sal","job"))
#15
subset(myemp,job=="SALESMAN" | job=="ANALYST",c("ename","job"))
#16
myemp[is.na(myemp$comm),c("ename","sal")]
#17
myemp[order(myemp$sal),]
#18
length(myemp)
length(row(myemp))
#19
summary(factor(myemp$deptno))
#20
summary(factor(myemp$job))#table(myemp$job)

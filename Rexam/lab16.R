library(dplyr)
emp<-read.csv("data/emp.csv",encoding = "UTF-8")
#1
manager<-emp %>% filter(emp$job=="MANAGER")
manager
#2
emp %>% select(empno,ename,sal)
#3
emp %>% select(-empno)
#4
emp %>% select(ename,sal)
#5
emp %>% count(job)
#6
emp %>% filter(sal>=1000 &sal<=3000) %>% select(ename,sal,deptno)
#7
emp %>% filter(job!="ANALYST") %>% select(ename,job,sal)
#8
emp %>% filter(job=="SALESMAN"|job=="ANALYST") %>% select(ename,job)
#9
emp %>% group_by(deptno) %>% summarise(total=sum(sal))
#10
emp %>% arrange(sal)
#11
emp %>% arrange(desc(sal)) %>% head(1)
#12
emp %>% rename(salary=sal,commrate=comm)->empnew
#13
emp %>% count(deptno) %>% arrange(desc(n)) %>% head(1)
#14
emp %>% mutate(enamelength=nchar(ename)) %>% arrange(enamelength)
#15
emp %>% filter(!is.na(comm)) %>% count()

#16
library(ggplot2)
mpg<-as.data.frame(ggplot2::mpg)
str(mpg)
nrow(mpg);ncol(mpg)
#dim(mpg)
mpg %>% head(10)
mpg %>% tail(10)
summary(mpg)
mpg %>% count(manufacturer)
mpg %>%  group_by(model) %>% mutate(n=n())%>%select(manufacturer,model,n) %>% distinct()

#17
#1
mpg %>% rename(city=cty,highway=hwy)->newmpg
str(newmpg)
newmpg
#18
#1
group_a<-mpg %>% filter(displ<=4) %>% summarise(mean(hwy))
group_b<-mpg %>% filter(displ>=5)%>% summarise(mean(hwy))
print(paste("배기량이 4이하인 자동차의 연비:",group_a))
print(paste("배기량이 5이상인 자동차의 연비:",group_b))
#2
mpg %>% filter(manufacturer==c("audi","toyota")) %>% group_by(manufacturer) %>% summarise(mean(cty)) %>% arrange() %>% tail(1) %>% 
select(manufacturer)  
#3
mpg %>% filter(manufacturer==c("chevrolet","ford","honda")) %>% group_by(manufacturer)%>% summarise(mean(hwy))

#19
#1
newdata<-mpg %>% select(class,cty)
str(newdata)
#2
newdata %>% filter(class==c("suv","compact")) %>% group_by(class) %>% summarise(mean(cty))
print("compact의 도시연비가 더높다")

#20
#mpg %>% filter(manufacturer=="audi") %>% group_by(model) %>% summarise(n=mean(hwy)) %>% arrange(desc(n)) %>% head(5)
mpg %>% filter(manufacturer=="audi")  %>% arrange(desc(hwy)) %>% head(5)

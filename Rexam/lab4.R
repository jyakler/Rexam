#문제1
L1<-list(
  name="scott",
  sal=3000
)
L1
result1<-L1$sal*2

#문제2
L2<-list(
  name="scott",
  sal=seq(100,300,100)
)
names(L2)<- NULL
L2

#문제3
L3<-list(c(3,5,7), c("A", "B", "C"))
L3[[2]][1]<-"Alpha"
L3

#문제4
L4<-list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
L4[[1]]*10

#문제5
emp<-read.csv("data/emp.csv")
L5<-list(
  data1=LETTERS,
  data2=emp[1:3,],
  data3=L4
)
unlist(L5[[1]])[1]
unlist(L5$data2$ename)
unlist(L5$data3$gamma)

#문제6
L6<-list(math=list(95, 90), writing=list(90, 85), reading=list(85, 80))
mean(unlist(L6$math))
mean(unlist(L6$writing))
mean(unlist(L6$reading))


# 질문내용 리뷰
# 데이터프레임을 생성하고 열이름을 별도로 지정할때는 이가 정확하게 표시 됨 
burger <- data.frame (c(514, 533, 566),
  c(917, 853, 888), c(11, 13, 10), c("새우", "불고기", "지킨"),
  row.names = c("N", "L", "B"))
colnames (burger) = c("열량(kcal)", "나트륨(na)", "포화지방(fat)", "메뉴명")
burger
# 열이름을 지정해서 데이터 프레임을 생성할때는 ()가 .으로 표시 됨 왜 그렇게 되는건가요??? 
burger <- data.frame (" 열량(kcal)" = c(514, 533, 566),
                      "나트륨(na)" = c(917, 853, 888),
                      "포화지방(fat)" = c(11, 13, 10), 
                      "메뉴명" = c("새우", "불고기", "치킨"),
                      row.names = c("M", "L", "B"))
burger


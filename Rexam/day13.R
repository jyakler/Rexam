library(dplyr)

# 중간고사 데이터 생성
(test1 <- data.frame(no = c(1, 2, 3, 4, 5, 6),  
                     midterm = c(60, 80, 70, 90, 85, 100)))
# 기말고사 데이터 생성
(test2 <- data.frame(no = c(1, 5, 3, 4, 2, 7),  
                     final = c(70, 80, 65, 95, 83, 0)))


inner_join(test1, test2, by = "no")  
left_join(test1, test2, by = "no") 
right_join(test1, test2, by = "no") 
full_join(test1, test2, by = "no") 

merge(test1, test2)
merge(test1, test2, all.x = T)
merge(test1, test2, all.y = T)
merge(test1, test2, all = T)

# 다른 데이터 활용해 변수 추가하기
# 반별 담임교사 명단 생성
(exam <- read.csv("data/csv_exam.csv"))
(tname <- data.frame(class = c(1, 2, 3, 4, 5), teacher = c("kim", "lee", "park", "choi", "jung")))
# class 기준 합치기
(exam_new <- left_join(exam, tname, by = "class"))



# 데이터 정제 : 결측치(NA)와 이상치 처리
# 먼저 결측치부터~~~~~~

df <- data.frame(sex = c("M", "F", NA, "M", "F"), 
                 score = c(5, 4, 3, 4, NA))
View(df)
# 결측치 확인하기
is.na(df)         # 결측치 확인
table(is.na(df))  # 결측치 빈도 출력
# 변수별로 결측치 확인하기
table(is.na(df$sex))    # sex 결측치 빈도 출력
table(is.na(df$score))  # score 결측치 빈도 출력
# 결측치 포함된 상태로 분석
mean(df$score)  # 평균 산출
sum(df$score)   # 합계 산출


# 결측치 있는 행 제거하기
library(dplyr) # dplyr 패키지 로드
df %>% filter(is.na(score))   # score가 NA인 데이터만 출력
df %>% filter(!is.na(score))  # score 결측치 제거
# 결측치 제외한 데이터로 분석하기
df_nomiss <- df %>% filter(!is.na(score))  # score 결측치 제거
mean(df_nomiss$score)                      # score 평균 산출
sum(df_nomiss$score)                       # score 합계 산출
# 여러 변수 동시에 결측치 없는 데이터 추출하기
# score, sex 결측치 제외
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss  
# 결측치가 하나라도 있으면 제거하기
df_nomiss2 <- na.omit(df)  # 모든 변수에 결측치 없는 데이터 추출
df_nomiss2
#분석에 필요한 데이터까지 손실 될 가능성 유의
# 함수의 결측치 제외 기능 이용하기 - na.rm = T
mean(df$score, na.rm = T)  # 결측치 제외하고 평균 산출
sum(df$score, na.rm = T)   # 결측치 제외하고 합계 산출


#summarise()에서 na.rm = T사용하기
# 결측치 생성
exam <- read.csv("data/csv_exam.csv")            # 데이터 불러오기
table(is.na(exam))
exam[c(3, 8, 15), "math"] <- NA             # 3, 8, 15행의 math에 NA 할당
table(is.na(exam))


#평균 구하기
exam %>% summarise(mean_math = mean(math))             # 평균 산출
exam %>% summarise(mean_math = mean(math, na.rm = T))  # 결측치 제외하고 평균 산출
# 다른 함수들에 적용
exam %>% summarise(mean_math = mean(math, na.rm = T),      # 평균 산출
                   sum_math = sum(math, na.rm = T),        # 합계 산출
                   median_math = median(math, na.rm = T))  # 중앙값 산출
boxplot(exam$math) # 결측치는 제거하고 그려줌
mean(exam$math, na.rm = T)  # 결측치 제외하고 math 평균 산출


# 평균으로 대체하기
exam$math <- ifelse(is.na(exam$math), 55, exam$math)  # math가 NA면 55로 대체
table(is.na(exam$math))                               # 결측치 빈도표 생성
sum(is.na(exam$math))
mean(exam$math)  # math 평균 산출



df <- airquality
head(df)
dim(df)
View(df)
is.na(df)
row_na_cnt = apply(df, 1, function(x){sum(is.na(x))})
table(row_na_cnt)
col_na_cnt = apply(df, 2, function(x){sum(is.na(x))})
table(col_na_cnt)

df[is.na(df$Solar.R), "Solar.R"] = mean(df$Solar.R, na.rm = TRUE) 
df[is.na(df$Ozone), "Ozone"] = mean(df$Ozone, na.rm = TRUE) 
View(df)



install.packages("tidyr") # 추가
library(tidyr)
library(dplyr)

exam <- read.csv("data/csv_exam.csv")            
exam[c(1, 5, 3, 8, 15, 20), "math"] <- NA 
exam

fill(exam, math, .direction = "down")
fill(exam, math, .direction = "up")
fill(exam, math, .direction = "updown")

exam[c(1, 5, 6, 7, 20), "english"] <- NA 
exam

fill(exam, math, english, .direction = "updown")
fill(exam, everything(), .direction = "updown")

exam %>%
  mutate(math2 = math) %>%
  group_by(class) %>%
  fill(math2, .direction = "down")

exam %>%
  mutate(math2 = math) %>%
  group_by(class) %>%
  fill(math2, .direction = "up")

exam %>%
  mutate(math2 = math) %>%
  group_by(class) %>%
  fill(math2, .direction = "downup")

exam %>%
  mutate(math2 = math, english2 = english) %>%
  group_by(class) %>%
  fill(math2, english2, .direction = "downup")

exam %>%
  mutate(math2 = math, english2 = english) %>%
  group_by(class) %>%
  fill(everything(), .direction = "downup")


exam %>%
  mutate(math2 = math, english2 = english) %>%
  group_by(class) %>%
  fill(ends_with("2"), .direction = "downup")



# 날짜 또는 날짜+시간 데이터 셋 만들기
dd <- seq(Sys.Date(),Sys.Date() + 10, "day")
dd
class(dd)
seq(Sys.time(),Sys.time() + 60*60*10, "hour")
seq(Sys.time(),Sys.time() + 60*10, "min")


seq(Sys.Date(), as.Date("2050-12-31"), "10 year")

seq(Sys.Date(), length.out=10, by="year")
seq(Sys.Date(), length.out=10, by="10 year")
seq(Sys.Date(), length.out=10, by="day")
seq(Sys.time(), length.out=10, by="hour")
seq(Sys.time(), length.out=10, by="min")
seq(Sys.time(), length.out=10, by="sec")

data.frame(num=1:9, point=as.POSIXct(c("2022-01-04 09:30:02", "2022-01-04 09:30:04",
                                       "2022-01-04 09:30:06", "2022-01-04 09:30:08", "2022-01-04 09:30:10", 
                                       "2022-01-04 09:30:12", "2022-01-04 09:30:14", "2022-01-04 09:30:16",
                                       "2022-01-04 09:30:18")))

data.frame(num=1:9, point=seq(as.POSIXct("2022-01-04 09:30:02"), length.out=9,by="2 sec"))
data.frame(num=1:9, point=seq(as.POSIXct("2022-01-04 09:30:02"), length.out=9,by="sec"))

info <- data.frame(num=1001:1009, point=seq(as.POSIXct("2022-01-04 09:30:02"), length.out=9,by="2 sec"))
info
str(info)
info[c(1,3,9), "point"] <- NA
info
a<-fill(info, point, .direction = "updown")
plot(a)
str(a)
plot(a$point, a$num)


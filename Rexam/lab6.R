#1
exam1<-function(){
  a<-paste0(LETTERS,letters)
  return (a)
}
exam1()

#2
exam2<-function(a){
  sum<-0
  for(i in 1:a){
    sum<-sum+i
  }
  return(sum)
}
cat("함수 호출 결과 : ",exam2(30),"\n")

#3
exam3<-function(a,b){
  if(is.numeric(a)&is.numeric(b)){
    temp<-a-b
    if(temp<0)
      temp<--temp
    temp2<-paste("함수 호출 결과 :",temp)
    return(temp2)
  }
}
print(exam3(10,20))

#4
exam4<-function(a,opt,c){
  if(opt=="%/%"|opt=="%%"){
    if(a==0)return("오류1")
    if(c==0)return("오류2")
  }
  return(switch(EXPR=opt,
         "+"=a+c,
         "-"=a-c,
         "*"=a*c,
         "%/%"=a%/%c,
         "%%"=a%%c,
         "규격의 연산자만 전달하세요"
         ))
}
exam4(100,"%%",5)

#5
exam5<-function(a,b="#"){
  if(a>0)
    rep(b,a)
}
exam5(10)
exam5(3,"$$")

#6
exam6<-function(b){
  data<-b
  for(a in data){
    if(is.na(a))
      return("NA 는 처리불가")
    if(a>=85)
      cat(a,"점은 상등급입니다.\n")
    else if(a>=70)
      cat(a,"점은 중등급입니다.\n")
    else
      cat(a,"점은 하등급입니다.\n")
  }
}
exam6(c(80,50,70,66,NA,35))
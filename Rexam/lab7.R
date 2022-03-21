#1
countEvenOdd<-function(b){
  even<-0;odd<-0
  for(a in b){
    if(is.numeric(a)){
      if(a%%2==0)even<-even+1
      else odd<-odd+1
    }else{
      return(NULL)
    }
  }
  return(list(even=even,odd=odd))
}
countEvenOdd(c(1,2,3,4,5))

#2
vmSum<-function(b){
  sum<-0
  if(is.vector(b)&&!is.list(b)){
      for(a in b){
        if(is.numeric(a)){
          sum<-sum+a
        }else{
          print("숫자 벡터를 전달하숑!")
          return(0)
        }
      }
  }else{
    print("벡터만 전달하숑!")
    return(0)
  }
}
vmSum(list())
vmSum(c(1,2,"가"))
vmSum(c(1,2,3,4,5))

#3
vmSum2<-function(a){
  sum<-0
  if(is.vector(a)&&!is.list(a)){
    for(b in a){
      if(is.numeric(b)){
        sum<-sum+b
      }else{
        warning("숫자 벡터를 전달하숑!")
        return(0)
      }
    }
  }else{
    stop("벡터만 전달하숑!")
  }
}
vmSum2(list())
vmSum2(c(1,2,"가"))
vmSum2(c(1,2,3,4,5))

#4
mySum<-function(data){
  odd<-0;even<-0
  min<-data[1]
  if(is.null(data))return(NULL)
  if(!is.vector(data)){
    stop("벡터만 처리가능!!")
  }
  if(any(is.na(data))){
    warning("NA를 최저값으로 변경하여 처리함!!")
  }
  i<-0
  for(i in 1:length(data)){
    if(is.na(data[i]))data[i]<-min
    if(min>data[i])min<-data[i]
    if(!is.numeric(data[i]))next
    if(i%%2==0)even<-even+data[i]
    else odd<-odd+data[i]
  }
  return(list(oddSum=odd,evenSum=even))
}
mySum(matrix())
mySum(c(1,2,"가"))
mySum(c(1,2,NA,4,5))

#5
myExpr<-function(a){
  if(!is.function(a)){
    stop("수행 안할거임!!")
  }
  data<-sample(1:45,6)
  result<-a(data)
  return(result)
}
myExpr(mySum)

#6
createVector1<-function(...){
  p<-c(...)
  if(is.null(p))return(NULL)
  if(any(is.na(p)))return(NA)
  return(p)
}
createVector1(1,2,3,4,5)

#7
createVector2<-function(...){
  p<-c(...)
  char<-c()
  num<-c()
  bool<-c()
  if(is.null(p))return(NULL)
  for(a in p){
    if(is.character(a))char<-append(char,a)
    else if(is.numeric(a))num<-append(num,a)
    else if(is.logical(a))bool<-append(bool,a)
  }
  return(list(num,char,bool))
}
createVector2(list(1,2,3,4,5,T,F,"hi"))
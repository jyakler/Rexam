# R


## 함수

    seq(start,end,간격): 나열
    rep(무엇을,얼마나): 반복 /    each=숫자 - 각각 반복
    which(조건): 조건에 해당되는 것의 인덱스 / ex)  which.max()
    sample(범위,몇개): 랜덤값 /    default: replace=F(중복 없음)
    paste(문자열1,문자열2,...)- 문자열1+문자열2... 하는 함수/    default: sep=" ", collapse="\t"
    rev(): 거꾸로
    class(변수)
    range(범위): 시작,끝 출력
    sort(함수):default 오름차순 /  default: decreasing=F
    order(): 작은순부터 큰것으로 순서를 각위치에서 rank식으로
    
    matrix():  nrow=행갯수 ncol=열갯수 byrow=T(행우선)
    apply(2차원벡터, 1or 2, 함수): 1:row 2:col  - 매트릭스의 행,열기준으로 함수의 작업 수행
    array(범위,dim=c(row,col,width)): 3차원벡터  
    
    
    팩터(factor)
        가능한 범주값(level) 만으로 구성되는 벡터이다.
        팩터 생성 방법 : factor(벡터)/ factor(벡터[, levels=레벨벡터])/ factor(벡터[, levels=레벨벡터], ordered=TRUE)
        팩터의 레벨 정보 추출 : levels(팩터변수)
        
     dataframe   
        데이터프레임의 구조 확인 :str(df), dim(df)
        인덱싱 : [행의인덱싱, 열의인덱싱],[열의인덱싱], df$컬럼이름, [[열인덱싱]]

        원하는 행과 열 추출 : subset(df, select=컬럼명들, subset=(조건))
        
        
      scan(): 파일 스캔  
      read.table(): default: header=F (T하면 첫번째줄을 header로인식
***

    function
        return()
        invisible()  : 그냥 리턴하면 결과가 안나오지만 변수에 담아서 하면 나옴
        Sys.sleep() : sleep
        A << b : 전역대입연산
        A <- b: 지역대입연산

***
__is.xxx 결과__

- data.frame(): 데이터프레임 & 리스트 

- LETTERS, 100,... :벡터

- matrix(): 메트릭스 & 배열

- list(): 리스트 & 벡터

- array(): 배열

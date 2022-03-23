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
    min,max() : 최소 쵀대값/ na.rm=TRUE,FALSE  -> NA값을 무시하거나 포함
    
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
        
        stop() : 에러 만들고 멈추기
        warning(): warning하기

***
__is.xxx 결과__

- data.frame(): 데이터프레임 & 리스트 

- LETTERS, 100,... :벡터

- matrix(): 메트릭스 & 배열

- list(): 리스트 & 벡터

- array(): 배열

***
[정규표현식에서 횟수를 나타내는 특수문자(메타문자)]

\* : 0개이상

\+ : 1개이상

? : 0 또는 1개

. : 임의의 한 문자

    grep(뭐를,원본): default index리턴, value=TRUE -> 값 리턴 / #[^....]  -> 부정   ^xxx  -> 시작 / xxx$  -> 종료
    gsub(뭐를,뭘로,원본): replace함
    strsplit(문장,split="") : text를 나눔 -> list로 반환

### 날짜

    Sys.Date()
    Sys.time()
    date()
    
- 년월일 시분초 타입의 문자열을 날짜 또는 시간으로 변경 : 
 
   as.Date("년-월-일 시:분:초") 또는 as.Date("년/월/일 시:분:초")
    
   as.POSIXct("년-월-일 시:분:초") 또는 as.POSIXct("년/월/일 시:분:초")
    
   as.POSIXlt("년-월-일 시:분:초") 또는 as.POSIXlt("년/월/일 시:분:초")
    
- 특정 포맷을 이용한 날짜: as.Date("날짜 문자열", format="포맷")
 
   as.POSIXct("날짜와 시간 문자열", format="포맷")
     
   as.POSIXlt("날짜와 시간 문자열", format="포맷")

strptime(날짜,포맷)- 날짜를 posixlt로 변환 

## 정적 데이터 수집

새로운 R 패키지의 설치 :
    install.packages("패키지명")

- 이미 설치된 R 패키지 확인 :
    installed.packages()

- 설치된 패키지 삭제 :
remove.packages("패키지명")

- 설치된 패키지의 버전 확인 :
packageVersion("패키지명")

- 설치된 패키지 업데이트 :
update.packages("패키지명")

- 설치된 패키지 로드 :
library(패키지명)
require(패키지명)

- 로드된 패키지 언로드(로드상태 해제)  :
detach("package:패키지명")

- 로드된 패키지 점검 :search()

#### 활용

    library(rvest) 사용

    read_html(url)

    html_nodes(url읽은 text, "속성"): 알맞는 노드를 리턴

    html_text(노드) : 노드의 text부분 출력

    html_attr(노드): 노드의 속성 출력

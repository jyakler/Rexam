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

    URLencode() : 주어진 문자열을 encoding규칙으로 변환

xml2
    
    read_html(url)

rvest

    html_nodes(x, css, xpath), html_node(x, css, xpath) : 원하는 노드(태그) 추출하기
    html_text(x, trim=FALSE) : 노드에서 컨텐트 추출하기, trim= 쓸모없는 공백제거
    html_attrs(x) : 노드에서 속성들 추출하기
    html_attr(x, name, default = "") : 노드에서 주어진 명칭의 속성값 추출하기

XML
    
    htmlParse (file, encoding="…"), xmlParse(file, encoding="…") : xpathSApply() 사용 가능한 객체로 변환
    xpathSApply(doc, path, fun) : 원하는 노드(태그) 추출하고 전달된 함수 수행하기
    # fun : xmlValue, xmlGetAttr, xmlAttrs
    xmlToDataFrame(): extract data from simple xml
    getNodeSet(): get matching nodes
    readHTMLTable(): 테이블 

httr

    GET(url) : HTML 웹 페이지를 요청해서 받아오기
    요청헤더에 계정 또는 패스워드 등의 정보 전달 가능
    응답 내용이 바이너리인 경우에도 사용 가능
    content(urlrepsonse, type="",encoding=""): extract content from request
  
 jsonlite
 
    fromJSON(): xmlParse json버전
    
## selenium 키는법

selenium폴더에 들어가서
    
    java -Dwebdriver.chrome.driver="chromedriver.exe" -jar selenium-server-standalone-4.0.0-alpha-1.jar -port 4445
    
수행

## 동적 데이터 수집

 주의할점: navigate하고 조금 시간준다음에 findElement해야함. 텀안주면 오류발생 


remDr <-remoteDriver(remoteServerAddr="", port=,browserName="") : R 코드로 Selenium 서버에 접속하고
remoteDriver 객체 리턴

remDr$open() : 브라우저 오픈

remDr$navigate(url): url로 이동

remDr$sendKeysToElement(list("검색어",key="enter")) : 검색어 치고 엔터 누르기

one<- remDr$findElement(using="css",무엇을): css무엇 태그 하나 찾기.
    여러개 찾을거면 fineElements 사용 - sapply(dom,function(x){x$getElementText()}) 이런식으로 사용
    
    one$getElementTagName()
    one$getElementText()
    one$getElementAttribute("속성명")
    
    
one$clickElement(): 찾은 태그 클릭이벤트 발생

remDr$executeScript("argument\[0\].click();",list(a)) - clickElement가 작동안할때 사용
    - scrollTo(0,document.body.scrollHeight)" 로 페이지 스크롤 

## text 분석

text전처리- gsub등해서 짜를거 짜르고
extractNoun


showtext라이브러리 - font_add()

packages("proxy") # 유사도 분석 

packages("tm") # 텍스트 마이닝 지원 패키지

packages("qgraph") # 네트워크 그래프

packages("SnowballC") # 어근 추출

TF-IDF(Term Frequency-Inverse Document Frequency)는 단어의 빈도와 역 문서 빈도(문서의 빈도에 특정 식을 취함)를 사용하여 DTM 내의 각 단어들마다 중요
한 정도를 가중치로 주는 방법. TF-IDF 는 단어가 해당 문서에서 얼마나 중요한 단어(유의미한, 주제어)인지를 측정할 때 사용한다

TF-IDF 값이 낮으면 중요도가 낮은 것이며, TF-IDF 값이 크면 중요도가 큰 것


#### 형태소 분석 패키지
library(KoNLP) -한나눔 형태소 분석기 - 생각보다 분석 오류들이 있음
useSejongDic()

    extractNoun() : 명사 추출
    SimplePos09() : 9가지 품사로 형태소분석
    SimplePos22() : 22가지 품사로 형태소 분석


### 텍스트 시각화 - 워드 클라우드

    library("wordcloud")
    library("wordcloud2")
    wordcloud(단어모음$keyword, 단어모음$빈도,min.freq=최소빈도, random.order=F(큰값일수록 중앙), rot.per= 가로세로비율, scale=크기, colors= 색, family=폰트)<-plot에 보여짐
    
    wordcloud2(단어모음,rotateRatio=회전한단어비율, size=크기,col=색,backgroundColor=배경색,shape=모양, fontFamily=폰트) <-viewer에 의해 보여짐(html로 만들어져 마우스 오버일때 정보가 보임)
    
    library(htmlwidgets)
    saveWidget(result, "htmlfile") : save widget to html file<img width="644" alt="par_cheatsheet" 
    htmltools::save_html(result,"htmlfile")

## 그래프

- 고수준 함수 – plot(), boxplot(), hist(), pie(), barplot()
- 저수준 함수(꾸밈) – title(), lines(), axis(), legend(), points(), text()
- 칼라팔레트 함수(스타일) – rainbow(), cm.colors(), topo.colors(), terrian.colors(), heat.colors()

***

[ 그려지는 그래프를 파일에 저장하는 방법1 ]

png("mytest.png", 500, 400)

그래프를 그린다.

dev.off()

[ 그래프를 그린 후에 파일에도 저장하는 방법2 ]

그래프를 그린다.

dev.copy(png, “mytest.png”) 또는 dev.copy(pdf, “mytest.pdf”)

dev.off()

***

(앞~뒤) - 뒤에있는애들로 그룹핑

막대그래프 -barplot(테이블, main="제목",col=막대색,xlab=가로축이름, ylab=세로축이름,horiz= 옆으로 출력(TF), ...)

선그래프 - plot(type="l")

히스토그램- 연속형 수치데이터- hist()

파이그래프- pie()  -3시부터 반시계방향으로 처리

상자그래프 - boxplot() - 함수내에서 family에서 폰트설정은 불가능. 외부적으로만 설정   /range=0하면 이상치 측정안함

산점도 - plot()



![제목 없음](https://user-images.githubusercontent.com/49812691/160569359-4f51ff15-09a8-463a-bbf2-80573d6e9884.png)

### 추후에 디테일 변경
    
    x축 추가 -axes(1, ..., family=폰트)
    y축 추가 -axes(2, ...)
    제목 추가 -title()

par() -리턴값=바꾸기전 세팅값 (담아두고 나중에 돌아가려할때 쓸 수 있음)
![img](https://user-images.githubusercontent.com/49812691/160518274-6902f23d-2ccd-4082-9bff-a3faad41fc4f.png)

### dplyr 패키지- 데이터 전처리

chain()함수 - %>% (단축키 shift + ctrl + M)

group_by()- summarise할때 기준 설정가능  - count()==group_by() + tally()

    filter(): 조건 맞는것 
    slice() : row를 포지션에 맞게(index)추출
    arrange() : sort기능
    select(): 어떤 col선택?
    rename() :col name 바꾸기 - reshape 패키치 추가로 설치해야함
    distinct(): 중복제거
    sample_n(): 랜덤선택
    sample_frac():
    mutate() : add new col, 파생변수 생성
    transmute(): add new col
    summarise(): 값 요약

    bind_rows():rbind보다 속도가 조금 빠름
    bind_cols()

합치기

    merge
    inner_join: 두자료 공통만
    (outer_join) -
        left_join: 왼쪽 자료기준
        right_join: 오른쪽 자료기준
        full_join: 모든항목 결합

### tidyr 패키지

    fill() : 값이 없는것을 .direction="down/up/updown/downup" 방향의 것으로 가져와서 채움
    gather() : long format데이터로 변환하기위한 함수
    spread(): gather반대
    separate() : 데이터를 sep=""기준으로 나눔
    
![캡처](https://user-images.githubusercontent.com/49812691/161458271-8d90b16b-e547-400d-83f2-a484e2a32259.PNG)

### ggplot2 - 더 다양한 그래프

ggplot(data, ...)

    aes - set of layer - x,y축
    geom_point() : 점으로 표현
    geom_line() : 선그래프
    geom_col() : 집계막대- 데이터를 미리 집계해서 넘겨줘야함
    geom_bar() : 빈도 막대
    geom_box() : 상자 그래프
    geom_histogram(): 히스토그램
    geom_label() : 레이블
    geom_map(): 지도 
    
    coord_cartesian(xlim="",ylim="") :범위제한
    scale_colour_...() : 색범주 지정
    scale_fill_brewer(palette="") : 색팔레트 지정
    labs(title="",subtitle="",x="",y="")
### xlsx 패키지
    read.xlsx(파일이름,시트번호,...) : 엑셀파일 읽기
### plotly 패키지
    ggplotly() : 그래프 마우스 호버해서 정보 볼 수 있음

### treemap 패키지
    
    treemap(vsize="크기기준",index="표현하고자 하는 계층",...) : 트리맵 그리기

### tm 패키지 - 영어에 특화됨

    VCorpus() : 말뭉치/ vcorpus구성때 필요한 것 : "DataframeSource" "DirSource"       "URISource"       "VectorSource"   "XMLSource"       "ZipSource" 
    VectorSource() : 벡터소스화
    TermDocumentMatrix,    DocumentTermMaxtrix : 여기 안에서 control=list()로 transformation정보 줄 수 있음. ex) removeNumbers=T, wordLengths=c(1,Inf), stopwords= ...
    content_transformer : 함수만들기
    tm_map : 텍스트에 대한 전처리 (corpora)
          --getTransformations()--
            removePunctuation
            removeNumbers
            removeWords
            stripWhitespace
            stemDocument : 어근만 남김
#### stopwords 패키지
    marimo 소스- 한국어 불용어 -stopwords("ko",source="marimo")

### qgraph 패키지 - 텍스트 분석 시각화- 네트워크 그래프

    qgraph()
    
### proxy 패키지
    dist(,method="") : 유사도 거리  - 0일수록 유사성 높음
    simil(): 유사성 - 1일수록 유사성 높음

## 지도 시각화

### ggmap 패키지
    get_googlemap(center=중앙위치(벡터), maptype="",zoom=,marker=데이터프레임)
    ggmap(): 맵그리기 
    geocode(위치,source="google") : 구글에서 위치의 위도경도를 tibble로 반환해줌
    qmap() : get_googlemap+ggmap해놓은거랑 비슷함

### leaflet 패키지
자바스크립트 방식이라 맵 확대, 축소, 클릭이 가능함


    leaflet():리플렛 사용
    addTiles(): 맵그리기
    addProviderTiles(): 기본 외에 다른 타일 그리고 싶을때 사용
    addCircles(lan=,lat=,popup=,color=,...): 원그리기
    setView(lan=,lat=,zoom=): 뷰
    addPopups(): 팝업 나오게
    
### ggiraphExtra 패키지
    ggChoropleth(data = ,         # 지도에 표현할 데이터
             aes(fill = ,    # 색깔로 표현할 변수
                 map_id =),  # 지역 기준 변수
             map = )     # 지도 데이터


## 상관관계
![캡처](https://user-images.githubusercontent.com/49812691/161882513-5867bf13-4571-489c-a7e3-5ab643390644.PNG)

-1에 가까울 수록 반비례

1에 가까울 수록 정비례

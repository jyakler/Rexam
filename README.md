# R


## 함수

    seq(start,end,간격): 나열
    rep(무엇을,얼마나): 반복 /    each=숫자 - 각각 반복
    which(조건): 조건에 해당되는 것의 인덱스
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
        팩터의 레벨 정보 추출 : levels(팩터변수
***

url<-"http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
html<-read_html(url)
html

#1
h1<-html_text(html_nodes(html,"h1"))
h1

#2
href<-html_nodes(html,"a")
html_attr(href,"href")

#3
img<-html_nodes(html,"img")
html_attr(img,"src")

#4
h2<-html_text(html_nodes(html,"h2:nth-of-type(1)"))
#h2<-html_text(html_nodes(html,"h2:nth-child(9)"))
h2

#5
ul<-html_nodes(html,xpath="//*/ul/li[@style='color:green']/text()")
#html_text(html_node(html,"ul > [style$=green]")) #parent >child
ul<-html_text(ul)
ul

#6
h2<-html_text(html_nodes(html,"h2:nth-of-type(2)"))
h2

#7
ol<-html_text(html_nodes(html,"ol *"))
ol<-gsub("[[:cntrl:]]"," ",ol)
ol
#html_text(html_nodes(html,"ol > *"))

#8
#html_text(html_nodes(html,"table *"))

tab<-html_nodes(html,"table tr")
temp<-tab
len<-length(tab)
tab<-html_text(tab)
content<-c()
for(i in 1:len){
  tab1<-html_nodes(temp[i],"*")
  tab1<-html_text(tab1)
  content<-c(content,tab[i])
  content<-c(content,tab1)
}
content

#8-1
tab<-html_nodes(html,"table tr *")
tab1<-html_text(html_nodes(html,"table tr"),trim=T)
tab1
tab<-html_text(tab,trim=T)
tab

#9
tr<-html_nodes(html,"tr.name")
tr<-html_text(tr,trim=T)
tr

#10
td<-html_nodes(html,"#target")
td<-html_text(td,trim=T)
td
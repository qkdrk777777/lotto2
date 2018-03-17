assign('lottonum',read.csv('https://raw.githubusercontent.com/qkdrk777777/lotto2/master/lottonum.csv')[,-1])
#write.csv(lottonum,'lottonum.csv')
numdata<-function(first=1,last,num=list(),output=list(),k=1,update=F,sleep=1)
{ library(devtools)
  if(!require(lotto))install_github('qkdrk777777/lotto')
  package(progress); package('XML');  package('stringr');  package('rvest')

  pb<-progress_bar$new(total=(last-first))
  for(i in last:first){
    url<-paste0('https://search.naver.com/search.naver?sm=tab_drt&where=nexearch&query=',i,'%ED%9A%8C%EB%A1%9C%EB%98%90')
    lines<-read_html(url,encoding='UTF-8')
    keep<-html_nodes(lines,css='.num_box')%>% html_text()
    output[[k]]<-c(as.numeric(strsplit(str_trim(keep),split=" ")[[1]][1:6]),i)
    k=k+1
    Sys.sleep(sleep)
    pb$tick()
  }

  output<-matrix(unlist(output),ncol=7,byrow=T)
  colnames(output)=c('x1','x2','x3','x4','x5','x6','times')
  rownames(output)=output[,7]
  lottonum<-output

  if(update==T){if(i==first)devtools::use_data(lottonum, internal = F,overwrite=T)}
  return(output)}

data_update<-function(update=F){
  if(!require(devtools))install.packages('devtools')
  library(devtools)
  if(!require(DUcj))install_github('qkdrk777777/DUcj',force=T)
  library(DUcj)
  library(rvest)
  library(stringr)
  url<-'https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%A1%9C%EB%98%90&oquery=%EB%A1%9C%EB%98%90&tqi=TmrKidpVuFdsssc0EvVssssssUd-075322'
  line<-read_html(url,encoding="UTF-8")
  p1<-html_nodes(line,css='._lotto-btn-current em')%>%html_text()
  last=as.numeric(str_replace_all(p1,"[^0-9]",""))
  if(lottonum[1,7]<last)lottonum<-rbind(numdata(first=lottonum[1,7]+1,last=last),lottonum)
  if(update==T)devtools::use_data(lottonum, internal = F,overwrite=T)

  return(lottonum)
}
data_update()
data_update2<-function(data=data_update()){

  data2<-matrix(0,ncol=45,nrow=nrow(data));colnames(data2)=1:45
  for(i in 1:nrow(data2))
  {for(j in 1:6)
  {for(k in 1:45)
    if(data[i,j]==k)data2[i,k]<-1
  }}
  rownames(data2)<-nrow(data2):1
  lottonum2<<-data2
  return(data2)}
num_per<-function(data2=data_update2(),num_per=NULL){

  for(i in 1:45)num_per<-c(num_per,sum(data2[,i])/(6*nrow(data2)))
  names(num_per)=1:45
  return(num_per)}
del<-function(n=100,tol=1,keep=NULL,drop=NULL){
  per<-num_per()/num_per(data=type2data[1:n,])
  (del_num<-as.numeric(names(per[per<tol])))
  temp<-c(setdiff(del_num,keep),drop)
  temp<-temp[order(temp)]
  num<-num_per()
  num[temp]<-0
  return(num)}
lotto2<-function(n,count=1,keep=NULL,drop=NULL,hold=NULL,up=NULL,header=10,write=F)
{lottonum<- data_update()

t<-lotto1(n,keep=keep,drop=drop,hold=hold)
if(ncol(t)>7)t<-t[,-(8:ncol(t))]
for(i in 6:1)
  t<-t[order(t[,i]),]
t[,7]<-0
for(i in 1:(nrow(t)-1)){
  if(setequal(t[i,],t[(i+1),])){
    count=count+1
    t[i,7]<-count
  } else {count=1
  t[i,7]<-count
  }}
colnames(t)<-c(colnames(lottonum)[1:6],'count')
if(!is.null(up))out<-t[t[,7]>up,]else out<-head(t[order(t[,7],decreasing=T),],header)
output<-cbind(out[,1:6],times=lottonum[1,7]+1,out[,7,drop=F])
if(write==T)write.csv(output,'lotto.csv')
return(output)
}




library(shiny)
if(!require(devtools))install.packages('devtools') else library(devtools)
library(devtools)
#if(!require('DUcj'))devtools::install_github('qkdrk777777/DUcj',force=T)
library(DUcj)
#if(!require(lotto2))devtools::install_github('qkdrk777777/lotto2',force=T)
library(lotto2)

ui<-fluidPage(title='lotto sample',
              numericInput('drop','drop:',0,min=1,max=45),
              numericInput('keep','keep:',0,min=1,max=45),
              numericInput('hold','hold:',0,min=1,max=45),
              numericInput('n','n:',10,min=1,max=100000),
              numericInput('header','header',10,min=1,max=100),
              uiOutput('type2')
)
server<-function(input, output,session){

  output$type1<-renderDataTable({lotto2(drop=input$drop,keep=input$keep,
                                        hold=input$hold,n=input$n,
                                        header=input$header)})
output$type2<-renderUI({dataTableOutput('type1')})
}


shinyApp(ui,server)

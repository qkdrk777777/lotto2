#' generate lottodata
#'
#' @param t = url of list form
#' @param css = Nodes to select. Supply one of css or xpath depending on whether you want to use a css or xpath 1.0 selector.
#' @return
#' @examples
#'
#'
#' url<-paste0('https://search.naver.com/search.naver?sm=tab_drt&where=nexearch&query=',i,'%ED%9A%8C%EB%A1%9C%EB%98%90')
#'line<-read_html(url,encoding="UTF-8")
#'p1<-html_nodes(line,css='._lotto-btn-current em')%>%html_text()
#'last=as.numeric(substr(p1,1,3))
#' (data<-numdata(last=last))
#' @export
numdata<-function(first=1,last,num=list(),output=list(),k=1,update=F)
{library(DUcj)
  package('XML');  package('stringr');  package('rvest')
  for(i in last:first){
    lines<-read_html(url,encoding='UTF-8')
    keep<-html_nodes(lines,css='.num_box')%>% html_text()
    output[[k]]<-c(as.numeric(strsplit(str_trim(keep),split=" ")[[1]][1:6]),i)
    k=k+1
    Sys.sleep(2)}
  output<-matrix(unlist(output),ncol=7,byrow=T)
  colnames(output)=c('x1','x2','x3','x4','x5','x6','times')
  rownames(output)=output[,7]
  lottonum<-output
  if(update==T)devtools::use_data(lottonum, internal = F,overwrite=T)
  return(output)}
#numdata(first=790,last=792)



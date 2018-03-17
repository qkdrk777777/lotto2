#' generate lottodata
#'
#' @return
#' @examples
#'url<-'https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%A1%9C%EB%98%90&oquery=%EB%A1%9C%EB%98%90&tqi=TmrKidpVuFdsssc0EvVssssssUd-075322'
#'line<-read_html(url,encoding="UTF-8")
#'p1<-html_nodes(line,css='._lotto-btn-current em')%>%html_text()
#'last=as.numeric(substr(p1,1,3))
#' (data<-numdata(last=last,update=T,sleep=0))
#' @export
numdata<-function(first=1,last,num=list(),output=list(),k=1,update=F,sleep=1)
{ library(devtools)
  if(!require(lotto))install_github('qkdrk777777/lotto')
  package(progress); package('XML');  package('stringr');  package('rvest')
  pb<-progress_bar$new(total=(last-first))
  for(i in last:first){
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




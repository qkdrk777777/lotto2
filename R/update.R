#' update lotto data
#'
#' @return lotto data
#' @examples
#' data_update(update=TRUE)
#' data_update()
#' lottonum
#' @export
data_update<-function(update=F){
  if(!require(devtools))install.packages('devtools')
  library(devtools)
  if(!require(DUcj))install_github('qkdrk777777/DUcj',force=T)
  library(DUcj)
  package(rvest)
  package(stringr)
  url<-'https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%A1%9C%EB%98%90&oquery=%EB%A1%9C%EB%98%90&tqi=TmrKidpVuFdsssc0EvVssssssUd-075322'
  line<-read_html(url,encoding="UTF-8")
  p1<-html_nodes(line,css='._lotto-btn-current em')%>%html_text()
  last=as.numeric(str_replace_all(p1,"[^0-9]",""))
  if(lottonum[1,7]<last)lottonum<-rbind(numdata(first=lottonum[1,7]+1,last=last),lottonum)
  if(update==T)devtools::use_data(lottonum, internal = F,overwrite=T)

  return(lottonum)
}


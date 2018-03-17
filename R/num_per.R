#' Probability of a number
#'
#' @param none
#' @examples
#' per<-num_per()/num_per(data=data_update2()[1:100,])
#' (del_num<-as.numeric(names(per[per<1])))
#' round(cor(data2),3)
#' @export
num_per<-function(data2=data_update2(),num_per=NULL){

  for(i in 1:45)num_per<-c(num_per,sum(data2[,i])/(6*nrow(data2)))
  names(num_per)=1:45
  return(num_per)}

#library(roxygen2)
#library(devtools)
#devtools::document()

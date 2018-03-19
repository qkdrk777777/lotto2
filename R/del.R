#' delete of number
#'
#' @param n = Number to consider.
#' @param tol =Range of absolute values
#' @return
#' @export
del<-function(n=100,tol=1,keep=NULL,drop=NULL){
  data_update2()
  per<-num_per()/num_per(data=type2data[1:n,])
  (del_num<-as.numeric(names(per[per<tol])))
  temp<-c(setdiff(del_num,keep),drop)
  temp<-temp[order(temp)]
  num<-num_per()
  num[temp]<-0
  return(num)}

#del()

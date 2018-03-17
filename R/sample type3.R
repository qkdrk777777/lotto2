#' lotto
#'
#' @param n = The number of times the sample is pulled
#' @examples lot(1000)
#' @return
#' @export
lotto3<-function(n,a=NULL,b=NULL,head=10,write=F){
  lottonum<-data_update()
  package(progress)
  num<-num_per()/num_per(data=type2data[1:100,])
  del1<-round(num_per()*num,10)
  pb<-progress_bar$new(total=n)
  for(i in 1:n){
    a<-c(sort(sample(1:45,6,prob=del1)),data[1,7]+1,1)
    if(length(b)==0)b<-rbind(b,a)else{
      for(j in 1:nrow(b)-1){
        if(setequal(b[j,1:6],a[1:6]))b[j,8]<-b[j,8]+1}
      b<-rbind(b,a)}
    pb$tick()
    Sys.sleep(0.001)
  }
  for(i in c(6:1,8)){if(i==8) b<-b[order(b[,i],decreasing = T),] else b<-b[order(b[,i]),]}
  rownames(b)<-1:nrow(b)
  colnames(b)<-c(colnames(lottonum),'count')
  if(length(head)!=0)output<-head(b,head) else output<-b
  if(write==T)write.csv(output,'lotto.csv')
  return(output)
}


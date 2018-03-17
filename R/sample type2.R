#' sample2
#'
#' @param n = The number of times the sample is pulled
#' @param keep = The number to keep the probability of
#' @param drop =The number corresponding to 'drop' does not appear.
#' @param hold =This number appears unconditionally.
#' @examples (k<-sort(num_per()[as.numeric(data[1,1:6])],dec=T))
#' lotto2(n=100,hold=as.numeric(names(k[1])),header=10)
#' @return
#' @export
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


#' sample type1
#'
#' @param n = number of sample
#' @examples lotto1(5)
#' (k<-sort(num_per()[as.numeric(data[1,1:6])],dec=T))
#' lotto1(n=5,keep=k[1])
#' lotto1(n=50000,hold=as.numeric(names(k[1])))
#' @return
#' @export
lotto1<-function(n,keep=NULL,drop=NULL,hold=NULL,a=NULL,write=F,wd=NULL){
  lottonum<-data_update()
  pb<-progress_bar$new(total=n)

  if(length(hold)==0){del2<-del(keep=keep,drop=drop)
  for(i in 1:n){a<-rbind(a,sort(sample(1:45,6,prob=del2)))
  pb$tick()
    }
  }else {del2<-del(keep=keep,drop=unique(c(hold,drop)))
    for(i in 1:n){a<-rbind(a,sort(c(hold,sample(1:45,(6-length(hold)),prob=del2))))
  pb$tick()
  }
  }
  output<-cbind(a,data[1,7]+1)
  colnames(output)<-colnames(lottonum)
if(write==T)write.csv(output,paste0(wd,'lotto.csv'))
return(output)}
#lotto1(100)

#setwd('C:/Users/qkdrk/Desktop/새 폴더')
#lottosample(1000,write=T)

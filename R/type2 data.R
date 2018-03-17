#' generate lottodata2
#'
#' @return lotto data2
#' @examples
#' data2<-data_update2()
#' round(cor(data2),3)
#' @export
data_update2<-function(data=data_update()){
  lottonum<<-data
  data2<-matrix(0,ncol=45,nrow=nrow(data));colnames(data2)=1:45
  for(i in 1:nrow(data2))
  {for(j in 1:6)
  {for(k in 1:45)
    if(data[i,j]==k)data2[i,k]<-1
  }}
  rownames(data2)<-nrow(data2):1
  return(data2)}
#type2data<-data_update2()
#devtools::use_data(type2data, internal = F,overwrite=T)

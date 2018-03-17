#' check the lotto number
#'
#' @param a = data
#' @examples lottocheck(head(lottonum,4)[-1,])
#' @return
#' @export
lottocheck<-function(a)
{if(colnames(a[,7,drop=F])!='times')stop('The seventh column name in the data is not times.')
  for(i in 1:nrow(a)){if(length(setdiff(a[i,],data[data[,7]==a[i,7],]))==0)print(paste('first Win the lotto.',toString(a[i,1:6],collase=',')))
  else if(length(setdiff(a[i,],data[data[,7]==a[i,7],]))==1)print(paste('second or third Win the lotto.',toString(a[i,1:6],collase=',')))
  else if(length(setdiff(a[i,],data[data[,7]==a[i,7],]))==2)print(paste('Fourth Win the lotto.',toString(a[i,1:6],collase=',')))
  else if(length(setdiff(a[i,],data[data[,7]==a[i,7],]))==3)print(paste('5th Win the lotto.',toString(a[i,1:6],collase=',')))}}
#


#setwd('D:/packages/lotto')

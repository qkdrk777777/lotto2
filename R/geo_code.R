#' geo_code
#'
#' @param address is character value.
#' @export
geo_code<-function(address,b=NULL){
  if(!require(RJSONIO))install.packages('RJSONIO')
  if(!require(RCurl))install.packages('RCurl')

  for(i in 1:length(address)){
    url<-URLencode(paste('http://maps.google.com/maps/api/geocode/json?address=',address[i],'&sensor=false',sep= ''))
    url<-getURL(url)
    x<-fromJSON(url,simplify = F)
    if(x$status=="OK"){
      lat<-x$results[[1]]$geometry$location$lat
      lng<-x$results[[1]]$geometry$location$lng
      a<-data.frame(lat,lng)
      Sys.sleep(1)
    }else a<-data.frame(lat=NA,lng=NA)
    b<-rbind(b,a)  }
  return(b)
}

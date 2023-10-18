# example: we compute the number off outliers of each type int a list of time series
# obvious extension: keep/display the names/coefficients of the outliers
extract_outlier<-function(result, type){
  vars<-result$description$variables
  if (! is.null(vars)){
    if (length(vars) == 0)
      return (NULL)
    else
      return (vars[sapply(vars,function(x)x$type==type)])
    }else
    return (NULL)
}

tramo_outliers<-function(data, spec="trfull"){
  models<-lapply(data, function(s){return (rjd3tramoseats::tramo_fast(s, spec))})
  return (extract_all_outliers(models))
}

extract_all_outliers<-function(models){
  ao<-lapply(models, function(m){extract_outlier(m, 'AO')})
  ls<-lapply(models, function(m){extract_outlier(m, 'LS')})
  tc<-lapply(models, function(m){extract_outlier(m, 'TC')})
  so<-lapply(models, function(m){extract_outlier(m, 'SO')})
  outliers=cbind(sapply(ao, length), sapply(ls, length),sapply(tc, length),
                 sapply(so, length))
  outliers<-`colnames<-`(outliers,c("AO", "LS", "TC", "SO"))
  return (outliers)
}

all<-tramo_outliers(rjd3toolkit::retail)
print(all)

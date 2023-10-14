
ucm_estimate<-function(x, ucm, stdev=TRUE){
  jucm<-rjd3toolkit:::.r2jd_ucarima(ucm)
  jcmps<-rJava::.jcall("jdplus/toolkit/base/r/arima/UcarimaModels", "Ljdplus/toolkit/base/api/math/matrices/Matrix;", "estimate",
                       as.numeric(x), jucm, as.logical(stdev))
  return (rjd3toolkit:::.jd2r_matrix(jcmps))
}

arima_difference<-function(left, right){
  jleft<-rjd3toolkit:::.r2jd_arima(left)
  jright<-rjd3toolkit:::.r2jd_arima(right)
  jdiff<-rJava::.jcall(jleft, "Ljdplus/toolkit/base/core/arima/ArimaModel;", "minus", jright, TRUE)
  return (rjd3toolkit:::.jd2r_arima(jdiff))
}

airline_decomposition<-function(period, th, bth){
  sarima<-rjd3toolkit::sarima_model("m", period, NULL, 1, th, NULL, 1, bth)
  return (rjd3tramoseats::seats_decompose(sarima))
}

ar_decomposition<-function(period, phi, bphi){
  sarima<-rjd3toolkit::sarima_model("m", period, phi = phi, bphi = bphi)
  return (rjd3tramoseats::seats_decompose(sarima))
}

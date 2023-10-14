source("R/utility.R")

airline_variances<-function(period, th, bth){
  ucm<-airline_decomposition(period, th, bth)
  if (is.null(ucm)) return (c(NA, NA, NA)) else return (c(ucm$components[[1]]$var,
                                                          ucm$components[[2]]$var,
                                                          ucm$components[[3]]$var))
}

airline_model_spectrum<-function(period, th, bth){
  ucm<-airline_decomposition(period, th, bth)

  trend<-rjd3toolkit::arima_properties(ucm$components[[1]], nspectrum = 6001)$spectrum
  seasonal<-rjd3toolkit::arima_properties(ucm$components[[2]], nspectrum = 6001)$spectrum
  irregular<-rjd3toolkit::arima_properties(ucm$components[[3]], nspectrum = 6001)$spectrum

  plot(trend, ylim=c(0,2), type='l', col="red")
  lines(seasonal, col="blue")
  lines(irregular, col="gray")

}

airline_estimator_spectrum<-function(period, th, bth){
  ucm<-airline_decomposition(period, th, bth)

  trend<-rjd3toolkit::ucarima_wk(ucm, 1, nspectrum = 6001)$spectrum
  seasonal<-rjd3toolkit::ucarima_wk(ucm, 2, nspectrum = 6001)$spectrum
  irregular<-rjd3toolkit::ucarima_wk(ucm, 3, nspectrum = 6001)$spectrum

  plot(trend, ylim=c(0,2), type='l', col="red")
  lines(seasonal, col="blue")
  lines(irregular, col="gray")

}

airline_spectrum<-function(period, cmp, th, bth, signal = T, slim=2){
  ucm<-airline_decomposition(period, th, bth)

  if (signal)
    arima<-ucm$components[[cmp]]
  else {
    cmps<-(1:3)[-cmp]
    arima<-rjd3toolkit::arima_sum(ucm$components[[cmps[1]]], ucm$components[[cmps[2]]])
  }

  model<-rjd3toolkit::arima_properties(arima, nspectrum = 6001)$spectrum
  estimator<-rjd3toolkit::ucarima_wk(ucm, cmp, signal = signal, nspectrum = 6001)$spectrum

  freq<-(1:6001)*(pi/6001)

  spectrum<-cbind(estimator, model)

  matplot(spectrum, x=freq, ylim=c(0,slim), type='l', col=c("red", "gray"))
  legend("top", inset=.1, legend=c("estimator", "model"), col=c("red", "gray"), lty=1:2)
}

ar_spectrum<-function(period, cmp, phi, bphi, signal = T, slim=2){
  ucm<-ar_decomposition(period, phi, bphi)

  if (signal)
    arima<-ucm$components[[cmp]]
  else {
    cmps<-(1:3)[-cmp]
    arima<-rjd3toolkit::arima_sum(ucm$components[[cmps[1]]], ucm$components[[cmps[2]]])
  }

  model<-rjd3toolkit::arima_properties(arima, nspectrum = 6001)$spectrum
  estimator<-rjd3toolkit::ucarima_wk(ucm, cmp, signal = signal, nspectrum = 6001)$spectrum

  freq<-(1:6001)*(pi/6001)

  spectrum<-cbind(estimator, model)

  matplot(spectrum, x=freq, ylim=c(0,slim), type='l', col=c("red", "gray"))
  legend("top", inset=.1, legend=c( "estimator", "model"), col=c("red", "gray"), lty=1:2)
}

#for (i in -1:9)airline_model_spectrum(12,-.1*i,-.5)
#for (i in -1:9)airline_estimator_spectrum(12,-.1*i,-.5)
airline_spectrum(12, 1, -.1,-.6, T, .2)
airline_spectrum(12, 2, -.1,-.6, T, .2)
airline_spectrum(12, 3, -.1,-.6, T, .2)
airline_spectrum(12, 2, -.1,-.6, F, .2)
ar_spectrum(12, 1, -.8,-.9, T, .2)
ar_spectrum(12, 2, -.8,-.9, T, .2)
ar_spectrum(12, 3, -.8,-.9, T, .2)
ar_spectrum(12, 2, -.8,-.9, F, .2)


# Gets the variances of the canonical decomposition for airline models with different parameters
vars<-sapply(seq(.3, -.99, -.01), function(bth){return (airline_variances(12,-.5, bth))})

# trend
matplot(t(vars), type = 'b', pch=18)

ucm1<-airline_decomposition(23,-.8,-.7)

twk1<-rjd3toolkit::ucarima_wk(ucm1, 1)
plot(twk1$gain2, type='l')

ucm2<-airline_decomposition(23,.2,-.7)

twk2<-rjd3toolkit::ucarima_wk(ucm2, 1, T, 1200)
lines(twk2$gain2, col="blue")

mucm<-airline_decomposition(12,-.8,-.7)

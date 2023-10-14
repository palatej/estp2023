source("R/utility.R")

hp_ucm<-function(lambda=1600){
  i2<-rjd3toolkit::arima_model("trend", delta = c(1, -2, 1))
  noise<-rjd3toolkit::arima_model(variance=lambda)
  ucm<-rjd3toolkit::ucarima_model(components=list(i2, noise))

  return (ucm)
}


hp_estimate<-function(s, lambda=1600, saSpec=NULL, useTrend=TRUE){
  ucm<-hp_ucm(lambda = lambda)
  if (!is.null(saSpec)){
    sa<-rjd3tramoseats::tramoseats_fast(s, saSpec)
    if (useTrend) s<-sa$final$t$data else s<-sa$final$sa$data
  }

  rslt<-ucm_estimate(s, ucm)

  return (list(options=c(lambda=lambda, trend=useTrend, sa=saSpec), sa=sa, hp=rslt))
}

s<-log(rjd3toolkit::ABS$X0.2.05.10.M)
q<-hp_estimate(s, lambda = 120000, saSpec = "rsa0")
plot(q$hp[,2], type='h', ylab="cycle")
matplot(cbind(s, q$hp[,1], q$sa$final$t$data), type='l', col=c('lightgray', 'blue', 'red'), ylab='logs')
legend("topleft", inset=.1, legend=c( "raw", "trend", "tc"), col=c('lightgray', 'blue', 'red'), lty=1:3)


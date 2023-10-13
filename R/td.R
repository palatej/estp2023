# recall:
# H0: the coefficients of the trading days are jointly 0 (= no trading days effects)
# if p-value is small, we reject H0. There are trading days effects

s<-rjd3toolkit::ABS$X0.2.20.10.M
#s<-rjd3toolkit::retail$RetailSalesTotal

td_all<-function(s, title, len=length(s)/12){
  a<-sapply(6:len, function(j){rjd3toolkit::td_f(s, model = "D1", nyears = j)$pvalue})
  b<-sapply(6:len, function(j){rjd3toolkit::td_f(s, model = "R011", nyears = j)$pvalue})
  c<-sapply(6:len, function(j){rjd3toolkit::td_f(s, model = "R100", nyears = j)$pvalue})

  matplot(main=title, x=6:len, y=cbind(a,b,c), pch=19, col=c('black', 'blue', 'red'),
          xlab="number of years", ylab="p-value")
}

# seasonal adjustment with calendar effects correction
sa<-rjd3tramoseats::tramoseats_fast(s, "rsafull")
# seasonal adjustment without calendar effects correction
sa2<-rjd3tramoseats::tramoseats_fast(log(s), "rsa0")

ssa<-sa$decomposition$stochastics$sa$data
ssa2<-sa2$decomposition$stochastics$sa$data

td_all(ssa, "sa - rasafull")
td_all(ssa2, "sa - rsa0")

sirr<-sa$decomposition$stochastics$i$data
sirr2<-sa2$decomposition$stochastics$i$data

td_all(sirr, "irregular - rsafull")
td_all(sirr2, "irregular - rsa0")



td_tests<-function(s, spec="rsafull"){
  sa<-rjd3tramoseats::tramoseats_fast(s, spec)
  ssa<-sa$decomposition$stochastics$sa$data
  tsa<-rjd3toolkit::td_f(ssa, model = "D1")
  si<-sa$decomposition$stochastics$i$data
  tsi<-rjd3toolkit::td_f(si, model = "WN")

  return (list(sa=tsa, i=tsi))
}

# processing with TD correction, D1 on SA, WN on I
td_all<-lapply(rjd3toolkit::retail, function(z){td_tests(z)})
notd_all<-lapply(rjd3toolkit::retail, function(z){td_tests(log(z), "rsa0")})


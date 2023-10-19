s<-rjd3toolkit::retail$RetailSalesTotal

spec<-rjd3tramoseats::tramoseats_spec("rsafull")
spec$tramo$regression$td$auto<-"AUTO_BIC"
sa_tramoseats<-rjd3tramoseats::tramoseats_fast(s, spec)

xspec<-rjd3x13::x13_spec("rsa4")
xspec$regarima$regression$td$auto<-"AUTO_BIC"
sa_x13<-rjd3x13::x13_fast(s, xspec)

print(sa_tramoseats$preprocessing)
print(sa_x13$preprocessing)

plot(sa_tramoseats)
plot(sa_x13)

sa_x13c<-rjd3x13::x13_fast(s, xspec, userdefined = c('decomposition.b7', 'decomposition.c7'))

plot(sa_x13$decomposition$d9, type='h')


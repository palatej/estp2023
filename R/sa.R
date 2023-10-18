s<-rjd3toolkit::retail$RetailSalesTotal

spec<-rjd3tramoseats::tramoseats_spec("rsafull")
spec$tramo$regression$td$auto<-"AUTO_BIC"
sa_tramoseats<-rjd3tramoseats::tramoseats_fast(s, spec)

spec<-rjd3x13::x13_spec("rsa4")
spec$regarima$regression$td$auto<-"AUTO_BIC"
sa_x13<-rjd3x13::x13_fast(s, spec)

print(sa_tramoseats$preprocessing)
print(sa_x13$preprocessing)

plot(sa_tramoseats)
plot(sa_x13)

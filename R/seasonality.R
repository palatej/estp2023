

s<-rjd3toolkit::retail$RetailSalesTotal
ls<-log(s)
st<-rjd3toolkit::do_stationary(ls, 12)
dls<-st$ddata

spec.pgram(dls)

spec.ar(dls)

print(rjd3toolkit::seasonality_qs(dls, 12))

# H0: the series has no seasonality
# pvalue = prob[x>T]
# pvalue nearly 0 -> w reject H0

print(rjd3toolkit::seasonality_kruskalwallis(dls, 12))

print(rjd3toolkit::seasonality_friedman(dls, 12))

print(rjd3toolkit::seasonality_f(ls, 12, "D1"))


# !!!

print(rjd3toolkit::seasonality_qs(1:120, 12))

print(rjd3toolkit::seasonality_friedman(1:120, 12))

# Other tests: uroot
# Canova-Hansen
# H0: stable seasonality

library(uroot)

dls<-ts(dls, frequency = frequency(ls), start = start(ls)+c(0,1))
print(uroot::ch.test(dls ))
plot(dls)

rjd3providers::set_spreadsheet_paths("C:/estp/estp2023/data")
rjd3providers::spreadsheet_content("belgium.xlsx")
be_x<-rjd3providers::spreadsheet_data("belgium.xlsx", 2)
lapply(be_x$series, function(s)rjd3toolkit::seasonality_f(s$data, 12, "D1"))
be_m<-rjd3providers::spreadsheet_data("belgium.xlsx", 3)
lapply(be_m$series, function(s)rjd3toolkit::seasonality_f(s$data, 12, "D1"))

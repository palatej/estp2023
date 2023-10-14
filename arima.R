ar1<-rjd3toolkit::arima_model("ar", ar = c(1, -.9))
ar1_props<-rjd3toolkit::arima_properties(ar1)

plot(ar1_props$spectrum, type='l')

rw<-rjd3toolkit::arima_model("rw", delta = c(1, -1))
rw_props<-rjd3toolkit::arima_properties(rw)

lines(rw_props$spectrum, col='red')

i2<-rjd3toolkit::arima_model("i2", delta = c(1, -2, 1))
i2_props<-rjd3toolkit::arima_properties(i2)

lines(i2_props$spectrum, col='blue')

i4<-rjd3toolkit::arima_model("i4", delta = c(1, -4, 6, -4, 1))
i4_props<-rjd3toolkit::arima_properties(i4)

lines(i4_props$spectrum, col='magenta')

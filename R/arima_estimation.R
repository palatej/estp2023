# JD+
N<-100
y=log(rjd3toolkit::ABS$X0.2.09.10.M)
print(system.time(for (i in 1:N) {  j<-rjd3toolkit::sarima_estimate(y, order=c(2,1,1),
          seasonal = list(order=c(0,1,1), period=12))}))
#R-native
print(system.time(for (i in 1:N) {  r<-arima(y, order=c(2,1,1),
          seasonal = list(order=c(0,1,1), period=12))}))

print(j)
print(j$likelihood$ll)
print(r)

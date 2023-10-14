source("R/utility.R")

airline<-function(period, th, bth){
  model<-rjd3toolkit::sarima_model("airline", period=period, d=1, bd=1, theta = th, btheta = bth)
  return (model)
}

model<-airline(12, -.7, -.1)
ucm<-rjd3toolkit::sarima_decompose(model)

y<-rjd3toolkit::retail$ShoeStores

sa<-rjd3tramoseats::tramoseats_fast(y, "rsa0")

q<-ucm_estimate(y, ucm)

t<-q[,1]
s<-q[,2]
i<-q[,3]

sa<-t+i

print(rjd3toolkit::seasonality_qs(i, 12, 4))

par(mfrow=c(2,1))

M<-max(c(y,t,sa))
m<-min(c(y,t,sa))

plot(as.numeric(y), type='l', col='gray', ylim=c(m, M))
lines(sa, col='blue')
lines(t, col='red')
grid()

plot(i, type='l', col='magenta')

par(mfrow=c(1,1))

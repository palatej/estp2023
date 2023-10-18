rjd3providers::set_spreadsheet_paths('./Data')
#print(rjd3providers::spreadsheet_content("belgium.xlsx"))
xbe<-rjd3providers::spreadsheet_data('belgium.xlsx', 2)

s<-xbe$series$France$data
s<-xbe$series$Netherlands$data
#s<-xbe$series$Lithuania$data

#s<-rjd3toolkit::retail$DepartmentStoresExclDiscountDepa
rslt<-rjd3tramoseats::tramoseats_fast(s, 'rsafull')
sa<-rslt$final$sa$data
csa<-rslt$decomposition$stochastics$sa$data
esa<-rslt$decomposition$stochastics$sa$data.stde

if (rslt$preprocessing$description$log){
  v <- esa*esa
  esa<-exp(csa + 0.5*v)*sqrt(exp(v)-1)
}

xrslt<-rjd3x13::x13_fast(s, 'rsa5')
xsa<-xrslt$final$d11final

library(ggplot2)

#number of points
n<-60
#number of stdev
m<-2
w<-data.frame(date=rjd3toolkit::daysOf(s)[1:n],
              y=as.numeric(s)[1:n],
              sa=as.numeric(sa)[1:n],
              xsa=as.numeric(xsa)[1:n],
              min=as.numeric(sa-m*esa)[1:n],
              max=as.numeric(sa+m*esa)[1:n])

p<-ggplot(data=w) +
  geom_line(aes(x=date, y=y), color='black') +
  geom_line(aes(x=date, y=sa), color='red') +
  geom_line(aes(x=date, y=xsa), color='green') +
  geom_ribbon(aes(x=date, ymin=min, ymax=max), alpha=.2)
print(p)


rjd3providers::set_spreadsheet_paths('./Data')
print(rjd3providers::spreadsheet_content("belgium.xlsx"))

indprod<-rjd3providers::spreadsheet_data('belgium.xlsx', 1)
plot(indprod$series$`Manufacture of textiles`$data, col='blue')

errs<-lapply(indprod$series, function(z)rjd3tramoseats::terror(z$data, 'tr1', nback=24))


err<-errs$`Manufacture of food products`

library(ggplot2)

w<-data.frame(date=rjd3toolkit::daysOf(err[,1]), y=as.numeric(err[,5]),
              fcasts=as.numeric(err[,6]),
              min=as.numeric(err[,6]-2*err[,7]),
              max=as.numeric(err[,6]+2*err[,7]))

p<-ggplot(data=w) +
  geom_line(aes(x=date, y=fcasts), color='blue') +
  geom_line(aes(x=date, y=y), color='red') +
  geom_ribbon(aes(x=date, ymin=min, ymax=max), alpha=.2)
print(p)



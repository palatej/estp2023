rjd3providers::set_spreadsheet_paths('./Data')
print(rjd3providers::spreadsheet_content("belgium.xlsx"))

indprod<-rjd3providers::spreadsheet_data('belgium.xlsx', 1)
plot(indprod$series$`Manufacture of textiles`$data, col='blue')

err<-lapply(indprod$series, function(z)rjd3tramoseats::terror(z$data, 'tr1', nback=6))


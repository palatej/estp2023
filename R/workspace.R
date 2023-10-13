jws<-rjdemetra3::.jws_load(system.file('workspaces', 'test.xml', package='rjdemetra3'))
ws<-rjdemetra3::read_workspace(jws)
jws2<-rjdemetra3::.jws_make_copy(jws)
rjd3providers::set_spreadsheet_paths("c:/localdata/data/excel/new")
rjdemetra3::.jws_refresh(jws2, 'Complete')
ws2<-rjdemetra3::read_workspace(jws2)

sa1<-ws$processing$`SAProcessing-1`$`Exports
France`
sa2<-ws2$processing$`SAProcessing-1`$`Exports
France`
ts.plot(ts.union(sa1$results$final$sa$data, sa2$results$final$sa$data), col=c('red', 'blue'))
print(window(sa2$results$final$series$data-sa1$results$final$serie$data, start=2018))

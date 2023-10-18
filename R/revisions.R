s<-rjd3toolkit::retail$ShoeStores
policy<-"Fixed"

spec<-rjd3tramoseats::tramoseats_spec("rsa0")
spec$tramo$regression$mean<-NULL
sa<-rjd3tramoseats::tramoseats(s, spec)
nspec<-rjd3tramoseats::tramoseats_refresh(sa$result_spec, NULL,policy)

ts_ids<-list(list(period="2006-01-01", start="2006-01-01", id="sa"), list(period="2006-01-01", start="2006-01-01", id="i"))
rh<-rjd3tramoseats::tramoseats_revisions(s, nspec, ts_ids = ts_ids)

plot(rh$series$sa, type='l')

# or, equivalently in this case
nspec2<-rjd3tramoseats::tramoseats_refresh(sa$result_spec, sa$estimation_spec, policy)
# this is actually what is done in the graphical interface
rh2<-rjd3tramoseats::tramoseats_revisions(s, nspec2, ts_ids = ts_ids)

# same result
summary(rh$series$i-rh2$series$i)

cmp_ids<-list(list(start="2006-01-01", end="2010-12-31", id="sa"), list(start="2006-01-01", end="2010-12-31", id="t"))
rh3<-rjd3tramoseats::tramoseats_revisions(s, nspec, ts_ids =  ts_ids,cmp_ids =  cmp_ids)


csa<-rh3$components$sa
d<-dim(csa)
#we compare each vintage with the last one. Up to you to choose the way you compare them
rcsa_ts<-100*(csa/csa[,d[2]]-1)

plot(rcsa_ts[,1])

#comparison of the first and last estimations (what is done in the graphical interface)
diff<-diag(rcsa_ts[(d[1]-d[2]+1):d[1],])
diff<-diff[-length(diff)]
print(diff)
summary(diff)

# same with x13

sa<-rjd3x13::x13(s, "rsa0")
nspec<-rjd3x13::x13_refresh(sa$result_spec, NULL, policy)

ts_ids<-list(list(period="2006-01-01", start="2006-01-01", id="sa"), list(period="2006-01-01", start="2006-01-01", id="i"))
rh<-rjd3x13::x13_revisions(s, nspec, ts_ids = ts_ids)

plot(rh$series$sa, type='l')

cmp_ids<-list(list(start="2006-01-01", end="2010-12-31", id="sa"), list(start="2006-01-01", end="2010-12-31", id="t"))
rh3<-rjd3x13::x13_revisions(s, nspec, NULL, ts_ids, cmp_ids)


csa<-rh3$components$sa
d<-dim(csa)
#we compare each vintage with the last one. Up to you to choose the way you compare them
rcsa_x13<-100*(csa/csa[,d[2]]-1)

plot(rcsa_x13[,1])
lines(rcsa_ts[,1], col='red')


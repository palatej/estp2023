# default calendars

BE <- rjd3toolkit::national_calendar(list(
  rjd3toolkit::fixed_day(7,21),
  rjd3toolkit::special_day('NEWYEAR'),
  rjd3toolkit::special_day('CHRISTMAS'),
  rjd3toolkit::special_day('MAYDAY'),
  rjd3toolkit::special_day('EASTERMONDAY'),
  rjd3toolkit::special_day('ASCENSION'),
  rjd3toolkit::special_day('WHITMONDAY'),
  rjd3toolkit::special_day('ASSUMPTION'),
  rjd3toolkit::special_day('ALLSAINTSDAY'),
  rjd3toolkit::special_day('ARMISTICE')))
be_cal<-rjd3toolkit::calendar_td(BE, 12, c(2000,1), 60, holiday=7, groups=c(1,1,1,2,2,3,0),
            contrasts = FALSE)
print(be_cal)

DEF <- rjd3toolkit::national_calendar(list())
def_cal<-rjd3toolkit::calendar_td(DEF, 12, c(2000,1), 60, holiday=7, groups=c(1,1,1,2,2,3,0),
                                 contrasts = FALSE)
print(def_cal)


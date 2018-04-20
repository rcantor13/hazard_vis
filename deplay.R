#deploy

library(rsconnect)

rsconnect::setAccountInfo(name='rcantor',
                          token='2758AF370CADEAFCDBD6FAFCD2A1132E',
                          secret='blEOQYBYFQfiLU8a3sAvzkDnaHoCoB4jlaT0A9jt')
library(rsconnect)
rsconnect::deployApp("C:/Users/rcantor/Desktop/Online Hazard tool/Haz Vis")


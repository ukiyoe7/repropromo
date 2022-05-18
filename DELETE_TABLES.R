library(DBI)
library(dplyr)


con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)


## CLEAN TABLE PROD 2085

query4 <- paste("DELETE FROM TBPPRODU WHERE TBPCODIGO=2085")
dbSendQuery(con3,query4)


tabpromo_2 <- dbGetQuery(con2,"SELECT TBPCODIGO FROM TABPRECO WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%'
                             AND TBPTABCOMB='S'") 

View(tabpromo_2)


## CLEAN TABLE CLIENTS



z <- data.frame(TBPCODIGO=NA,PROCODIGO=NA,
                TBPPCDESCTO2=NA,TBPPCDESCTO=NA)

for (i in 1:nrow(x)) {
  z[i,] <- x[i,]
  queryy <- paste("DELETE FROM CLITBP WHERE TBPCODIGO=",z[i,"TBPCODIGO"],",'",z[i,"PROCODIGO"],"',",z[i,"TBPPCDESCTO2"],",",z[i,"TBPPCDESCTO"],")",sep = "")
  
  dbSendQuery(con3,queryy)
  
}
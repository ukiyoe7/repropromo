library(DBI)
library(dplyr)


con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)
con2 <- dbConnect(odbc::odbc(), "reproreplica", timeout = 10)


## CLEAN TABLE PROD 2085

query4 <- paste("DELETE FROM TBPPRODU WHERE TBPCODIGO=2085")
dbSendQuery(con3,query4)


tabpromo_2 <- dbGetQuery(con2,"SELECT TBPCODIGO FROM TABPRECO WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%'
                             AND TBPTABCOMB='S'") 

View(tabpromo_2)


## CLEAN TABLE CLIENTS

clipromo2 <- dbGetQuery(con2,"
                         WITH TB AS(
                         SELECT TBPCODIGO FROM TABPRECO WHERE TBPDESCRICAO='PROMO DO MES JUL-AGO 22')
                         
                         SELECT DISTINCT C.TBPCODIGO FROM CLITBP C
                         INNER JOIN TB ON C.TBPCODIGO=TB.TBPCODIGO") 

q <- data.frame(TBPCODIGO=NA)



for (i in 1:nrow(clipromo2)) {
  q[i,] <- clipromo2[i,]
  queryq <- paste("DELETE FROM CLITBP WHERE TBPCODIGO=",q[i,"TBPCODIGO"],";",sep = "")
  dbSendQuery(con3,queryq)
}


## CLEAN TABLE 

clitbpcomb5 <- dbGetQuery(con2,"
                         WITH TB AS(
                         SELECT TBPCODIGO FROM TABPRECO WHERE TBPDESCRICAO='PROMO DO MES JUL-AGO 22' AND TBPTABCOMB='S')
                         
                         SELECT DISTINCT C.TBPCODIGO FROM CLITBPCOMB C
                         INNER JOIN TB ON C.TBPCODIGO=TB.TBPCODIGO
                         ") 

View(clitbpcomb5)

q <- data.frame(TBPCODIGO=NA)



for (i in 1:nrow(clitbpcomb5)) {
  q[i,] <- clitbpcomb5[i,]
  queryq <- paste("DELETE FROM CLITBPCOMB WHERE TBPCODIGO=",q[i,"TBPCODIGO"],";",sep = "")
  dbSendQuery(con3,queryq)
}

## clean clitbp2085

query5 <- paste("DELETE FROM CLITBP WHERE TBPCODIGO=2085")
dbSendQuery(con3,query5)


## clean clitbp22

query6 <- paste("DELETE FROM CLITBPCOMB WHERE TBPCODIGO=22")
dbSendQuery(con3,query6)


## clean clitbp22

query6 <- paste("DELETE FROM TBPCOMBPROPRO WHERE TBPCODIGO=22")
dbSendQuery(con3,query6)


EVALUATE
CROSSJOIN(CLICONFLIT,COMB_PROMO)


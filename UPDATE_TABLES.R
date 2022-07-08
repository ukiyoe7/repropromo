

library(DBI)
library(dplyr)

con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)


con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)

query1 <- paste("UPDATE TABPRECO SET TBPDESCRICAO='PROMO DO MES JUL-AGO 22' 
                WHERE TBPDESCRICAO LIKE '%PROMO DO MES JUN-JUL 22%'")
dbSendQuery(con3,query1)

query2 <- paste("UPDATE TABPRECO SET TBPDTVALIDADE='31.08.2022' 
                WHERE TBPDESCRICAO LIKE '%PROMO DO MES JUL-AGO 22%'")
dbSendQuery(con3,query2)

query3 <- paste("UPDATE TABPRECO SET TBPDTINICIO='06.07.2022' 
                WHERE TBPDESCRICAO LIKE '%PROMO DO MES JUL-AGO 22%'")
dbSendQuery(con3,query3)
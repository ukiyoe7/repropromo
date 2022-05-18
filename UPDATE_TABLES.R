

library(DBI)
library(dplyr)


con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)

query1 <- paste("UPDATE TABPRECO SET TBPDESCRICAO='PROMO DO MES MAI-JUN 22' 
                WHERE TBPDESCRICAO LIKE '%PROMO DO MES ABR-MAI 22%'")
dbSendQuery(con3,query1)

query2 <- paste("UPDATE TABPRECO SET TBPDTVALIDADE='01.07.2022' 
                WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%'")
dbSendQuery(con3,query2)

query3 <- paste("UPDATE TABPRECO SET TBPDTINICIO='18.05.2022' 
                WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%'")
dbSendQuery(con3,query3)
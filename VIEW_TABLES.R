## libraries

library(DBI)
library(dplyr)


##  db connection

con2 <- dbConnect(odbc::odbc(), "reproreplica")


dbGetQuery(con2,"SELECT * FROM TABPRECO WHERE TBPCODIGO='2085'") %>% View()

## save files

tabpromo <- dbGetQuery(con2,"SELECT * FROM TABPRECO WHERE TBPDESCRICAO LIKE '%PROMO DO MES ABR-MAI 22%'") 
  View(tabpromo)

  tabpromo_wd <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tabpromo","_",format(Sys.Date(),"%d_%m_%y"),".RData")
  
  save(tabpromo,file =tabpromo_wd)  
  
  tabpromo_wd_csv <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tabpromo","_",format(Sys.Date(),"%d_%m_%y"),".csv")
  
  
  write.csv2(tabpromo,file =tabpromo_wd_csv )


  
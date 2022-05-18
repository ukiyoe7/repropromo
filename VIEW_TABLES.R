## libraries

library(DBI)
library(dplyr)


##  db connection

con2 <- dbConnect(odbc::odbc(), "reproreplica")

dbGetQuery(con2,"SELECT * FROM TABPRECO WHERE TBPCODIGO='2085'") %>% View()

## save files

tabpromo <- dbGetQuery(con2,"SELECT * FROM TABPRECO WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%'") 
  View(tabpromo)

  tabpromo_wd <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tabpromo","_",format(Sys.Date(),"%d_%m_%y"),".RData")
  
  save(tabpromo,file =tabpromo_wd)  
  
  tabpromo_wd_csv <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tabpromo","_",format(Sys.Date(),"%d_%m_%y"),".csv")
  
  
  write.csv2(tabpromo,file =tabpromo_wd_csv )
  
  
  ## TABLE PRODUCTS
  
  tabpromo_prod <- dbGetQuery(con2,"SELECT * FROM TBPPRODU WHERE TBPCODIGO='2085'") 
  
  View(tabpromo_prod)
  
  tabpromo_prod_wd <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tabpromo_prod","_",format(Sys.Date(),"%d_%m_%y"),".RData")
  
  save(tabpromo_prod,file =tabpromo_prod_wd)  
  
  tabpromo_prod_wd_csv <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tabpromo_prod","_",format(Sys.Date(),"%d_%m_%y"),".csv")
  
  write.csv2(tabpromo_prod,file =tabpromo_prod_wd_csv )
  
  # save all products
  
  tbpprodu <- dbGetQuery(con2,"SELECT * FROM TBPPRODU") 
  
  View(tbpprodu)
  
  tbpprodu_wd <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tbpprodu","_",format(Sys.Date(),"%d_%m_%y"),".RData")
  
  save(tbpprodu,file = tbpprodu_wd)  
  
  tbpprodu_wd_csv <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tbpprodu_prod","_",format(Sys.Date(),"%d_%m_%y"),".csv")
  
  write.csv2(tbpprodu,file = tbpprodu_wd_csv )
  
  ##==================================================

  
  ## clients
  
  clipromo <- dbGetQuery(con2,"
                         WITH TB AS(
                         SELECT TBPCODIGO FROM TABPRECO WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%')
                         
                         SELECT CLICODIGO,C.TBPCODIGO FROM CLITBP C
                         INNER JOIN TB ON C.TBPCODIGO=TB.TBPCODIGO") 
   View(clipromo)
   
   
   ## save clitbp
   
   clitbp <- dbGetQuery(con2,"SELECT * FROM CLITBP") 
   
   View(clitbp)
  
   clitbp_wd <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\clitbp","_",format(Sys.Date(),"%d_%m_%y"),".RData")
  
  save(clitbp,file =clitbp_wd)  
  
  clitbp_wd_csv <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\clitbp","_",format(Sys.Date(),"%d_%m_%y"),".csv")
  
  
  write.csv2(clitbp,file =clitbp_wd_csv )
  
  
  


  
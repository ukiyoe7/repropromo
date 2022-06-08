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
  
  
  
  tabpromo_prod <- dbGetQuery(con2,"
                             WITH PROD AS (SELECT PROCODIGO,PRODESCRICAO FROM PRODU)
                              
                              SELECT TP.*,PRODESCRICAO FROM TBPPRODU TP
                              INNER JOIN PRODU P ON TP.PROCODIGO=P.PROCODIGO 
                              WHERE TBPCODIGO='2085'") 
  
  View(tabpromo_prod)
  
  
  
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
  
  
  # clitbp comb
  
  
  ## save clitbp
  
  clitbpcomb <- dbGetQuery(con2,"SELECT * FROM CLITBPCOMB") 
  
  View(clitbpcomb)
  
  clitbpcomb_wd <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\clitbpcomb","_",format(Sys.Date(),"%d_%m_%y"),".RData")
  
  save(clitbpcomb,file =clitbpcomb_wd)  
  
  clitbpcomb_wd_csv <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\clitbpcomb","_",format(Sys.Date(),"%d_%m_%y"),".csv")
  
  
  write.csv2(clitbpcomb,file =clitbpcomb_wd_csv )
  
  
  dbGetQuery(con2,"SELECT * FROM TABPRECO WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%' AND TBPTABCOMB='S'") %>% View()
  

  ## save tbpcombpropro
  
  tbpcombpropro <- dbGetQuery(con2,"SELECT * FROM TBPCOMBPROPRO") 
  
  View(tbpcombpropro)
  
  tbpcombpropro_wd <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tbpcombpropro","_",format(Sys.Date(),"%d_%m_%y"),".RData")
  
  save(tbpcombpropro,file =tbpcombpropro_wd)  
  
  tbpcombpropro_wd_csv <-  paste0("C:\\Users\\Repro\\Documents\\R\\ADM\\PROMODOMES\\BASES\\tbpcombpropro","_",format(Sys.Date(),"%d_%m_%y"),".csv")
  
  
  write.csv2(tbpcombpropro,file =tbpcombpropro_wd_csv )
  
  
  dbGetQuery(con2,"SELECT * FROM TABPRECO 
             WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%' AND TBPTABCOMB='S'") %>% View()
  
  ## view products on tables
  
  
  comb_promo_prod <-dbGetQuery(con2,"
             WITH TBCOMB AS (SELECT TBPCODIGO FROM TABPRECO 
             WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%' AND TBPTABCOMB='S')
             
             SELECT T.TBPCODIGO FROM TBPCOMBPROPRO T
             INNER JOIN TBCOMB TB ON TB.TBPCODIGO=T.TBPCODIGO
             WHERE PROCODIGOA='LD0471'   
                        ") 
  
  View(comb_promo_prod)
  
  
  


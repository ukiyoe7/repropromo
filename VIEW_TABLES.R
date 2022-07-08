## libraries

library(DBI)
library(dplyr)


##  db connection

con2 <- dbConnect(odbc::odbc(), "reproreplica")

  
  
### TABELAS =======================================================================================================


  
dbGetQuery(con2,"SELECT * FROM TABPRECO WHERE TBPCODIGO=2085") %>% View()


tabpromo_prod <- dbGetQuery(con2,"SELECT * FROM TBPPRODU WHERE TBPCODIGO=2085") 
  
View(tabpromo_prod)
  
  
  
tabpromo_prod <- dbGetQuery(con2,"
                             WITH PROD AS (SELECT PROCODIGO,PRODESCRICAO FROM PRODU)
                              
                              SELECT TP.*,PRODESCRICAO FROM TBPPRODU TP
                              INNER JOIN PRODU P ON TP.PROCODIGO=P.PROCODIGO 
                              WHERE TBPCODIGO='2085'") 
  
  View(tabpromo_prod)
  
  
  
  tbpprodu <- dbGetQuery(con2,"SELECT * FROM TBPPRODU") 
  
  View(tbpprodu)

  
  ##==================================================

  
  ## clients
  
  clipromo <- dbGetQuery(con2,"
                         WITH TB AS(
                         SELECT TBPCODIGO FROM TABPRECO WHERE TBPDESCRICAO='PROMO DO MES JUL-AGO 22')
                         
                         SELECT CLICODIGO,C.TBPCODIGO FROM CLITBP C
                         INNER JOIN TB ON C.TBPCODIGO=TB.TBPCODIGO") 
   View(clipromo)
  

  
  
### COMBINADOS =======================================================================================================
  
  
  ## save clitbp
  
  clitbpcomb <- dbGetQuery(con2,"
                           WITH TBCOMB AS (SELECT TBPCODIGO FROM TABPRECO 
                            WHERE TBPDESCRICAO='PROMO DO MES JUL-AGO 22' AND TBPTABCOMB='S' AND TBPCODIGO<>22)
                           
                           
                           SELECT * FROM CLITBPCOMB T
                           INNER JOIN TBCOMB TB ON TB.TBPCODIGO=T.TBPCODIGO
                           ") 
  
  View(clitbpcomb)
  
  
  dbGetQuery(con2,"SELECT * FROM TABPRECO WHERE TBPDESCRICAO='PROMO DO MES JUL-AGO 22' AND TBPTABCOMB='S'") %>% 
    View()
  

  ## save tbpcombpropro
  
  tbpcombpropro <- dbGetQuery(con2,"SELECT * FROM TBPCOMBPROPRO WHERE TBPCODIGO IN (22)")


  
  dbGetQuery(con2,"SELECT * FROM TABPRECO 
             WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%' AND TBPTABCOMB='S'") %>% View()
  
  ## view products on tables
  
  
  comb_promo_prod <-dbGetQuery(con2,"
             WITH TBCOMB AS (SELECT TBPCODIGO FROM TABPRECO 
             WHERE TBPDESCRICAO='PROMO DO MES JUL-AGO 22' AND TBPTABCOMB='S')
          
             
             SELECT * FROM TBPCOMBPROPRO T
             INNER JOIN TBCOMB TB ON TB.TBPCODIGO=T.TBPCODIGO
             
                        ") 
  
  View(comb_promo_prod)
  
  
  


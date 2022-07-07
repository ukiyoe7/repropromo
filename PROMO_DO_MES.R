

library(DBI)
library(dplyr)



con2 <- dbConnect(odbc::odbc(), "reproreplica")



tab_promo_prod <-dbGetQuery(con2,"
             WITH TB AS (SELECT TBPCODIGO FROM TABPRECO 
             WHERE TBPDESCRICAO='PROMO DO MES JUL-AGO 22' AND TBPTABCOMB='N' AND TBPCODIGO=2085),
             
             PRODA AS (SELECT PROCODIGO,PRODESCRICAO PRO FROM PRODU WHERE PROSITUACAO='A'),
            
             
             PRECOA AS(SELECT PROCODIGO,PREPCOVENDA2 PRA FROM PREMP WHERE EMPCODIGO=1)
             
             SELECT T.PROCODIGO,
                      PRO,
                       TBPPCDESCTO2,
                          ROUND(PRA*(1-TBPPCDESCTO2*1.00/100)*2,2) PROMO
                          FROM TBPPRODU T
             INNER JOIN TB TB ON TB.TBPCODIGO=T.TBPCODIGO
              LEFT JOIN PRODA PA ON PA.PROCODIGO=T.PROCODIGO
                LEFT JOIN PRECOA PRA ON PRA.PROCODIGO=T.PROCODIGO  
                             ") 

View(tab_promo_prod)


comb_promo_prod <-dbGetQuery(con2,"
             WITH TBCOMB AS (SELECT TBPCODIGO FROM TABPRECO 
             WHERE TBPDESCRICAO='PROMO DO MES JUL-AGO 22' AND TBPTABCOMB='S' AND TBPCODIGO=22),
             
             PRODA AS (SELECT PROCODIGO,PRODESCRICAO PROA FROM PRODU WHERE PROSITUACAO='A'),
             
             PRODB AS (SELECT PROCODIGO,PRODESCRICAO PROB FROM PRODU WHERE PROSITUACAO='A'),
             
             PRECOA AS(SELECT PROCODIGO,PREPCOVENDA2 PRA FROM PREMP WHERE EMPCODIGO=1),
             
             PRECOB AS(SELECT PROCODIGO,PREPCOVENDA2 PRB FROM PREMP WHERE EMPCODIGO=1)
             
             SELECT PROCODIGOA,
                     PROA,
                      CCINDICEPROA2,
                       PROCODIGOB,
                        PROB,
                         CCINDICEPROB2, 
                          ROUND(PRA*(1-CCINDICEPROA2*1.00/100)*2+PRB*(1-CCINDICEPROB2*1.00/100),2) COMBO
                          FROM TBPCOMBPROPRO T
             INNER JOIN TBCOMB TB ON TB.TBPCODIGO=T.TBPCODIGO
              LEFT JOIN PRODA PA ON PA.PROCODIGO=T.PROCODIGOA
               LEFT JOIN PRODB PB ON PB.PROCODIGO=T.PROCODIGOB
                LEFT JOIN PRECOA PRA ON PRA.PROCODIGO=T.PROCODIGOA   
                 LEFT JOIN PRECOB PRB ON PRB.PROCODIGO=T.PROCODIGOB 
                             ") 

View(comb_promo_prod)








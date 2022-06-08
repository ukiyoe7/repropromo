## AUTOMATE PROMO
## 07.06.2022

library(DBI)
library(dplyr)
library(googlesheets4)


con2 <- dbConnect(odbc::odbc(), "reproreplica")

TAB <- read_sheet("1OjPJWINbHKF1kwecNLbOEEyUhphB_yNdyNd08kf1sQs",sheet = "TAB")

price <- dbGetQuery(con2,"
           WITH PRECO AS(SELECT PROCODIGO,PREPCOVENDA2 FROM PREMP WHERE EMPCODIGO=1)
           
           SELECT PD.PROCODIGO,
                       PRODESCRICAO,
                             PREPCOVENDA2*2 PRECO
           FROM PRODU PD
           INNER JOIN PRECO P ON PD.PROCODIGO=P.PROCODIGO
           WHERE GR1CODIGO<>17 AND PROSITUACAO='A'
           AND PROCODIGO2 IS NULL
           AND PROTIPO IN ('P','F')
           ") %>% mutate(PROCODIGO=trimws(PROCODIGO))

View(price)



inner_join(TAB,price,by="PROCODIGO") %>% 
            mutate(DESCONTO=round(((VALOR/PRECO)-1)*100,2),2) %>% View()











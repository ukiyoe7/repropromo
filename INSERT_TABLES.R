library(DBI)
library(dplyr)


con3 <- dbConnect(odbc::odbc(), "repro_prod", timeout = 10)


##INSERT PROD INTO TABLES

x <- PROMO_MES_0522 %>% mutate(PROCODIGO=trimws(PROCODIGO)) %>%  .[,c(1,5)] %>% 
                        mutate(TBPPCDESCTO2=DESCONTO) %>% 
                        mutate (TBPPCDESCTO=DESCONTO) %>% 
                        mutate(TBPCODIGO=2085) %>% .[,c(5,1,3,4)]


z <- data.frame(TBPCODIGO=NA,PROCODIGO=NA,
                TBPPCDESCTO2=NA,TBPPCDESCTO=NA)

for (i in 1:nrow(x)) {
  z[i,] <- x[i,]
  queryy <- paste("INSERT INTO TBPPRODU (TBPCODIGO,PROCODIGO,TBPPCDESCTO2,TBPPCDESCTO) VALUES(",z[i,"TBPCODIGO"],",'",z[i,"PROCODIGO"],"',",z[i,"TBPPCDESCTO2"],",",z[i,"TBPPCDESCTO"],")",sep = "")
  
  dbSendQuery(con3,queryy)

}


##INSERT TABPROMO INTO CLIENTS

clien2 <- dbGetQuery(con2,"SELECT CLICODIGO FROM CLIEN WHERE CLICLIENTE='S'") 

inativos <- dbGetQuery(con2,"
SELECT DISTINCT SITCLI.CLICODIGO,SITCODIGO FROM SITCLI
INNER JOIN (SELECT DISTINCT SITCLI.CLICODIGO,MAX(SITDATA)ULTIMA FROM SITCLI
GROUP BY 1)A ON SITCLI.CLICODIGO=A.CLICODIGO AND A.ULTIMA=SITCLI.SITDATA 
INNER JOIN (SELECT DISTINCT SITCLI.CLICODIGO,SITDATA,MAX(SITSEQ)USEQ FROM SITCLI
GROUP BY 1,2)MSEQ ON A.CLICODIGO=MSEQ.CLICODIGO AND MSEQ.SITDATA=A.ULTIMA 
AND MSEQ.USEQ=SITCLI.SITSEQ WHERE SITCODIGO=4
")

clien3 <- anti_join(clien2,inativos,by="CLICODIGO")

clien4 <- anti_join(clien3,clipromo3,by="CLICODIGO") %>% .[1:200,] %>% as.data.frame()

p <- data.frame(CLICODIGO=NA)


for (i in 1:nrow(clien4)) {
  p[i,] <- clien4[i,]
  queryp <- paste("INSERT INTO CLITBP (CLICODIGO,TBPCODIGO,TBPDESCFECH,TBPDTCADASTRO) VALUES(",p[i,"CLICODIGO"],",2085,'S','17.05.2022')",sep = "")
  dbSendQuery(con3,queryp)
  }


clipromo3 <- dbGetQuery(con2,"
                         WITH TB AS(
                         SELECT TBPCODIGO FROM TABPRECO WHERE TBPDESCRICAO LIKE '%PROMO DO MES MAI-JUN 22%')
                         
                         SELECT DISTINCT C.TBPCODIGO,CLICODIGO FROM CLITBP C
                         INNER JOIN TB ON C.TBPCODIGO=TB.TBPCODIGO") 


View(clipromo3) 

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


rm(list=ls())
#install.packages("readstata13")
#install.packages("plm")


library(readstata13)
library(plm)

#read data into memory
dir <- getwd()
print(dir)
dataname<- paste(dir,'/chile.dta', sep = "")
chile <- pdata.frame(read.dta13(dataname), index =c('id'), row.names=TRUE)

#log variables
chile$lroutput <- log(chile$routput)
chile$ltotlab <- log(chile$totlab )
chile$lrcapstock <- log(chile$rcapstock)
chile$lrealmats <- log(chile$realmats)
chile$lrenerg <- log(chile$renerg)

#checking within
chilewithin <- Within(chile$lroutput)
print(chilewithin[1:10])

#run fixed effect
fixed <-plm(lroutput ~ ltotlab + lrcapstock + lrealmats + lrenerg, data=chile, index=c("id"), model="within")
summary(fixed)
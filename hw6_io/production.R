rm(list=ls())
#install.packages("readstata13")

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

#checking within
chilewithin <- Within(chile$lroutput)
print(chilewithin[1:10])

#run fixed effect
fixed <-plm(lroutput ~ ltotlab + lrcapstock, data=chile, index=c("id"), model="within")
summary(fixed)
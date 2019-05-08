rm(list=ls())
#install.packages("readstata13")

library(readstata13)
library(plm)

#read data into memory
dir <- getwd()
print(dir)
dataname<- paste(dir,'/chile.dta', sep = "")
chile <- data.frame(read.dta13(dataname))

#log variables
chile$lroutput <- log(chile$routput)
chile$ltotlab <- log(chile$totlab )
chile$lrcapstock <- log(chile$rcapstock)

#run fixed effect
fixed <-plm(lroutput ~ ltotlab + lrcapstock, data=chile, effect="time", index=c("year"), model="within")
summary(fixed)
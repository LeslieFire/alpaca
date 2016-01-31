## social network

library(igraph)

occr <- read.table("./occurrence.csv", sep = ",")
cooc <- read.table("./weight.csv", sep = ",", header = T)

maxN <- max(occr[,3])
minN <- min(occr[,3])
occr[,3] <- as.integer((occr[,3]-minN) * 100 / (maxN-minN))

windowsFonts(A=windowsFont("Î¢ÈíÑÅºÚ"))
par(family='A')

edgeList <- unlist(c(cooc[,1], cooc[,2]))



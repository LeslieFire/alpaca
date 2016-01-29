## social network

library(igraph)

occr <- read.table("./occurrence.txt", sep = "\t")
cooc <- read.table("./cooccurrence.txt", sep = "\t")

maxN <- max(occr[,1])
minN <- min(occr[,1])
occr[,1] <- as.integer((occr[,1]-minN) * 100 / (maxN-minN))
par(family='STXihei')
edgeMat <- matrix(c(cooc[,1], cooc[,2]), ncol=2)



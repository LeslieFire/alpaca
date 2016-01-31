## social network

library(igraph)

occr <- read.table("./sheet2.csv", sep = ",", fileEncoding = "gbk", header = T)
cooc <- read.table("./sheet1.csv", sep = ",",  fileEncoding = "gbk",header = T)
levelSheet <- read.csv("./query_result.csv", header = T)

maxN <- max(occr[,2])
minN <- min(occr[,2])
occr[,2] <- as.integer((occr[,2]-minN) * 30 / (maxN-minN))

midWeight <- median(cooc[,3])

par(family='STXihei')

ind <- which(cooc[,3] > midWeight)

mat <- matrix(c(as.character(cooc[ind,1]), as.character(cooc[ind,2])), nrow = length(ind))

edgedata <- unlist(as.data.frame(t(matrix(match(mat, occr[,1]),  nrow = length(mat[,1])))))

G <- graph(edgedata, directed = F)

plot(G, layout = layout, vertex.size = occr[,2])









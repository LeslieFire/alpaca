## social network

library(igraph)

occr <- read.table("./occurrence.csv", sep = ",")
cooc <- read.table("./weight.csv", sep = ",", header = T)

maxN <- max(occr[,3])
minN <- min(occr[,3])
occr[,3] <- as.integer((occr[,3]-minN) * 100 / (maxN-minN))
midWeight <- median(cooc[,3])

windowsFonts(A=windowsFont("Î¢ÈíÑÅºÚ"))
par(family='A')

edgeList <- unlist(c(cooc[,1], cooc[,2]))

ind <- which(cooc[,3] > midWeight)

mat <- matrix(c(as.character(cooc[ind,1]), as.character(cooc[ind,2])), nrow = length(ind))

edgedata <- unlist(as.data.frame(t(matrix(match(mat, occr[,1]),  nrow = length(mat[,1])))))

G <- graph(edgedata, directed = F)

plot(G, layout = layout, vertex.size = occr[,2])




#install.packages("igraph");
library(igraph);
library(ggplot2)
library(Cairo)
nodes = read.table(file.choose(), sep = ",",
                   header = T, stringsAsFactors = F,
                   fileEncoding = "UTF-8");
edges = read.table(file.choose(), sep = ",",
                   header = T, stringsAsFactors = F,
                   fileEncoding = "UTF-8");
level <- read.table(file.choose(), sep = "\t",
                    header = T, stringsAsFactors = F,
                    fileEncoding = "UTF-8")
temp <- merge(nodes, level, by.x = "label", by.y = "level3", all = F, all.x = T)

indSrc <-match(edges$source, temp$label)
indTgr <-match(edges$target, temp$label)
edges$weight <- edges$weight / (temp[indSrc,2] + temp[indTgr,2] - edges$weight)

edgeThreshold <- median(edges$weight)
edgeInd <- which(edges$weight > edgeThreshold)
miniEdge <- edges[edgeInd, ]

g = graph.empty(nrow(temp), directed = F);

V(g)$name = as.character(temp$label);
g = add.edges(g, as.character(as.vector(
  t(miniEdge[, c("source", "target")]))));

g = simplify(g, remove.loops = F);

set_edge_attr(g, "weights", value = miniEdge$weight);
membership = fastgreedy.community(g)$membership;

colors <- c("cyan", "deeppink", "mediumspringgreen","lightpink", "firebrick1", "mediumpurple1");

nor <- (temp$value - min(temp$value)) * 100 / (max(temp$value) - min(temp$value))

l = layout_with_fr(g, niter = 1e4);
label_size = rep(0.6, vcount(g));
label_size[nor > median(nor)] = 0.8
label_size[nor > sort(nor, decreasing = T)[5]] = log(nor[nor > sort(nor, decreasing = T)[5]]/20)
CairoPDF("./test", height = 8,width = 8, bg="transparent");

op = par(mar = rep(0, 4));
plot(g, layout = l, vertex.size = log(nor+1) * 2,vertex.label.cex = label_size,
     vertex.label = V(g)$name,
     vertex.label.family = "Microsoft YaHei",
     vertex.label.color = colors[factor(temp$level2)],#"black",
     vertex.label.dist = 0.5,
     vertex.color = colors[factor(temp$level2)],#colors[membership],
     vertex.frame.color = "lightgoldenrodyellow",
     edge.color = "gray", edge.width = 1,
     margin = rep(0, 4), edge.curved = 0.3);
dev.off();

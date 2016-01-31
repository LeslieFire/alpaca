#install.packages("igraph");
library(igraph);
library(Cairo)
nodes = read.table(file.choose(), sep = ",",
                   header = T, stringsAsFactors = F,
                   fileEncoding = "UTF-8");
edges = read.table(file.choose(), sep = ",",
                   header = T, stringsAsFactors = F,
                   fileEncoding = "UTF-8");
indSrc <-match(edges$source, nodes$label)
indTgr <-match(edges$target, nodes$label)
edges$weight <- edges$weight / (nodes[indSrc,2] + nodes[indTgr,2] - edges$weight)

level <- read.table(file.choose(), sep = "\t",
                    header = T, stringsAsFactors = F,
                    fileEncoding = "UTF-8")
temp <- merge(nodes, level, by.x = "label", by.y = "level3", all = F)

g = graph.empty(nrow(nodes), directed = F);

V(g)$name = as.character(nodes$label);
g = add.edges(g, as.character(as.vector(
  t(edges[, c("source", "target")]))));

g = simplify(g, remove.loops = F);

set_edge_attr(g, "weights", value = edges$weight);
membership = fastgreedy.community(g)$membership;

colors = c("cyan", "deeppink", "mediumspringgreen","lightpink", "firebrick1", "mediumpurple1");

nor <- (nodes$value - min(nodes$value)) / (max(nodes$value) - min(nodes$value))

l = layout_with_fr(g, niter = 1e4);
label_size = rep(0.25, vcount(g));
label_size[degree(g) > 50] = 0.5;
label_size[degree(g) > 100] = degree(g)[degree(g) > 100] / 250;
#CairoPDF(file.choose(), height = 8,width = 8, bg="transparent");
png("./test.png", height = 720,width = 720, bg="white");
op = par(mar = rep(0, 4));
plot(g, layout = l, vertex.size = log(degree(g)+1) * 2,vertex.label.cex = label_size,
     vertex.label = V(g)$name,
     vertex.label.family = "Microsoft Yahei",
     vertex.label.color = "navy",
     vertex.color = factor(temp$level2),#colors[membership],
     vertex.frame.color = "lightgoldenrodyellow",
     edge.color = "thistle1", edge.width = 1,
     margin = rep(0, 4), edge.curved = 0.3);
dev.off();

library(gdata)
library(wordcloud)

file <- list.files(pattern = "*.xlsx$")
if(!dir.exists("./pngs")){
  dir.create("./pngs")
}
for (x in file) {
  print(x)
  sheetNum <- sheetCount(x)
  for (i in 1:sheetNum){
    path <- paste("./pngs/", x, ".png")
    png(file= path, bg="white",width = 480, height = 480)
    colors=brewer.pal(8,"Dark2")
    par(family='STXihei')
    
    data <- read.xls(x, header = F, sheet = i, header = T)
    wordcloud(data[,1],data[,2],scale=c(5,0.3),min.freq=-Inf,max.words=60,colors=colors,random.order=F,random.color=F,ordered.colors=F)
    
    dev.off()
  }
  
}

# @Date    : 2016-03-07 10:33:38
# @Author  : Leslie (yangfei@hudongpai.com)
# @Link    : http://example.org
# @Version : $0.1$


library(wordcloud)

file <- list.files(pattern = "*.xlsx$")
if(!dir.exists("./pngs")){
  dir.create("./pngs")
}
for (x in file) {
  print(x)
  sheetNum <- sheetCount(x)
  for (i in 1:sheetNum){
    path <- paste("./pngs/", x, i,".png")
    png(file= path, bg="white",width = 480, height = 480)
    colors=brewer.pal(8,"Dark2")
    par(family='STXihei')
    
    data <- read.xls(x, sheet = i, header = T, encoding = "UTF-8")
    wordcloud(data[,1],data[,2],scale=c(5,0.3),min.freq=-Inf,max.words=60,colors=colors,random.order=F,random.color=F,ordered.colors=F)
    
    dev.off()
  }
  
}

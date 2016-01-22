library(gdata)
library(wordcloud)

file <- list.files(pattern = "*.csv$")
if(!dir.exists("./pngs")){
  dir.create("./pngs")
}


for (x in file) {
    print(x)
    data <- read.table(x, header = T, sep = ",")     # 读取文件
    data <- data[,colSums(is.na(data)) < nrow(data)] # 去掉空列
    num <- ncol(data) # 统计column number
    headers <- colnames(data)
    
    if (num %% 2 != 0){
      print("Not enough pairs of column")
    }
    
    for(ind in 1:(num/2)){
      title <- headers[ind*2 -1]
      filePath <-paste("./pngs/", title, ".png", sep="")
      
      png(file= filePath, bg="white",width = 480, height = 480)
      colors=brewer.pal(8,"Dark2")
      par(family='STXihei')
      
      wordcloud(data[,1],data[,2],scale=c(10,0.5),min.freq=-Inf,max.words=60,colors=colors,random.order=F,random.color=F,ordered.colors=F)
      
      dev.off()
    }
}

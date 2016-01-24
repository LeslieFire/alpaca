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
      colors="blue"
      
      windowsFonts(A=windowsFont("微软雅黑"))
      par(family='A')
      
      firstCol <- as.character(data[which(data[,ind*2-1] != "") , ind*2-1])
      secondCol <- na.omit(data[,ind*2])
      maxNum <- max(secondCol)
      minNum <- min(secondCol)
      secondCol <- (secondCol - minNum) / (maxNum - minNum)
      
      
      wordcloud(firstCol, secondCol, scale=c(5,0.5),min.freq=-Inf,max.words=60,colors=colors,rot.per = 0, random.order=F,random.color=F,ordered.colors=F)
      
      dev.off()
    }
}

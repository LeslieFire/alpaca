# @Date    : 2016-03-07 10:33:38
# @Author  : Leslie (yangfei@hudongpai.com)
# @Link    : http://example.org
# @Version : $0.1$

library(wordcloud)
library(Cairo)

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
      filePath <-paste("./pngs/", title, sep="")
      
      CairoPDF(file= filePath, bg="white",width = 8, height = 8)
      colors=c("deeppink3", "darksalmon", "firebrick4")
      
      windowsFonts(A=windowsFont("΢���ź�"))
      par(family='A')
      
      firstCol <- as.character(data[which(data[,ind*2-1] != "") , ind*2-1])
      secondCol <- na.omit(data[,ind*2])
      maxNum <- max(secondCol)
      minNum <- min(secondCol)-1
      secondCol <- (secondCol - minNum) / (maxNum - minNum)
      
      
      wordcloud(firstCol, secondCol, scale=c(5,1),min.freq=-Inf,max.words=60,colors=colors,rot.per = 0, random.order=F,random.color=F,ordered.colors=F)
      
      dev.off()
    }
}

# @Date    : 2016-03-07 10:33:38
# @Author  : Leslie (yangfei@hudongpai.com)
# @Link    : http://example.org
# @Version : $0.1$

printMap <- function(){
  library(maps)
  library(ggplot2)
  library(maptools)
  library(directlabels)
  library(mapproj)
  library(plyr)
  library(reshape2)
  library(Cairo)
  
  # setwd("H:")
  mymap <-readShapePoly("./mapfile/bou2_4p.shp")
  mymapd <- fortify(mymap)
  temp<-mymap@data
  xs<-data.frame(temp,id=seq(0:924)-1)
  china_mapdata<-join(mymapd, xs, type = "full")
  
  ############ ʡ������
  statePosition <- read.csv("./mapfile/34stateposition.csv", header = T)
  statePosition <- statePosition[, 2:4]
  statePosition$NAME <- substr(statePosition$NAME, 1, 2)
  
  
#   cityPosition <- read.csv("./190cityposition.csv", header = F)
#   names(cityPosition) <- c("NAME", "LON", "LAT")
  file <- list.files(pattern = "*.csv$")
  if(!dir.exists("./pngs")){
    dir.create("./pngs")
  }
  
  shengliang <- read.csv(file[1], header = T, encoding = "utf8")
  shengliang <- shengliang[2:nrow(shengliang),]
  shengliang <- shengliang[,colSums(is.na(shengliang)) < nrow(shengliang)]
  
  print(head(shengliang))
  
  colNum <- ncol(shengliang)
  headers <- colnames(shengliang)
  print(colNum)
  print(headers)
  for(i in 1:colNum){
    names <- shengliang[,i*2 -1 ]
    counts <- as.numeric(as.character(shengliang[,i*2])) 
    print(head(names))
    print(head(counts))
    maxCnt <- max(counts, na.rm = T)
    minCnt <- min(counts, na.rm = T)
    
    title <- headers[i*2 -1]
    filePath <-paste("./pngs/", title, ".png", sep="")
    
    ind <- which(!is.na(counts))
    toshow <- data.frame(NAME = names[ind], count = counts[ind])
    toshow$NAME <- substr(toshow$NAME, 1, 2)
    
    xs$NAME <- substr(xs$NAME, 1, 2)
    toshow <- join(toshow, xs, type = "full")
    toshow <- data.frame(NAME = toshow$NAME, count = toshow$count, id = toshow$id)
    
    myepidat <- data.frame(id = unique(sort(mymapd$id)))
    myepidat<-join(myepidat, toshow, type = "full")   # 感觉这两句没什么意思啊
    
    windowsFonts(A=windowsFont("΢���ź�"))
    par(family='A')
    
    theme_opts <- list(theme(panel.grid.minor = element_blank(),#设置网格线为�?
                             panel.grid.major = element_blank(),#你可以去�?
                             panel.background = element_rect(fill=rgb(red = 255, green = 255, blue = 255, max = 255)),#设置图版背景�?
                             plot.background = element_rect(fill=rgb(red = 255, green = 255, blue = 255, max = 255)),#设置绘图区背景色                         
                             panel.border = element_blank(),
                             legend.background = element_rect(fill=rgb(red = 255, green = 255, blue = 255, max = 255)),
                             axis.line = element_blank(),
                             axis.text.x = element_blank(),
                             axis.text.y = element_blank(),
                             axis.ticks = element_blank(),
                             axis.title.x = element_blank(),
                             axis.title.y = element_blank(),#以上全是设置xy�?
                             plot.title = element_text(size=10)))
    
    
    g <- ggplot(myepidat) + geom_map(aes(map_id = id, fill = count), color = "black", map = mymapd) +
      scale_fill_gradient(name="",
                          high = rgb(red = 0, green = 0, blue = 255, max = 255),
                          low = rgb(red = 240, green = 255, blue = 255, max = 255),
                          guide = FALSE) +
      expand_limits(x = c(73, 136), y = c(6, 54)) + coord_map()+
      theme_opts
    
    #CairoPDF(filePath, height = 8,width = 8, bg="transparent");
    png(filePath, height= 672, width = 896, bg = "transparent")
    #print(filePath)
    print(g)
    dev.off()
  }
}









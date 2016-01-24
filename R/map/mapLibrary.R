library(maps)
library(ggplot2)
library(maptools)
library(directlabels)
library(mapproj)
library(plyr)
library(reshape2)

# setwd("H:")
mymap <-readShapePoly("./mapfile/bou2_4p.shp")
mymapd <- fortify(mymap)
temp<-mymap@data
xs<-data.frame(temp,id=seq(0:924)-1)
china_mapdata<-join(mymapd, xs, type = "full") 

############ 省市坐标
statePosition <- read.csv("./34stateposition.csv", header = F)
names(statePosition) <- c("NAME", "LON", "LAT")
statePosition$NAME <- substr(statePosition$NAME, 1, 2)

cityPosition <- read.csv("./190cityposition.csv", header = F)
names(cityPosition) <- c("NAME", "LON", "LAT")
shengliang <- read.csv("./mapdata.csv", header = T, skip = 1)

names <- shengliang[,1]
counts <- shengliang[,2]
maxCnt <- max(counts, na.rm = T)
minCnt <- min(counts, na.rm = T)

ind <- which(!is.na(counts))
toshow <- data.frame(NAME = names[ind], count = counts[ind])
toshow$NAME <- substr(toshow$NAME, 1, 2)

xs$NAME <- substr(iconv(xs$NAME, "gbk", "utf8"), 1, 2)
toshow <- join(toshow, xs, type = "full")
toshow <- data.frame(NAME = toshow$NAME, count = toshow$count, id = toshow$id)

myepidat <- data.frame(id = unique(sort(mymapd$id)))
myepidat<-join(myepidat, toshow, type = "full")   # 感觉这两句没什么意思啊

par(family='STXihei')

theme_opts <- list(theme(panel.grid.minor = element_blank(),#设置网格线为空
                         panel.grid.major = element_blank(),#你可以去掉
                         panel.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),#设置图版背景色
                         plot.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),#设置绘图区背景色                         
                         panel.border = element_blank(),
                         legend.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),
                         axis.line = element_blank(),
                         axis.text.x = element_blank(),
                         axis.text.y = element_blank(),
                         axis.ticks = element_blank(),
                         axis.title.x = element_blank(),
                         axis.title.y = element_blank(),#以上全是设置xy轴
                         plot.title = element_text(size=10)))


g <- ggplot(myepidat) + geom_map(aes(map_id = id, fill = count), color = "white", map = mymapd) +
                      geom_point(data = statePosition,aes(x = LON, y = LAT,fill = NULL),
                                colour = rgb(red = 165, green = 165, blue = 165, max = 255)) +
                      geom_dl(data = statePosition,aes(x = LON, y = LAT, label = NAME),
                            method = list('last.points',cex = 0.7, hjust = 1)) + #设置省会标签，让省会标签随机移动一点距离以免过分重叠
                      scale_fill_gradient(name="",
                                        high = rgb(red = 0, green = 0, blue = 255, max = 255),
                                        low = rgb(red = 240, green = 255, blue = 255, max = 255),
                                        breaks = seq(from = minCnt, to = maxCnt, by = (maxCnt-minCnt)/5)) +
                      expand_limits(x = c(73, 136), y = c(6, 54)) + coord_map()+
                      theme_opts +
                      theme(legend.text=element_text(size=10))





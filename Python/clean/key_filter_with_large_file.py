#!/usr/bin/python
# -*- coding: utf-8 -*-
# @Date    : 2016-03-07 10:33:38
# @Author  : Leslie (yangfei@hudongpai.com)
# @Link    : http://example.org
# @Version : $0.1$

import sys
import csv


other = " 无"
wrongID = []
mapper = ["安慕希","纯甄","莫斯利安","开啡尔","畅轻","益消","尚补坊","冠益乳","消健","健能","畅优","乐畅","酪爵庄园","乐钙","优酪乳","益菌多","完达山","明治","奶牛梦工厂","优诺","燕塘","每益添","畅意100%","优益C","养乐多","津威","娃哈哈","君畅","味全","益力多","乳酸菌","酸奶"]

if __name__ == "__main__":
        try:
                filename = sys.argv[1]
        except:
                print "缺少文件名参数"
                
        #report = file("report"+filename, "w+")
        #writer = file("related.txt", "w+")
        reader = open(filename, 'rb')
                   
        #next(reader)    #忽略第一行（抬头）
        counter = 0
        total = 0
        for line in reader:
                total = total + 1
                for key in mapper:
                    if key in line:
                        counter = counter + 1
                        #related.append(line.strip()+"\t" + key + "\n")
                        break

        rst = "counter = {0}\t total = {1}\t percent = {2}".format(counter, total, float(counter)/float(total))
        print rst
        #report.write(rst)
        #writer.writelines(related)
        
        #writer.close()
        #report.close()
        reader.close()
 

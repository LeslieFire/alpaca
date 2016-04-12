#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2016-04-11
# @Author  : Leslie (yangfei@hudongpai.com)
# @Link    : http://www.datastory.com.cn
# @Version : $0.1$

import os
import sys

FILE_NAME = "538.csv"

writer = open("result.txt", "wb")

with open(FILE_NAME, "rb") as reader:
    next(reader)
    #next(reader)
    count = 0
    for line in reader:
        count = count + 1
        data = line.decode('gbk').encode('utf8').strip().split(",")
        if len(data) < 14:
            continue
        attr,dim,fs,fea,sen,senti = data[8:14]
        #print attr, dim, fs, fea, sen, senti
        if len(attr) <= 0:
            writer.write(line.decode('gbk').encode('utf8'))
        else:
            attr_spl = attr.strip().split("|")
            dim_spl = dim.strip().split("|")
            fs_spl = fs.strip().split("|")
            fea_spl = fea.strip().split("|")
            sen_spl = sen.strip().split("|")
            senti_spl = senti.strip().split("|")
            n = len(attr_spl)
            for i in range(n):
                data[8] = attr_spl[i]
                data[9] = dim_spl[i]
                data[10]= fs_spl[i]
                data[11]= fea_spl[i]
                data[12]= sen_spl[i]
                data[13]= senti_spl[i]
                l = ','.join(data)+"\n"
                writer.write(l)
        
        
writer.close()
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2016-04-08
# @Author  : Leslie (yangfei@hudongpai.com)
# @Link    : http://www.datastory.com.cn
# @Version : $0.1$

import sys
import os
import codecs

SET1_FILENAME = "set1.xls"
SET2_FILENAME = "set2.xls"

set1 = set()
set2 = set()

def id_set(file_name, code = "utf8"):
    s = set()
    with codecs.open(file_name, "rb", code, 'ignore') as reader:
        next(reader)
        for line in reader:
            data = line.strip().split("\t")
            if len(data) < 1:
                continue
            if data[0].strip() == "":
                continue
            s.add(data[0])
    return s
    
set1 = id_set(SET1_FILENAME)
set2 = id_set(SET2_FILENAME, "UTF-16LE")
# print set1.pop()
# print set1.pop()
# print set1.pop()
# print set1.pop()
# print set2.pop()
# print set2.pop()
# print set2.pop()
# print set2.pop()
# print set2.pop()
# print set2.pop()
# print set2.pop().replace(" ", "")
# print set2.pop()
# print set2.pop()


ss = set1 &set2
filename = str(len(ss))

f = file(filename, 'wb')

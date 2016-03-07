#!/usr/bin/python
# -*- coding: utf-8 -*-
# @Date    : 2016-03-07 10:33:38
# @Author  : Leslie (yangfei@hudongpai.com)
# @Link    : http://example.org
# @Version : $0.1$

import sys


####################以下是参数######################

COLUMN = 6
FILE_NAME = "null_  _665_1457316104102.txt"
MATCH = False

####################以上是参数######################

FILTER_WORDS = "filter_words1.txt"
other = " 无"
wrongID = []
filter_words = []
filtered_lines = []

def filter_word(s):
        data = s.strip().split("\t")
        if len(data) < COLUMN:
                return None
        for key in filter_words:
                if MATCH:
                        if key in s:
                                return None
                else:
                        if key in data[COLUMN - 1]:
                                return None
        return s

if __name__ == "__main__":
        ResultWriter = file("result.txt", "w+")
        #FilteredWriter = file("filtered_lines.txt", "w+")
        reader = open(FILE_NAME, 'rb')

        with open(FILTER_WORDS, "rb") as f:
                for line in f:
                        word = line.strip()
                        if word is not None and word != "":
                                filter_words.append(word)
 
        next(reader)    #忽略第一行（抬头）
        
        lines = list(reader)

        ret = filter(filter_word, lines)
        ResultWriter.writelines(ret)
        #FilteredWriter.writerLines(filtered_lines)

        #FilteredWriter.close()
        ResultWriter.close()
        reader.close()
 

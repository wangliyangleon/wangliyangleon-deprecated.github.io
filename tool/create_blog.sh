#!/bin/sh
date=`date +%Y-%m-%d`
time=`date`
title="NONE"
cate="NONE"
layout="post"
type="md"

if [[ $# -gt 0 ]]; then
    title=$1
fi
if [[ $# -gt 1 ]]; then
    cate=$2
fi
if [[ $# -gt 2 ]]; then
    layout=$3
fi
if [[ $# -gt 3 ]]; then
    type=$4
fi

if [ ! -f "_layouts/"$layout".html" ]; then
    echo "bad layout: "$layout
    exit -1
fi

file_dir="all/"$cate"/_posts"
if [ ! -d $file_dir ]; then
    echo "bad category: "$cate
    exit -2
fi

file_name=$date"-"${title/" "/"-"}"."$type
echo "---
title: "$title"
date: "$time"
layout: "$layout"
categories:
  - "$cate"
tags:
---
# WRITE SOMETHING" > $file_dir"/"$file_name

#!/bin/sh
date=`date +%Y-%m-%d`
title="BLANK"
layout="default"
type="html"

if [[ $# -gt 0 ]]; then
    title=$1
fi
if [[ $# -gt 1 ]]; then
    layout=$2
fi
if [[ $# -gt 2 ]]; then
    type=$3
fi

if [ ! -f "_layouts/"$layout"."$type ]; then
    echo "bad layout: "$layout"."$type
    exit -1;
fi

file_dir="./_posts"
file_name=$date"-"$title"."$type
echo "---
layout: "$layout"
title: "$title"
---
<h2>{{ page.title }}</h2>
<p>I'm Leon, I'm AWESOME!!!</p>
<p>{{ page.date | date_to_string }}</p>" > $file_dir"/"$file_name

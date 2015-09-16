#!/bin/sh
mkdir -p tags
rm -rf tags/*
sed -n '/^tags:/,/---/p' all/*/_posts/*.md | grep -v 'tags:' | grep -v '\-\-\-' | sed "s/  - //g" |
while read line
do
    mkdir -p tags/"$line"
    index="tags/"$line"/index.html"
    echo "---" > $index
    echo "layout: tag" >> $index
    echo "tag: $line" >> $index
    echo "title: tag:$line" >> $index
    echo "---" >> $index
done

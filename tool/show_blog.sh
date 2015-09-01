#!/bin/sh
for cate in "tech" "poem" "life"
do
    echo "========== $cate =========="
    ls -l all/$cate/_posts/*
    echo "=========================="
done

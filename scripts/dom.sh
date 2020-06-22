#!/usr/bin/env bash
input=jyutping-table/list.tsv
output=dominant.tsv

awk '(FNR!=1 && !x[$1]++){printf "%s\t%s\n", $1, $3}' $input > $output
LC_ALL="zh_HK.utf8" /usr/bin/sort -k2,2 -k1,1 -o $output $output

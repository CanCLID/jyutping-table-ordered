#!/usr/bin/env bash
input=jyutping-table/list.tsv
output=jyut6ping3.char.dict.yaml

cat <<EOF > a.tmp
# Rime dict
# encoding: utf-8
# 取自: LSHK字表 <https://github.com/lshk-org/jyutping-table/>
---
name: jyut6ping3.char
version: "$( date +%Y.%m.%d )"
columns:
  - text
  - code
  - weight
...
EOF

awk '
  function abs(v) {
    return v < 0 ? -v : v
  }
  BEGIN{

  }
  ($0!="CH	UCODE	JP	INIT	FINL	TONE") {
      if(!x[$1]) x[$1]=1000
      printf "%s\t%s\t%d\n", $1, $3, x[$1]--
  }
' $input > b.tmp

LC_ALL="zh_HK.utf8" /usr/bin/sort -k1,1 -k3,3gr -k2,2 -o b.tmp b.tmp

cat a.tmp b.tmp > $output
rm a.tmp b.tmp

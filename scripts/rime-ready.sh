input=jyutping-table/list.tsv
output=jyut6ping3.char.dict.yaml

cat <<EOF > a.tmp
# Rime dict
# encoding: utf-8

---
name: jyut6ping3.char
version: "$( date +%Y.%m.%d )"
sort: by_weight
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

/usr/bin/sort -k2,2 -k1,1 -k3,3 -o b.tmp b.tmp

cat a.tmp b.tmp > $output
rm a.tmp b.tmp

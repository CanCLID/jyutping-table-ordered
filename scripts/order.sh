input=jyutping-table/list.tsv
output=ordered.tsv

awk '
  function abs(v) {return v < 0 ? -v : v}
  {
    if($0=="CH	UCODE	JP	INIT	FINL	TONE")
      print "CH	UCODE	JP	INIT	FINL	TONE	ORDR"
    else {
      if(!x[$1]) x[$1]=1000
      printf "%s\t%d\n", $0, x[$1]--
    }
  }
' $input > $output

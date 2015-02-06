#!/bin/bash
if (sh wget.sh); then
  echo "Downloaded successfully..."
  sleep 3
FILES=txt/*.txt
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  echo $f
  op_file=$(basename "$f")
  fname="${op_file%.*}"
  echo "$fname"
  pandoc -f markdown_phpextra -w html $f -o html/"$fname".html

  cat html/"$fname".html | sed ':a;N;$!ba;s/\n//g' | sed 's/<h3>/\n<h3>/g'| sed  's/:<\/h3>/<\/h3>:/g' | sed  's/<\/h3>:$$/<\/h3>:[$$]/g' | sed  's/<p>$$<\/p>/<p>[\/$$]<\/p>/g'  > import/"$fname".txt
done
else
  echo "Problem in downloading files..."
fi

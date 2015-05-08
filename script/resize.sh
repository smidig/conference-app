#!/bin/sh

for F in `find $1 -name *.png -print`; do
  width=`identify -format %w $F`
  if [ $width -gt 250 ]; then
    echo $F Too big
    convert $F -resize 250x250\> $F.new
    rm $F
    mv $F.new $F
  fi
done

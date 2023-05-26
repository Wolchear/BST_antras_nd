#!/bin/sh

pathForTrimmed="../../inputs/trimmed"
pathSpades="../../outputs/assemblySpades"
if [ ! -d $pathSpades ]; then
mkdir -p $pathSpades
echo "Sukurta new dir $pathSpades"
fi

for i in $pathForTrimmed/*_1_val_1.fq.gz
do
R1=$i
R2=$pathForTrimmed/"$(basename $R1 _1_val_1.fq.gz)_2_val_2.fq.gz"
if [ ! -d $pathSpades/"$(basename $R1 _1_val_1.fq.gz)" ]; then
mkdir -p $pathSpades/"$(basename $R1 _1_val_1.fq.gz)"
echo "Sukurta new dir $pathSpades/$(basename $R1 _1_val_1.fq.gz)"
fi
echo "Spades for $R1 and $R2 saving in $pathSpades/$(basename $R1 _1_val_1.fq.gz)"
/usr/lib/spades/bin/spades.py -o $pathSpades/ -1 $R1 -2 $R2
done
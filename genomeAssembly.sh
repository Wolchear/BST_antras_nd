#!/bin/sh

#Spades
pathForTrimmed="../../inputs/trimmed"
pathSpades="../../outputs/assemblySpades"
pathAbyss="../../outputs/abyssAssembly"
pathMegahit="../../outputs/megahitAssembly"
pathRagTag="../../outputs/RagTag"
pathRef="../../references/CP015498.fasta"
if [ ! -d $pathSpades ]; then
mkdir -p $pathSpades
echo "Sukurta new dir $pathSpades"
fi

#for i in $pathForTrimmed/*_1_val_1.fq.gz
#do
#R1=$i
#R2=$pathForTrimmed/"$(basename $R1 _1_val_1.fq.gz)_2_val_2.fq.gz"
#if [ ! -d $pathSpades/"$(basename $R1 _1_val_1.fq.gz)" ]; then
#mkdir -p $pathSpades/"$(basename $R1 _1_val_1.fq.gz)"
#echo "Sukurta new dir $pathSpades/$(basename $R1 _1_val_1.fq.gz)"
#fi
#echo "Spades for $R1 and $R2 saving in $pathSpades/$(basename $R1 _1_val_1.fq.gz)"
#/usr/lib/spades/bin/spades.py -o $pathSpades/$(basename $R1 _1_val_1.fq.gz) -1 $R1 -2 $R2
#done

#Abyss

#if [ ! -d $pathAbyss ]; then
#mkdir -p $pathAbyss
#echo "Sukurta new dir $pathAbyss"
#fi

#for kc in 2 3; do
#	for k in `seq 50 8 90`; do
#		mkdir k${k}-kc${kc}
#		abyss-pe name=ERR204044 B=2G k=$k kc=$kc in=../../ERR204044_1_val_1.fq -C k${k}-kc${kc}
#	done
#done
#abyss-fac k*/ERR204044-scaffolds.fa

#if [ ! -d $pathMegahit ]; then
#mkdir -p $pathMegahit
#echo "Sukurta new dir $pathMegahit"
#fi

#later="python3 /home/bioinformatikai/MEGAHIT-1.2.9-Linux-x86_64-static/bin"
#for i in $pathForTrimmed/*_1_val_1.fq.gz
#do
#R1=$i
#R2=$pathForTrimmed/"$(basename $R1 _1_val_1.fq.gz)_2_val_2.fq.gz"
#if [ ! -d $pathMegahit/"$(basename $R1 _1_val_1.fq.gz)" ]; then
#mkdir -p $pathMegahit/"$(basename $R1 _1_val_1.fq.gz)"
#echo "Sukurta new dir $pathMegahit/$(basename $R1 _1_val_1.fq.gz)"
#fi
#echo "Spades for $R1 and $R2 saving in $pathMegahit/$(basename $R1 _1_val_1.fq.gz)"
#$later/megahit -o $pathMegahit/$(basename $R1 _1_val_1.fq.gz) -1 $R1 -2 $R2
#done

pathRagTag="../../outputs/RagTag"
if [ ! -d $pathRagTag ]; then
mkdir -p $pathRagTag
echo "Sukurta new dir $pathRagTag"
fi

for i in $pathSpades/*
do
R1=$i/contigs.fasta
if [ ! -d $pathRagTag/$(basename $i) ]; then
mkdir -p $pathRagTag/$(basename $i)
echo "Sukurta new dir $pathRagTag/$(basename $i)"
fi
ragtag.py correct $pathRef $R1 -o $pathRagTag/$(basename $i)
done
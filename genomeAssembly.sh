#!/bin/sh

#Spades
pathForTrimmed="../../inputs/trimmed"
pathSpades="../../outputs/assemblySpades"
pathAbyss="../../outputs/abyssAssembly"
pathMegahit="../../outputs/megahitAssembly"
pathRagTag="../../outputs/RagTag"
pathRef="../../references/CP015498.fasta"
pathAssembly="../../outputs/asseblyToUse"
pathOriginal="../../inputs"
pathMap="../../outputs/map"
pathSam="../../outputs/map/samFiles"
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
#RgTag
#Correct
pathRagTag="../../outputs/RagTag"
if [ ! -d $pathRagTag ]; then
mkdir -p $pathRagTag
echo "Sukurta new dir $pathRagTag"
fi

for i in $pathSpades/*
do
R1=$i/contigs.fasta
if [ ! -d $pathRagTag/Spades/$(basename $i) ]; then
mkdir -p $pathRagTag/Spades/$(basename $i)
echo "Sukurta new dir $pathRagTag/Spades/$(basename $i)"
fi
#ragtag.py correct $pathRef $R1 -o $pathRagTag/Spades/$(basename $i)
done

for i in $pathMegahit/*
do
R1=$i/final.contigs.fa
if [ ! -d $pathRagTag/megahit/$(basename $i) ]; then
mkdir -p $pathRagTag/megahit/$(basename $i)
echo "Sukurta new dir $pathRagTag/megahit/$(basename $i)"
fi
#ragtag.py correct $pathRef $R1 -o $pathRagTag/megahit/$(basename $i)
done

#Scaffolds
for i in $pathRagTag/Spades/*
do
R1=$i/ragtag.correct.fasta
#ragtag.py scaffold $pathRef $R1 -o $i
done

for i in $pathRagTag/megahit/*
do
R1=$i/ragtag.correct.fasta
#ragtag.py scaffold $pathRef $R1 -o $i
done

#Mapping

#Index
for i in $pathAssembly/*
do
R1=$i/ragtag.scaffold.fasta
#bwa index $R1
done



#Mapping
if [ ! -d $pathMap ]; then
mkdir -p $pathMap
echo "Sukurta new dir $pathMap"
fi

if [ ! -d $pathSam ]; then
mkdir -p $pathSam
echo "Sukurta new dir $pathSam"
fi

#for i in $pathOriginal/*1.fastq.gz
#do
#R1=$i
#R2="$pathOriginal/$(basename $R1 1.fastq.gz)2.fastq.gz"
#echo "$R1 $R2"
#bwa index $pathAssembly/$(basename $R1 _1.fastq.gz)/ragtag.scaffold.fasta
#bwa mem $pathAssembly/$(basename $R1 _1.fastq.gz)/ragtag.scaffold.fasta $R1 $R2 > $pathSam/$(basename $R1 _1.fastq.gz).sam
#done

#for i in $pathSam/*
#do
#echo $(basename $i)
#samtools view -F 4 -bS $i -@ 7 | samtools sort -@ 7  -o $pathSam/$(basename $i .sam)_sorted.bam
#done

#for i in $pathSam/*.bam
#do
#echo $i
#samtools index -b $i
#samtools flagstat $i
#done

pathGepard="../../../Executable/gepard"
for i in $pathRagTag/megahit/*
do
R1=$i/ragtag.scaffold.fasta
R2=$pathRagTag/Spades/$(basename $i)/ragtag.scaffold.fasta
java -cp $pathGepard/dist/Gepard-1.40.jar org.gepard.client.cmdline.CommandLine -seq1 $R1 -seq2 $R2 -matrix $pathGepard/resources/matrices/edna.mat -outfile output_$(basename $i).png 
done
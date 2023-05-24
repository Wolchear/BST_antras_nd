#!/bin/sh


threads=6
#1) FASTQC analysis on each of FASTQC files
#if [ ! -d ../../raw_data ]; then
#mkdir -p ../../outputs/raw_data/
#echo "Sukurta new dir ../../outputs/raw_data"
#fi
#fastqc -t $threads ../../inputs/* -o ../../outputs/raw_data/

#2)Trim galore
if [ ! -d ../../inputs/trimmed ]; then
mkdir -p ../../inputs/trimmed
echo "Sukurta new dir ../../inputs/trimmed"
fi

for i in ../../inputs/*1.fastq.gz
do
R1=$i
R2="../../inputs/$(basename $R1 1.fastq.gz)2.fastq.gz"
echo "Triming for $R1 and $R2"
trim_galore -paired $R1 $R2 --fastqc -o ../../inputs/trimmed/ --length 20 -q 25 --stringency 3 
done
echo "All samples are trimmed"


#3) MultiQc

multiqc /home/bioinformatikai/HW2/inputs/trimmed/*_fastqc* /home/bioinformatikai/HW2/outputs/raw_data/*fastqc*
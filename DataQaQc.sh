#!/bin/sh


threads=6
#1) FASTQC analysis on each of FASTQC files
#if [ ! -d ../../raw_data ]; then
#mkdir -p ../../outputs/raw_data/
#echo "Sukurta new dir ../../outputs/raw_data"
#fi
#fastqc -t $threads ../../inputs/* -o ../../outputs/raw_data/

# Komentarai
# ERR204044
# Vienintelė problema buvo su `Per tile sequence quality`
# Kaip supratau problema gali atsirasti
# dėl `flowcell` nešvarumo it t.t. 
#(https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/12%20Per%20Tile%20Sequence%20Quality.html)

#SRR15131330
# Buvo fail`as tik su `Sequence Duplication Levels`
# Su `overrpresented sequences` ir adapteriais viskas yra ok
# Tikriausiai tai tsg sekos specifiškumas
# https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/8%20Duplicate%20Sequences.html

#SRR18214264
# Failas `Per base sequence content`.
# Jei pažiūrėti į `Sequence Length Distribution`
# Matosi, kad SRR18214264 sampl'as turi šiek tiek read`ų
# kurie yra trumpesni už 150-152 (SRR15131330 visi read`ai
# yra 150-152 bp o ERR204044 99-101 ), tai gal tas "failas" susiję su tais "short read`ais"
# https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/4%20Per%20Base%20Sequence%20Content.html
# Šaltinyje parašyta, kad toks rezultatas gali atsirasti dėl nesubalansoto fragmentavimo (Biased fragementation)
# Jeigu viska supratau, tai ir yra pagrindinė priežastis

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
trim_galore -paired $R1 $R2 --fastqc -o ../../inputs/trimmed/ --length 20 -q 30 --stringency 3 
done
echo "All samples are trimmed"

# Komentarai

# ERR204044
# Apkirpo nekokibiškus readus, bet tai niekaip negalėjo paveikti `Per tile sequence quality`,
# tai viskas liko beveik kaip buvo

#SRR15131330
# Apkirpo nekokibiškus readus, bet duplikacijų skičius nepakito, tai, kaip ir sakiau, tikriausiai
# tai yra šios sekos specifika

#SRR18214264
# Padidėjo skaičius readų, kurie yra < 150-152, tai pirmą kartą susiduriau su tokiu fatqc atveju,
# tai, vis gi galvojų, kad galėjo būti kažkokią klaidą sekvinavimo metų

#3) MultiQc

multiqc /home/bioinformatikai/HW2/inputs/trimmed/*_fastqc* /home/bioinformatikai/HW2/outputs/raw_data/*fastqc*
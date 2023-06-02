#!/bin/sh
pathGepard="../../../Executable/gepard"
pathRagTag="../../outputs/RagTag"
pathRef="../../references/CP015498.fasta"
pathAssembly="../../outputs/asseblyToUse"
#GEPARD

genomeERR="$pathRagTag/megahit/ERR204044"
genomeSRR15="$pathRagTag/megahit/SRR15131330"
genomeSRR18="$pathRagTag/megahit/SRR18214264"
gepard="/dist/Gepard-1.40.jar org.gepard.client.cmdline.CommandLine"
#java -cp $pathGepard/$gepard -seq1 $genomeERR/ragtag.scaffold.fasta -seq2 $genomeSRR15/ragtag.scaffold.fasta -matrix $pathGepard/resources/matrices/edna.mat -outfile output_$(basename $genomeERR)_$(basename $genomeSRR15).png
#java -cp $pathGepard/$gepard -seq1 $genomeERR/ragtag.scaffold.fasta -seq2 $genomeSRR18/ragtag.scaffold.fasta -matrix $pathGepard/resources/matrices/edna.mat -outfile output_$(basename $genomeERR)_$(basename $genomeSRR18).png
#java -cp $pathGepard/$gepard -seq1 $genomeSRR15/ragtag.scaffold.fasta -seq2 $genomeSRR18/ragtag.scaffold.fasta -matrix $pathGepard/resources/matrices/edna.mat -outfile output_$(basename $genomeSRR15)_$(basename $genomeSRR18).png

# Komentarai

#ERR204044 ir SRR15131330
# matosi šiek tiek inserciju\delecijų, bet scaffoldu atitikimas gana geras
#ERR204044 ir SRR18214264
# Beveik idealus atitikimas beveik idealus
#SRR15131330 ir SRR18214264
# Taip pat matosi šiektiek inserciju\delecijų, truputi daugiau negu ERR204044 ir SRR15131330 palyginime
# Ir, matosi, kad liniją yra gana kreivą gale (bent man taip rodosi), tai galima pasakyti
# SRR15131330 ir SRR18214264 scaffoldai skyriasi daugiausiai

# Taip pat reikėtų paminėti, kad gale visur yra microsalelitų, bet tai ok, skirtingi gi genomai


#BUSCO, kodas kuri naudojau savo local linuxe
# busco -i ../ragtag.scaffold18.fasta -l /home/wolchear/Desktop/lactobacillales_odb10 -m genome -o SRR18 -f
# busco -i ../ragtag.scaffold15.fasta -l /home/wolchear/Desktop/lactobacillales_odb10 -m genome -o SRR15 -f
# busco -i ../ragtag.scaffold.fasta -l /home/wolchear/Desktop/lactobacillales_odb10 -m genome -o ERR -f
#komanda sudaryti grafika
#python3 generate_plot.py -wd ../../scaffolds/

# Komentarai

# Pagal BUSCO plotą, galima pasakyti, kad kiekvienas genomas turi daug single-copy ortologu ~99%, 
#taip pat yra šiektiek fragemtuotų genų ir labai mažai missed genų


for i in $pathAssembly/*
do
#makeblastdb -in $i/ragtag.scaffold.fasta -dbtype nucl -out $i/db/ragtag.scaffold_bd
blastn -query $pathRef -db $i/db/ragtag.scaffold_bd -out result_$(basename $i).txt -evalue 1.e-115 -outfmt 6
wc -l result_$(basename $i).txt
done

# gene_markS
# genų skaičius
# (grep -c "native") + (grep -c "atypical") - 1 == lastGeneId
# ERR: 2295
# SRR15: 2568
# SRR18: 2310
# Rast 
# (wc -l) - 1
# ERR: 2579
# SRR15: 2912
# SRR18: 2597
# BLASTn
# (wc -l) - 1
# ERR: 2394
# SRR15: 1863
# SRR18: 3065
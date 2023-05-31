#!/bin/sh
pathGepard="../../../Executable/gepard"
pathRagTag="../../outputs/RagTag"
pathDB="../../references/db"
#GEPARD
genomeERR="$pathRagTag/megahit/ERR204044"
genomeSRR15="$pathRagTag/megahit/SRR15131330"
genomeSRR18="$pathRagTag/megahit/SRR18214264"
gepard="/dist/Gepard-1.40.jar org.gepard.client.cmdline.CommandLine"
java -cp $pathGepard/$gepard -seq1 $genomeERR/ragtag.scaffold.fasta -seq2 $genomeSRR15/ragtag.scaffold.fasta -matrix $pathGepard/resources/matrices/edna.mat -outfile output_$(basename $genomeERR)_$(basename $genomeSRR15).png
java -cp $pathGepard/$gepard -seq1 $genomeERR/ragtag.scaffold.fasta -seq2 $genomeSRR18/ragtag.scaffold.fasta -matrix $pathGepard/resources/matrices/edna.mat -outfile output_$(basename $genomeERR)_$(basename $genomeSRR18).png
java -cp $pathGepard/$gepard -seq1 $genomeSRR15/ragtag.scaffold.fasta -seq2 $genomeSRR18/ragtag.scaffold.fasta -matrix $pathGepard/resources/matrices/edna.mat -outfile output_$(basename $genomeSRR15)_$(basename $genomeSRR18).png


#BUSCO, kodas kuri naudojau savo local linuxe
# busco -i ../ragtag.scaffold18.fasta -l /home/wolchear/Desktop/lactobacillales_odb10 -m genome -o SRR18 -f
# busco -i ../ragtag.scaffold15.fasta -l /home/wolchear/Desktop/lactobacillales_odb10 -m genome -o SRR15 -f
# busco -i ../ragtag.scaffold.fasta -l /home/wolchear/Desktop/lactobacillales_odb10 -m genome -o ERR -f
#komanda sudaryti grafika
#python3 generate_plot.py -wd ../../scaffolds/

# Pagal BUSCO plotą, galima pasakyti, kad kiekvienas genomas turi daug single-copy ortologu ~99%, 
#taip pat yra šiektiek fragemtuotų genų ir labai mažai missed genų

#makeblastdb -in CP015498.fasta -dbtype nucl -out db/CP015498_db
#blastn -query $pathRagTag/megahit/ERR204044/ragtag.scaffold.fasta -db $pathDB/CP015498_db -out result.txt
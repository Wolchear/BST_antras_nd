#!/bin/sh


threads=6
#1) FASTQC analysis on each of FASTQC files
if [ ! -d ../../raw_data ]; then
mkdir -p ../../outputs/raw_data/
echo "Sukurta new dir ../../outputs/raw_data"
fi
fastqc -t $threads ../../inputs/* -o ../../outputs/raw_data/


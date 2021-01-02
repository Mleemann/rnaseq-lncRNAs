#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=5:00:00
#SBATCH --job-name=stringtie

module add UHTS/Aligner/stringtie/1.3.3b

DIR=/data/courses/rnaseq/lncRNAs/Project1/michele/stringtie
REFERENCE=/data/courses/rnaseq/lncRNAs/Project1/references/annotation_gtf

for f in `ls $DIR/*.bam | sed 's/.bam//' `
do
stringtie -G $REFERENCE/gencode.v35.annotation.gtf -o ${f}.gtf ${f}.bam 
done

stringtie --merge -G $REFERENCE/gencode.v35.annotation.gtf -o stringtie_merged.gtf mergelist.txt

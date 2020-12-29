#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=30000M
#SBATCH --time=24:00:00

module add UHTS/Analysis/samtools/1.10

for f in `ls /data/courses/rnaseq/lncRNAs/Project1/michele/hisat2/*.bam | sed 's/.bam//' `
do
samtools sort ${f}.bam -o ${f}.sorted.bam
done

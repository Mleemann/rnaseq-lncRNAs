#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=04:00:00

module add UHTS/Analysis/samtools/1.10;

DIR=/data/courses/rnaseq/lncRNAs/Project1/michele/hisat2

cd $DIR

for f in `ls $DIR/*_1.sorted.bam | sed 's/_1.sorted.bam//' `
do
samtools merge ${f}.bam ${f}_1.sorted.bam ${f}_2.sorted.bam ${f}_3.sorted.bam
done

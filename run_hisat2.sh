#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=24:00:00

module add UHTS/Aligner/hisat/2.2.1
module add UHTS/Analysis/samtools/1.10

DIR=/data/courses/rnaseq/lncRNAs/Project1/michele/fastq/merged_fastq
INDEX=/data/courses/rnaseq/lncRNAs/Project1/references/hisat_index/

for f in `ls $DIR/*_R1.fastq.gz | sed 's/_R1.fastq.gz//' `
do
hisat2 -p 4 --dta -x hg38 -1 ${f}_R1.fastq.gz -2 ${f}_R2.fastq.gz -S ${f}.sam
samtools view -bS ${f}.sam > ${f}.bam
rm ${f}.sam
done

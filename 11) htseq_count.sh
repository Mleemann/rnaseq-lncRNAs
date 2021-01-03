#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=24:00:00

module add UHTS/Analysis/HTSeq/0.9.1

BAM=/data/courses/rnaseq/lncRNAs/Project1/michele/hisat2
GTF=/data/courses/rnaseq/lncRNAs/Project1/michele/stringtie

for f in `ls $BAM/*.sorted.bam`
do
htseq-count -f bam --additional-attr=gene_name ${f} $GTF/stringtie_merged.gtf -s no > ${f}.txt
mv ${f}.txt /data/courses/rnaseq/lncRNAs/Project1/michele/htseq_count2
done

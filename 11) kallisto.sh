#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=24:00:00

module add UHTS/Analysis/kallisto/0.46.0

OUTDIR=/data/courses/rnaseq/lncRNAs/Project1/michele/kallisto2
GTF=/data/courses/rnaseq/lncRNAs/Project1/michele/stringtie/stringtie_merged.gtf

for f in `ls /data/courses/rnaseq/lncRNAs/Project1/michele/fastq/merged_fastq/*_R1.fastq.gz | sed 's/_R1.fastq.gz//' `
do
kallisto quant -t 4 -i hg38.transcript.idx -b 100 -o ${f} --genomebam --gtf $GTF ${f}_R1.fastq.gz ${f}_R2.fastq.gz
mv ${f} $OUTDIR
done

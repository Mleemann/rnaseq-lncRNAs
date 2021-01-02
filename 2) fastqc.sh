#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=02:00:00

module add UHTS/Quality_control/fastqc/0.11.7

DIR=/data/courses/rnaseq/lncRNAs/Project1/michele/fastq/merged_fastq/
OUTDIR=/data/courses/rnaseq/lncRNAs/Project1/michele/fastqc/

for f in `ls $DIR*.fastq.gz | sed 's/.fastq.gz//' `
do
fastqc -t 2 ${f}.fastq.gz
done

mv $DIR*fastqc* $OUTDIR

cd $OUTDIR

module add UHTS/Analysis/MultiQC/1.8

multiqc .

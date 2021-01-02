#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000M
#SBATiCH --time=02:00:00

DIR=/data/courses/rnaseq/lncRNAs/Project1/michele/fastq

for f in `ls $DIR/*_L1_R1.fastq.gz | sed 's/_L1_R1.fastq.gz//' `
do
cat ${f}_L1_R1.fastq.gz ${f}_L2_R1.fastq.gz > ${f}_R1.fastq.gz
cat ${f}_L1_R2.fastq.gz ${f}_L2_R2.fastq.gz > ${f}_R2.fastq.gz
done
